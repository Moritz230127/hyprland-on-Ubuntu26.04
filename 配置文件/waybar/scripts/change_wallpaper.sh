#!/bin/bash

# 1. 在这里填入你存放壁纸的指定文件夹绝对路径
WALLPAPER_DIR="$HOME/Pictures/Wallpapers"

# 检查文件夹是否存在
if [ ! -d "$WALLPAPER_DIR" ]; then
    notify-send "错误" "壁纸文件夹不存在: $WALLPAPER_DIR"
    exit 1
fi

# 2. 从文件夹中查找所有的常规图片文件，并随机挑选一张
RANDOM_PIC=$(find "$WALLPAPER_DIR" -type f \( -iname \*.jpg -o -iname \*.jpeg -o -iname \*.png -o -iname \*.gif \) | shuf -n 1)

if [ -z "$RANDOM_PIC" ]; then
    notify-send "错误" "在 $WALLPAPER_DIR 中没有找到图片"
    exit 1
fi

# 3. 使用 swww 切换壁纸 (启用 random 随机盲盒动画，60帧，持续1.5秒)
swww img "$RANDOM_PIC" \
    --transition-type random \
    --transition-fps 60 \
    --transition-duration 1.5

