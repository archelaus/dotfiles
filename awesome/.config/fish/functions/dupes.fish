function dupes
    jdupes . -rS
    # find ! -empty -type f -exec md5sum {} + | sort | uniq -w32 -dD
    # fd -S+0b -tf -x md5sum | sort | uniq -w32 -dD
    # for small files, https://github.com/sharkdp/fd/issues/1090
    # fd -S+0b -tf -X md5sum | sort | uniq -w32 -dD
end
