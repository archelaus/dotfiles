function gdown
    read -P "Enter the link: " link
    drivedlgo --conn 2 "$link"
end
