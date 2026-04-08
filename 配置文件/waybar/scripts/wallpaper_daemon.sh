#!/bin/bash

sleep 0.5
# 1. 在这里填入你存放壁纸的指定文件夹路径
WALLPAPER_DIR="$HOME/Pictures/Wallpapers"

# 切换壁纸的核心函数
change_wallpaper() {
    # 检查文件夹是否存在
    if [ ! -d "$WALLPAPER_DIR" ]; then
        echo "壁纸文件夹不存在: $WALLPAPER_DIR"
        return
    fi

    # 随机挑选一张图片
    RANDOM_PIC=$(find "$WALLPAPER_DIR" -type f \( -iname \*.jpg -o -iname \*.jpeg -o -iname \*.png -o -iname \*.gif \) | shuf -n 1)

    # 执行 swww 切换 (盲盒动画，1.5秒过渡)
    if [ -n "$RANDOM_PIC" ]; then
        swww img "$RANDOM_PIC" \
            --transition-type random \
            --transition-fps 60 \
            --transition-duration 1.5
    fi
}

# 2. 核心魔法：捕获系统信号 (SIGUSR1)
# 当收到这个信号时，它会立刻打断下面的 wait 命令
trap 'echo "收到 Waybar 点击信号，重置计时器..."' SIGUSR1

# 3. 主循环：无冲突倒计时
while true; do
    change_wallpaper
    
    # 倒计时 60 秒 (放在后台并用 wait 等待，这样才能被 trap 随时打断)
    sleep 60 &
    wait $!
done
