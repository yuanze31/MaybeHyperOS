MODDIR=${0%/*}

# 查找开机动画目录
findBootAnimation() {
    if [[ -f "/system/product/media/bootanimation.zip" ]]; then
        echo /system/product/media/
    elif [[ -f "/system/media/bootanimation.zip" ]]; then
        echo /system/media/
    else
        ui_print "- 没有检测到开机动画"
        exit 1
    fi
}

# 确定是否为Pad
distinguishPad() {
    if [[ -f "/system/product/media/bootanimation01.zip" ]]; then
        echo 0
    elif [[ -f "/system/media/bootanimation01.zip" ]]; then
        echo 0
    else
        ui_print "- 非Pad"
        exit 1
    fi
}

# 开机动画目录
bootAnimationPath=$(findBootAnimation)
ispad=$(distinguishPad)
ui_print "- 您的开机动画位于: $bootAnimationPath"
if [ispad == 0]; then
    ui_print "- 您的设备属于平板"
fi
bootAnimationRootPath=$bootAnimationPath
bootAnimationPath=$MODPATH/$bootAnimationPath

# 设置模块目录权限
ui_print "- 设置模块目录权限"
chmod -R 0777 $MODPATH/*

# 进入模块目录 & 创建文件夹
cd $MODPATH
mkdir -p $bootAnimationPath

# 移动开机动画到模块目录并设置权限
mv ./bootanimation.zip $bootAnimationPath/
if [ispad == 0]; then
    mv ./bootanimation01.zip $bootAnimationPath/
    mv ./bootanimation02.zip $bootAnimationPath/
    mv ./bootanimation03.zip $bootAnimationPath/
    mv ./bootanimation04.zip $bootAnimationPath/
fi
chmod 0644 $bootAnimationPath/bootanimation.zip
if [ispad == 0]; then
    chmod 0644 $bootAnimationPath/bootanimation01.zip
    chmod 0644 $bootAnimationPath/bootanimation02.zip
    chmod 0644 $bootAnimationPath/bootanimation03.zip
    chmod 0644 $bootAnimationPath/bootanimation04.zip
fi
ui_print "- 成功应用开机动画"

# 移动开机音乐到模块目录并设置权限
mv ./bootaudio.mp3 $bootAnimationPath/
chmod 0644 $bootAnimationPath/bootaudio.mp3
ui_print "- 成功应用开机音乐"

# 预览开机动画
previewBootAnimation

ui_print "- 模块安装成功，快重启看看效果吧！"
