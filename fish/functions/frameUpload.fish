#
# Helper to crop, downsize, and upload a photo to cubby, to
# be picked up by my connected photo frames.
# Firmware: https://aitjcize.github.io/esp32-photoframe/
#

function frameUpload --description 'Crop a photo to the photo frame shape and upload it to cubby'
    # Usage: frameUpload [-g|--gravity GRAVITY] PHOTO
    #   Crops the photo to the frame's 3:5 portrait shape at 960x1600 (twice
    #   the panel's resolution, so the frame's own downscale smooths out JPEG
    #   artifacts), then uploads it. GRAVITY picks which part survives the
    #   crop: center (default), north, south, east, west, northeast, ...
    # Needs $CUBBY_USERNAME and $CUBBY_PASSWORD. $CUBBY_URL overrides the server.
    argparse -n frameUpload 'g/gravity=' 'h/help' -- $argv
    or return 2

    if set -q _flag_help; or test (count $argv) -ne 1
        echo "usage: frameUpload [-g|--gravity GRAVITY] PHOTO" >&2
        set -q _flag_help; and return 0
        return 2
    end

    set -l photo $argv[1]
    set -l gravity center
    set -q _flag_gravity; and set gravity $_flag_gravity
    set -l server https://cubby.dsouza.io
    set -q CUBBY_URL; and set server (string trim -r -c / -- $CUBBY_URL)

    if not test -f "$photo"
        echo "frameUpload: no such file: $photo" >&2
        return 1
    end
    if not command -q magick
        echo "frameUpload: magick not found (brew install imagemagick)" >&2
        return 1
    end
    if not set -q CUBBY_USERNAME; or not set -q CUBBY_PASSWORD
        echo "frameUpload: set CUBBY_USERNAME and CUBBY_PASSWORD" >&2
        return 1
    end

    # photo.HEIC -> photo-frame.jpg, next to the original
    set -l out (string replace -r '\.[^./]*$' '' -- $photo)-frame.jpg
    magick $photo -auto-orient -resize '960x1600^' -gravity $gravity -extent 960x1600 \
        -quality 92 -strip $out
    or begin
        echo "frameUpload: image conversion failed" >&2
        return 1
    end

    # Credentials go to curl on stdin, not argv, so they don't show up in `ps`
    set -l user (string replace -a '\\' '\\\\' -- "$CUBBY_USERNAME:$CUBBY_PASSWORD" | string replace -a '"' '\\"')
    set -l code (printf 'user = "%s"\n' $user | curl -K - -sS -o /dev/null -w '%{http_code}' \
        -X POST -H 'Content-Type: image/jpeg' --data-binary @$out $server/photoframe)
    or begin
        echo "frameUpload: upload failed (network error)" >&2
        return 1
    end

    switch $code
        case 200
            echo "Uploaded $out ("(math -s0 (wc -c < $out) / 1024)" KB) to $server/photoframe"
        case 401
            echo "frameUpload: 401 Unauthorized, check CUBBY_USERNAME/CUBBY_PASSWORD" >&2
            return 1
        case '*'
            echo "frameUpload: upload failed with HTTP $code" >&2
            return 1
    end
end

