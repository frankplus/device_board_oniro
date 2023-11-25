# 【开发板名称】树莓派4b

**![树莓派](pictures/rpi4.png)**

**版本特性**

- 适配GPU

**一、搭建开发环境**

**1、安装依赖工具**

安装命令如下：

```
sudo apt update&&sudo apt install -y openjdk-8-jre gcc-arm-linux-gnueabihf binutils git git-lfs gnupg flex bison gperf build-essential zip curl zlib1g-dev gcc-multilib g++-multilib libc6-dev-i386 lib32ncurses5-dev x11proto-core-dev libx11-dev lib32z-dev ccache libgl1-mesa-dev libxml2-utils xsltproc unzip ruby m4 wget bc python python3 libssl-dev mtools gnutls-bin device-tree-compiler libtinfo5
```

如果使用docker还需要加上以下内容：
```
apt install -y nodejs python3-pip dosfstools
```

**说明：** 
以上安装命令适用于Ubuntu20.04，其他版本请根据安装包名称采用对应的安装命令。

**2、获取标准系统源码**

**前提条件**

1）注册码云gitee账号并配置用户信息
```
git config --global user.name "yourname"

git config --global user.email "your-email-address"
```

2）安装码云repo工具，可以执行如下命令。

```
curl https://gitee.com/oschina/repo/raw/fork_flow/repo-py3 | sudo tee /usr/local/bin/repo >/dev/null &&sudo chmod a+x /usr/local/bin/repo &&sudo ln -sf bash /bin/sh
```

**获取源码操作步骤**

通过repo + https 下载。

```
（这里链接需要替换）
repo init -u https://gitee.com/d1124/manifest.git -b OpenHarmony-3.2-Beta1 -m chipsets/raspberrypi3.xml -g ohos:standard --no-repo-verify --depth=1

repo sync -c

repo forall -c 'git lfs pull'
```

**执行prebuilts**

在源码根目录下执行脚本，安装编译器及二进制工具。

```
./build/prebuilts_download.sh
```

下载的prebuilts二进制默认存放在与OpenHarmony同目录下的OpenHarmony_2.0_canary_prebuilts下。

**二、编译和烧录**

**1、编译**

在Linux环境进行如下操作:

进入以下目录，手动应用对应的build，fingerprint_auth，graphic_2d补丁
device/board/iscas/rpi4/patches

进入源码根目录，执行如下命令进行版本编译。
先输入：
```
./build.sh --product-name rpi4 --ccache --no-prebuilt-sdk
```
完成后再输入：
```
./build.sh --product-name rpi4 --ccache --no-prebuilt-sdk --build-target rpi_image
```


编译所生成的文件都归档在out/rpi4/目录下，结果镜像输出在
out/rpi4/packages/phone/images/ 目录下。

3） 编译源码完成，请进行镜像烧录。

**2、烧录工具**

烧录需要用到至少16G的TF卡和一个读卡器。

首先使用SDCardFormatter格式化TF卡，之后使用Win32DiskImager烧写out/rpi4/packages/phone/images/路径下的firmware.img文件。

[SDCardFormatter](https://www.sdcardformatter.com/download/)

[Win32DiskImager](https://win32diskimager.org/#download)

**三、调试**

**1、连接串口**

串口引脚图如下：
**![串口引脚图](pictures/rpi4ck.png)**
1、连接图中6、8、10三个引脚。
2、打开Xshell，新建会话，在连接的协议中选择SERIAL。
3、转到串口标签，选择正确的端口号，波特率115200，完成后即可连接。


**3、使用HDC工具**

使用HDC工具(命令)：
```
(1)hdc_std shell:进入命令行
(2)hdc_std file send {本地系统文件路径} {oh系统文件路径}:发送文件
(3)hdc_std file recv {oh系统文件路径} {本地系统文件路径}:接收文件
(4)hdc_std install XXX.hap:安装hap包
```

**四、联系**

[Diemit](https://gitee.com/diemit)



