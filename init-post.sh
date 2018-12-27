#! /bin/sh

# define global variable
BLOG_PATH=~/blog/hongsii.github.io
TEMP_POST_PATH=$BLOG_PATH/_drafts


read -p "타이틀 : " title

post=$TEMP_POST_PATH/$title.md
if [ -f $post ]; then
    echo "동일한 이름의 포스트가 존재합니다."
    ls $TEMP_POST_PATH
    exit 1
fi

read -p "설명 : " description
read -p "날짜(YYYY-MM-DD HH24:MI) : " date
read -p "카테고리 : " category
read -p "태그 : " input_tags
IFS=' ' read -a tags <<< "$input_tags"

formatted_tags=""
for tag in ${tags[@]}
do
    formatted_tags+="  - $tag"$'\n'
done

#touch $post

#ls $post
cat <<EOT >> $post
---
layout: 'post'
title: '$title'
description: '$description'
date: '$date'
categories:
  - $category
tags:
$formatted_tags
---
EOT