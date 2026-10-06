#
# Helper to crop, downsize, and upload a photo to cubby, to
# be picked up by my connected photo frames.
# Firmware: https://aitjcize.github.io/esp32-photoframe/
#

function frameUpload --description 'Crop a photo for the photo frame and upload it to cubby'
    # Usage: frame-upload PHOTO [GRAVITY]
    #   GRAVITY picks which part of the photo survives the crop:
    #   center (default), north, south, east, west, northeast, ...
    # Needs $CUBBY_USERNAME and $CUBBY_PASSWORD. $CUBBY_URL overrides the server.
    set -l photo $argv[1]
    set -l gravity center
    set -q argv[2]; and set gravity $argv[2]
    set -l server https://cubby.dsouza.io
    set -q CUBBY_URL; and set server (string trim -r -c / -- $CUBBY_URL)

    if test (count $argv) -lt 1; or test (count $argv) -gt 2
        echo "usage: frame-upload PHOTO [GRAVITY]" >&2
        return 2
    end
    if not test -f "$photo"
        echo "frame-upload: no such file: $photo" >&2
        return 1
    end
    if not command -q magick
        echo "frame-upload: magick not found (brew install imagemagick)" >&2
        return 1
    end
    if not set -q CUBBY_USERNAME; or not set -q CUBBY_PASSWORD
        echo "frame-upload: set CUBBY_USERNAME and CUBBY_PASSWORD" >&2
        return 1
    end

    # photo.HEIC -> photo-frame.jpg, next to the original
    set -l out (string replace -r '\.[^./]*$' '' -- $photo)-frame.jpg

    magick $photo -auto-orient -resize '480x800^' -gravity $gravity -extent 480x800 \
        -quality 90 -strip $out
    or begin
        echo "frame-upload: image conversion failed" >&2
        return 1
    end
    echo "Wrote $out ("(math -s0 (wc -c < $out) / 1024)" KB)"

    # Credentials go to curl on stdin, not argv, so they don't show up in `ps`
    set -l user (string replace -a '\\' '\\\\' -- "$CUBBY_USERNAME:$CUBBY_PASSWORD" | string replace -a '"' '\\"')
    set -l code (printf 'user = "%s"\n' $user | curl -K - -sS -o /dev/null -w '%{http_code}' \
        -X POST -H 'Content-Type: image/jpeg' --data-binary @$out $server/photoframe)
    or begin
        echo "frame-upload: upload failed (network error)" >&2
        return 1
    end

    switch $code
        case 200
            echo "Uploaded to $server/photoframe"
        case 401
            echo "frame-upload: 401 Unauthorized, check CUBBY_USERNAME/CUBBY_PASSWORD" >&2
            return 1
        case '*'
            echo "frame-upload: upload failed with HTTP $code" >&2
            return 1
    end
end
