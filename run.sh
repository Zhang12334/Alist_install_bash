#!/bin/bash

# 下载地址
download_url="Zhang12334/Alist_install_bash/releases/latest/download/install.sh"
test_file_url="https://github.com/Zhang12334/test_ghmirror/releases/latest/download/test.txt"

# 清屏
clear
echo "请选择是否使用Github加速地址"
echo "1. 使用 https://ghp.ci/"
echo "2. 使用 https://ghproxy.net/"
echo "3. 使用 https://ghproxy.cn/"
echo "4. 使用 https://github.moeyy.xyz/"
echo "5. 使用 https://gh.llkk.cc/"
echo "6. 自定义加速地址"
echo "7. 不使用加速地址"
echo
read -p "请输入你的选择: " choice1

# 根据用户选择设置代理
case $choice1 in
    1) useproxy="https://ghp.ci/https://github.com/" ;;
    2) useproxy="https://ghproxy.net/https://github.com/" ;;
    3) useproxy="https://ghproxy.cn/https://github.com/" ;;
    4) useproxy="https://github.moeyy.xyz/https://github.com/" ;;
    5) useproxy="https://gh.llkk.cc/https://github.com/" ;;
    6) 
        read -p "请输入自定义加速地址: " custom_proxy
        # 验证自定义加速地址是否有效
        if curl -fsSL "${custom_proxy}${test_file_url}" | grep -q "114514"; then
            rm -f test.txt
            useproxy="${custom_proxy}https://github.com/"
            echo "已选择自定义加速地址: $custom_proxy"
        else
            rm -f test.txt
            echo "自定义加速地址无效，自动使用https://ghp.ci/加速地址"
            useproxy="https://ghp.ci/https://github.com/" 
        fi
        ;;
    7) useproxy="https://github.com/" ;;
    *) 
        echo "无效的选择，默认使用https://ghp.ci/加速地址"
        useproxy="https://ghp.ci/https://github.com/" 
        ;;
esac

echo "请选择操作："
echo "1. 安装"
echo "2. 卸载"
echo "3. 升级"
echo -n "请输入你的选择: "
read choice
case "$choice" in
    1) 
        echo "正在安装..."
        curl -fsSL -L "${useproxy}${download_url}" | bash -s install "$useproxy"
        ;;
    2) 
        echo "正在卸载..."
        curl -fsSL -L "${useproxy}${download_url}" | bash -s uninstall
        ;;
    3) 
        echo "正在升级..."
        curl -fsSL -L "${useproxy}${download_url}" | bash -s update "$useproxy"
        ;;
    *) 
        echo "无效的选择，请输入1-3的数字"
        exit 1 
        ;;
esac
