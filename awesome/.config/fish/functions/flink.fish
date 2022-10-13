function flink
	set -l id (echo "$argv[1]" | grep -oP "([\w-]){33}|([\w-]){19}")
    fclone link gc:\{$id\} | xclip -selection clipboard && echo "Copied to clipboard 👍"
end
