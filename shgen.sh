#!/bin/sh

[ "$#" -lt 3 ] && {
    echo "Usage: shgen <file_name1, file_name2 ... > <shell>"
    exit 1
}

# Check to see if final argument is a valid shell.
for shell in "$@"; do :; done
command -v "$shell" >/dev/null || {
    echo "$shell not a valid shell!"
    exit 1
}
i=1
for file in "$@"; do
    [ "$i" = "$#" ] && continue
    [ -f "$file.sh" ] && {
        echo "$file.sh already exists, skipping!"
        continue
    }
    echo "#!$(command -v $shell)" > "$file".sh
    chmod +x $file.sh
    i=$((i + 1))
done
