function ftree
	set -l id (echo "$argv[1]" | grep -oP "([\w-]){33}|([\w-]){19}")
    fclone tree ddlbottd:\{$id\}
end
