#! /bin/sh

# check argument
if [[ -z $1 ]]; then
	echo "Please add argument > menu name (only lowercase)"
	exit 1
fi


# echo "=====" $1 "add start ====="
# add menu to config
#sed '/lastmenu/i\
#     - title: '"$1"' \
#       url: '"$1"'  \
#       sublink: true  \
#' _config.yml > _temp_config.yml

# echo "add menu config"

# change config file
#rm _config.yml | mv _temp_config.yml _config.yml

# copy template and change menu title, link
cp temp/add_menu.html categories/"$1".html
sed -i -- 's/change_here/'"$1"'/g' categories/"$1".html

echo "copy and change menu name"

# delete temp file and move html file to categories directory
rm categories/"$1".html-- 

echo "move file"
echo "===== End ====="
