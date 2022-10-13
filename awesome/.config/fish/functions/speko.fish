function speko
    set -l noext (string split -r -m1 . "$argv[1]")[1]
    set -l ext (string split -r -m1 . "$argv[1]")[2]
    set -l title (echo "Track: ["$ext"]" $noext)
    sox "$argv[1]" -n channels 1 spectrogram -t $title -c BearWithMe -w kaiser -o $noext.png
end
