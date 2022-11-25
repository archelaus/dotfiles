#!/bin/bash

id=$(sed 's|.*gofile.io/d/||g' <<< "$1")
echo "Downloading $id"

#get guest account token for url and cookie
token=$(curl -s 'https://api.gofile.io/createAccount' | jq -r '.data.token' 2>/dev/null)

#get content info from api
resp=$(curl 'https://api.gofile.io/getContent?contentId='"$id"'&token='"$token"'&websiteToken=12345&cache=true' 2>/dev/null)

#load the page once so download links don't get redirected
curl -H 'Cookie: accountToken='"$token" "$1" -o /dev/null 2>/dev/null

for i in $(jq '.data.contents | keys | .[]' <<< "$resp"); do
  name=$(jq -r '.data.contents['"$i"'].name' <<< "$resp")
  url=$(jq -r '.data.contents['"$i"'].link' <<< "$resp")
  echo
  echo "Downloading $name"
  curl -H 'Cookie: accountToken='"$token" "$url" -o "$name"
done
