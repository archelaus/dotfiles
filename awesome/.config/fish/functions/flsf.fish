function flsf
	set -l id (echo "$argv[1]" | grep -oP "([\w-]){33}|([\w-]){19}")
    fclone lsf -d=false ddlbottd:\{$id\}
end
