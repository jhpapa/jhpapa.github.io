#! /bin/bash

set -e
clear

BLOG_PATH=$(pwd -P)
DRAFT_DIR=$BLOG_PATH/_drafts
POST_DIR=$BLOG_PATH/_posts

print_header() {
    local width=60
    local title="P U B L I S H E R" 

    printf '=%.0s' $(seq 1 $width); echo ''
    printf "%*s\n" $(((${#title}+$width)/2)) "$title"
    printf '=%.0s' $(seq 1 $width); echo ''
} >&2
overwrite() { echo -e "\r\033[1A\033[0K$@"; }
publish_post() {
    local select_text="발행할 포스트 : "
    echo $select_text >&2

    local title=$(ls $DRAFT_DIR | fzf --height 20% --layout=reverse --border)
    if [ -z $title ]; then
        echo "please select post for publishing" >&2
        exit 1
    fi
    overwrite $select_text $title >&2
    echo $title
}
input_date() {
    local output_text=$1
    local value=$2
    read -e -p "$1 [$value] : " input >&2
    value=${input:-$value}
    overwrite "$output_text\t: $value" >&2
    echo $value
}


# Main
print_header
if [ ! -d $DRAFT_DIR ]; then
    echo "Not exists directory '_drafts'!!"
    exit 1
elif [ ! -d $POST_DIR ]; then
    echo "Not exists directory '_posts'!!"
    exit 1
fi
title=$(publish_post)
year=$(input_date "연도" $(date +"%Y"))
month=$(input_date "월" $(date +"%m"))
day=$(input_date "일" $(date +"%d"))

publish_post="$year-$month-$day-$title"
#mkdir -p $POST_DIR && cp $DRAFT_DIR/$title "$_/$publish_post"

echo -e "\nSuccess publishing !\n"
echo -e "\t$publish_post\n"
