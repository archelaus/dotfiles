function dead
	curl -sI "https://$argv[1]" | head -n 1
end
