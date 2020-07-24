#! /bin/bash

set -e
clear

BLOG_PATH=$(pwd -P)
DRAFT_DIR=$BLOG_PATH/_drafts

print_header() {
    local width=60
    local title="P U B L I S H E R" 

    printf '=%.0s' $(seq 1 $width); echo ''
    printf "%*s\n" $(((${#title}+$width)/2)) "$title"
    printf '=%.0s' $(seq 1 $width); echo ''
} >&2

print_header
mkdir -p $DRAFT_DIR
read -p $'파일명 : ' file_name 
post=$DRAFT_DIR/$file_name.md
if [ -f $post ]; then
    echo "동일한 이름의 포스트가 존재합니다."
    exit 1
fi

read -p $'제목 : ' title
read -p $'설명 : ' description
read -p $'카테고리 : ' category
read -p $'태그(공백으로 구분) : ' input_tags

IFS=' ' read -a tags <<< "$input_tags"
formatted_tags=""
index=0
for tag in ${tags[@]}
do
    ((++index))
    formatted_tags+="  - $tag"
    if [[ index -ne ${#tags[@]} ]]; then
       formatted_tags+=$'\n' 
    fi
done

cat <<EOT >> $post
---
layout: 'post'
title: '$title'
description: '$description'
date: '$(date +"%Y-%m-%d %H:%M:%S")'
categories:
  - $category
tags:
$formatted_tags
---
EOT

vim $post
