#!/bin/bash

BG_PATH_ORIG="backgrounds"
BG_PATH_DEST="/usr/share/images/desktop-base"

echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<!DOCTYPE wallpapers SYSTEM \"gnome-wp-list.dtd\">
<wallpapers>"

find $BG_PATH_ORIG -iname *.jpg -o -iname *.png | while read F
do
	base_name=$(basename $F)
	# Remove the extension of the file name
	name=${base_name%\.*}
	
	filename=$BG_PATH_DEST/$base_name
	echo "  <wallpaper>
    <name>${name}</name>
    <filename>${filename}</filename>
    <options>wallpaper</options>
  </wallpaper>"
done

echo "</wallpapers>"
