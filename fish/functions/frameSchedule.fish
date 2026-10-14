function frameSchedule --description 'Process a photo for the photo frame, copy it to the server, and schedule it'
    # Usage: frameSchedule [-w|--when WHEN] [-g|--gravity GRAVITY] PHOTO
    #   WHEN: MM-DD, MM-DD..MM-DD, or a named range (always, summer, christmas,
    #   thanksgiving, ...). Defaults to "always" (the fallback pool).
    #   GRAVITY picks which part of the photo survives the crop: center
    #   (default), north, south, east, west, ...

    # --- Configuration ---
    # The photo folder and schedule path come from the server script's own
    # config (photoframe-daily --print-config), so they're set in one place
    set -l server dsouza-server.lan                    # ssh host
    set -l remote_script /home/jason/photoframe/photoframe-daily
    # ---------------------

    argparse -n frameSchedule 'w/when=' 'g/gravity=' 'h/help' -- $argv
    or return 2
    if set -q _flag_help; or test (count $argv) -ne 1
        echo "usage: frameSchedule [-w|--when WHEN] [-g|--gravity GRAVITY] PHOTO" >&2
        set -q _flag_help; and return 0
        return 2
    end

    set -l photo $argv[1]
    set -l when always
    set -q _flag_when; and set when $_flag_when
    set -l gravity center
    set -q _flag_gravity; and set gravity $_flag_gravity

    if not test -f "$photo"
        echo "frameSchedule: no such file: $photo" >&2
        return 1
    end
    if not command -q magick
        echo "frameSchedule: magick not found (brew install imagemagick)" >&2
        return 1
    end

    # Quote a string for the remote (POSIX) shell
    function __frameSchedule_q
        echo "'"(string replace -a "'" "'\\''" -- $argv[1])"'"
    end

    # photo.HEIC -> photo.jpg
    set -l name (string replace -r '\.[^.]*$' '' -- (basename $photo)).jpg
    if string match -qr '^\s|\s$' -- $name
        echo "frameSchedule: file names can't start or end with whitespace: '$name'" >&2
        return 1
    end

    # The server script is the one source of truth for paths and WHEN values
    set -l remote_config (ssh $server (__frameSchedule_q $remote_script) --print-config)
    or begin
        echo "frameSchedule: couldn't read the config of $remote_script on $server" >&2
        return 1
    end
    set -l remote_dir
    set -l remote_schedule
    for line in $remote_config
        set -l kv (string split -m 1 = -- $line)
        switch $kv[1]
            case photo_dir
                set remote_dir $kv[2]
            case schedule
                set remote_schedule $kv[2]
        end
    end
    if test -z "$remote_dir"; or test -z "$remote_schedule"
        echo "frameSchedule: $remote_script --print-config gave no photo_dir/schedule" >&2
        return 1
    end
    set -l remote_photo $remote_dir/$name

    ssh $server (__frameSchedule_q $remote_script) --validate-when (__frameSchedule_q $when)
    or begin
        echo "frameSchedule: not scheduling $name" >&2
        return 1
    end

    if ssh $server test -e (__frameSchedule_q $remote_photo)
        echo "frameSchedule: $name already exists on $server; rename the photo first" >&2
        return 1
    end

    set -l tmp (mktemp -d)
    set -l out $tmp/$name
    magick $photo -auto-orient -resize '960x1600^' -gravity $gravity -extent 960x1600 \
        -quality 92 -strip $out
    or begin
        echo "frameSchedule: image conversion failed" >&2
        rm -rf $tmp
        return 1
    end

    # Copy via a remote `cat` rather than scp, so odd file names need no
    # second layer of escaping
    cat $out | ssh $server "cat > "(__frameSchedule_q $remote_photo)
    or begin
        echo "frameSchedule: copying $name to $server failed" >&2
        rm -rf $tmp
        return 1
    end
    set -l size (math -s0 (wc -c < $out) / 1024)
    rm -rf $tmp

    printf '%-14s %s\n' $when $name | ssh $server "cat >> "(__frameSchedule_q $remote_schedule)
    or begin
        echo "frameSchedule: copied $name but failed to add it to the schedule; add this line by hand:" >&2
        printf '  %-14s %s\n' $when $name >&2
        return 1
    end

    echo "Added $name ($size KB) to $server, scheduled for: $when"
end
