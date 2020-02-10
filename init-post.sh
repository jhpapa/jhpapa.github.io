#! /bin/sh

# define global variable
BLOG_PATH=$(pwd -P)
TEMP_POST_PATH=$BLOG_PATH/_drafts
mkdir -p $TEMP_POST_PATH

echo "파일명"
read file_name 
post=$TEMP_POST_PATH/$file_name.md
echo $post
if [ -f $post ]; then
    echo "동일한 이름의 포스트가 존재합니다."
    ls $TEMP_POST_PATH
    exit 1
fi

echo "제목"
read title
echo "설명"
read  description
echo "날짜(YYYY-MM-DD HH24:MI)"
read  date
echo "카테고리"
read  category
echo "태그(공백으로 구분)"
read  input_tags

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
date: '$date'
categories:
  - $category
tags:
$formatted_tags
---
EOT

vim $post
