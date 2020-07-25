#! /bin/bash

set -e
clear

BLOG_PATH=$(pwd -P)
DRAFT_DIR=$BLOG_PATH/_drafts
POST_DIR=$BLOG_PATH/_posts
if [ ! -d $DRAFT_DIR ]; then
    echo "Not exists directory '_drafts'!!"
    exit 1
elif [ ! -d $POST_DIR ]; then
    echo "Not exists directory '_posts'!!"
    exit 1
fi

print_header() {
    local width=60
    local title="P U B L I S H E R" 

    printf '=%.0s' $(seq 1 $width); echo ''
    printf "%*s\n" $(((${#title}+$width)/2)) "$title"
    printf '=%.0s' $(seq 1 $width); echo ''
} >&2
overwrite() { echo -e "\r\033[1A\033[0K$@"; }
select_post() {
    local title=$(ls $DRAFT_DIR | fzf --height 20% --layout=reverse --border)
    if [ -z $title ]; then
        echo "Please select post for publishing" >&2
        exit 1
    fi
    echo $title
}
publish_post() {
    title=$1
    post="$(date +"%Y-%m-%d")-$title"
    echo ''
    if [ ! -f "$POST_DIR/$post" ]; then
        mkdir -p $POST_DIR && cp $DRAFT_DIR/$title "$_/$post"
        echo "Success publishing !"
        echo -e "\t$post\n"

        read -p "Do you want to remove published post ? " yn
        case $yn in
            [Yy] ) rm $DRAFT_DIR/$title; break;;
            * ) break;;
        esac
    else 
        echo "Already published !"
    fi 
    echo ''
}


print_header
file=$(select_post)

while true; do
    read -p "Do you want to publish '$file' ? " yn
    case $yn in
        [Yy] ) publish_post "$file"; break;;
        [Nn] ) echo -e '\nCancel publishing !\n'; break;;
        * ) echo "You should enter yes or no !";;
    esac
done


