说在前面

这个项目适用于,无法忍受kindle自身的Linux环境的人。
比如像我，只是想在Kindle上做一些轻量化的代码编辑工作，但是只要了解过的人都知道kindle上的Linux环境是个残废。
为了能随时方便的码字，诞生了这个项目。

有些人对kindle的机能以及该项目的运行提出了疑问，认为在kindle上运行Debian系统会十分卡顿。
在kindle开机后所运行的服务中，存在一个名为lab126_gui的服务。这个服务构成了Kindle的gui。
因此可以通过某些手段来结束这个服务后运行debian系统。
是个坑，可能会在下一次版本的更新中填上。

我本来想编写一个服务，在Kindle开机时运行stop lab126_gui后运行kterm，但是kterm的运行需要lab126_gui拉起的各种服务依赖，放弃。
另一个思路，在结束lab126_gui后挂载Debian镜像，在Debian中运行kterm，但是存在各种问题（具体请见https://github.com/bfabiszewski/kterm/issues/26），与kterm的作者交谈后我选择了一个有点曲折的方法。
在这里我需要介绍一个命令nohup，可以不挂起的运行指令。当我们在lab126_gui中运行stop lab126_gui时gui所提供的所有窗口将关闭，无法执行kterm。但使用nohup xxx.sh就可以无视终端挂起，继续运行指令。

为了方便运行，我写了一个KUAL插件，只需要解压到/mnt/us/extensions/，并将Debian镜像移动到目录内sys即可。

视频介绍：https://www.bilibili.com/video/BV1c94y1R72e?spm_id_from=333.999.0.0

关于

这是一个可以让你在 Kindle 上挂载 Debian 环境的程序或者脚本。

过程

你需要做的第一件事就是越狱你的 Kindle 。越狱过程涉及允许将未签名的应用程序安装到您的Kindle。推荐的方法https://bookfere.com/post/970.html
然后在你的 Kindle 上面安装 Kterm ，你可以在以下网址上找到它。

https://bookfere.com/post/98.html

https://github.com/bfabiszewski/kterm/releases

安装完成后，你就拥有了一个在 Kindle 上的终端。安装 Debian 前需要生成一个适合你设备的 Debian 映像。

你需要在一个合适的 Linux 系统上面执行 MakeImage.sh 并且等待他完成（根据国家的不同这个脚本有两个版本，内容上只有关于镜像网站的改变，可以让你更快的下载镜像，并且后期的 apt 也会更改为对应的镜像网站。）

首先你要确定在你的Linux系统上面拥有 debootstrap，在Ubuntu等系统上，你可以通过 sudo apt-get install debootstrap 来获得它。

值得一提的是，大部分版本的Kindle它的内存只有8G，所以我设置的默认 ext3 分区大小为1GB如果你拥有 Kindle pw 4等拥有32G高内存的机器,你可以修改 MakeImage.sh 脚本中 'dd if=/dev/zero of=debian.ext3 bs=1M count=1024' 把其中的 1024 换成你想要的大小(单位是M)。

在没有报错的完成这个脚本后你将会得到一个名为 debian.ext3 的分区文件。
现在，将文件移动到Kindle的根目录（用计算机打开 Kindle 的目录为根目录，即 Kinale 系统上的 /mnt/us/ 目录）

需要移动的文件有：

debian.ext3

RunBeforeDebian.sh

RunDebian.sh

UpdateInitScript.sh

在你的 Kindle 终端输入：

cd /mnt/us

进入根目录。

./RunDebian.sh --root

进入单用户模式 Debian 的单用户模式。

cd /debootstrap

./debootstrap --second-stage

完成 Debian 系统的安装。

（如果你在这里失败了，键入 CTRL-D 退出单用户模式，并从./RunDebian.sh --r开始）

passwd

修改你的root用户密码。

CTRL-D

退出单用户模式。

./RunDebian.sh

用root账号登录Debian。

adduaer uasrname

创建一个新用户。

apt-get install sudo

apt-get install vim

vim /etc/sudoers

编辑配置文件。

xxx ALL=(ALL) ALL

增加配置, 在打开的配置文件中，找到root ALL=(ALL) ALL, 在下面添加一行。

其中xxx是你要加入的用户名称。

CTRL-D

退出单用户模式。

./RunBeforeDebian.sh

现在你可以通过键 debian 入来进入 Debian 系统。

debian --root 进入单用户模式


如果你有任何问题，可以通过邮箱与我取得联系。

jex.zucker@outlook.com

2846554322@qq.com`

(笔者是学生，可能会出现一个月才能恢复的情况。。)
