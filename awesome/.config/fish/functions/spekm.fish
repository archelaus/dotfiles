function spekm
	ffmpeg -loglevel quiet -i "$argv[1]" -lavfi showspectrumpic=s=1024x1024:color=rainbow out.png -y
end
