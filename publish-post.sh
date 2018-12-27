#! /bin/sh

clear

# define global variable
BLOG_PATH=~/blog/hongsii.github.io
TEMP_POST_PATH=$BLOG_PATH/_drafts
POST_PATH=$BLOG_PATH/_posts

echo "$TEMP_POST_PATH 작성된 포스트"
echo "--------------------------------------------------------"
ls $TEMP_POST_PATH
echo "--------------------------------------------------------\n"

read -p "배포할 포스트 파일명 : " title
read -p "연도 : " year
read -p "월 : " month
read -p "일 : " day

title="$title.md"
publish_path=$POST_PATH/$year/$month
publish_post="$year-$month-$day-$title"
mkdir -p $publish_path && cp $TEMP_POST_PATH/$title "$_/$publish_post"
ls $publish_path/$publish_post
