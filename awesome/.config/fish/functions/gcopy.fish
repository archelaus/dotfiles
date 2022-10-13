function gcopy --description "gd-utils wrapper"
	set --local options 'f/file' 'n/name' 'S/service_account' 'D/dncnr' 'h/help'
	
	argparse $options -- $argv
	
	if set --query _flag_h
		"/mnt/Misc./Softwares/Cool GH/gd-utils"/copy $src_id $dest_id -h
    	return 0
  	end
  	
    read -P "Source: " src
    read -P "Destination: " dest
    set -l src_id (echo "$src" | grep -oP "([\w-]){33}|([\w-]){19}")
    set -l dest_id (echo "$dest" | grep -oP "([\w-]){33}|([\w-]){19}")
    
    if set --query _flag_f
		"/mnt/Misc./Softwares/Cool GH/gd-utils"/copy $src_id $dest_id -f
    	return 0
  	end
  	
  	if set --query _flag_n
		"/mnt/Misc./Softwares/Cool GH/gd-utils"/copy $src_id $dest_id -n $_flag_n
    	return 0
  	end
  	
  	if set --query _flag_S
		"/mnt/Misc./Softwares/Cool GH/gd-utils"/copy $src_id $dest_id -S
    	return 0
  	end
  	
  	if set --query _flag_D
		"/mnt/Misc./Softwares/Cool GH/gd-utils"/copy $src_id $dest_id -D
    	return 0
  	end
  	
  	"/mnt/Misc./Softwares/Cool GH/gd-utils"/copy $src_id $dest_id
end
