#!/bin/sh

[ "$#" -lt 2 ] && {
    echo "Usage: shgen <file_name1, file_name2 ... > <interpreter>"
    exit 1
}

# Check to see if final argument is a valid interpreter.
for interpreter in "$@"; do :; done
command -v "$interpreter" >/dev/null || {
    echo "$interpreter not a valid shell!"
    exit 1
}

[ "$interpreter" = "sh" ] && {
    fileExtension=".sh"
}
[ "$interpreter" = "python" ] && {
    fileExtension=".py"
}
[ "$interpreter" = "python3" ] && {
    fileExtension=".py"
}
[ "$interpreter" = "node" ] && {
    fileExtension=".js"
}
# Check to see if the file extension is valid.
[ "$fileExtension" = "" ] && {
    echo "Invalid interpreter!"
    exit 1
}

i=1
for file in "$@"; do
    [ "$i" = "$#" ] && continue
    [ -f "$file""$fileExtension" ] && {
        echo "$file"$fileExtension" already exists, skipping!"
        continue
    }
    echo "#!$(command -v $interpreter)" > "$file""$fileExtension"
    chmod +x $file$fileExtension
    i=$((i + 1))
done
