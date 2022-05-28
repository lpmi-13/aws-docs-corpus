#!/bin/sh

FOLDER_NAME=docs

[ -d $FOLDER_NAME ] || mkdir $FOLDER_NAME

cd $FOLDER_NAME

for number in 1 2 3; do
  curl "https://api.github.com/users/awsdocs/repos?per_page=100&page=$number" -o "urls$number.txt"
  cat "urls$number.txt" | jq .[].ssh_url >> clone_urls.txt
done

cat clone_urls.txt | xargs -L1 git clone --depth=1

# and then delete this, since we don't need it
rm -rf .github
