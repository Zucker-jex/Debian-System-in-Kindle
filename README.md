视频介绍：https://www.bilibili.com/video/BV1c94y1R72e?spm_id_from=333.999.0.0

关于

这是一个可以让你在 Kindle 上挂载 Debian 环境的程序或者脚本。

过程

你需要做的第一件事就是越狱你的 Kindle 。越狱过程涉及允许将未签名的应用程序安装到您的Kindle。推荐的方法https://bookfere.com/post/970.html
然后在你的 Kindle 上面安装 KTerm ，你可以在以下网址上找到它。

https://bookfere.com/post/98.html

https://github.com/bfabiszewski/kterm/releases

安装完成后，你就拥有了一个在 Kindle 上的终端。安装 Debian 前他您需要生成一个适合您设备的 Debian 映像。

你需要在一个合适的 Linux 系统上面执行 MakeImage.sh 并且等待他完成（根据国家的不同这个脚本有两个版本，内容上只有关于镜像网站的改变，可以让你更快的下载镜，并且后期的 apt 也会更改为对应的镜像网站。）

首先你要确定在你的Linux系统上面拥有 debootstrap，在Ubuntu等系统上，你可以通过 sudo apt-get install debootstrap 来获得它。

值得一提的是，大部分版本的Kindle它的内存只有8G所以我设置的默认 ext3 分区大小为1GB（1024b）如果你拥有 KIndle pw 4等拥有32G高内存的机器,你可以修改 MakeImage.sh 脚本中 'dd if=/dev/zero of=debian.ext3 bs=1M count=1024' 把其中的 1024 换成你想要的大小(单位是B)。

在没有报错的完成这个脚本后你将会得到一个名为分 debian.ext3 的区文件。(我会提供一个可以在中国很好使用的使用中国科学技术大学镜像的分区大小为3G的 debian.ext3 文件。）
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

cd /deboostrap

./deboostrap --second-stage

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

2846554322@qq.com

(笔者是学生，可能会出现一个月才能恢复的情况。。。）

中国科学技术大学镜像 debian.ext3

https://zuckertechnology-my.sharepoint.com/:u:/g/personal/jex_zuckertechnology_onmicrosoft_com/EaR1UOgokNFMvouAFbJusMkBO6K1-DHbyi0XutucueQnfg?e=8UFi6V



about

This is a program or script that allows you to mount a Debian environment on your Kindle.

process

The first thing you need to do is jailbreak your Kindle. The jailbreaking process involves allowing unsigned apps to be installed to your Kindle. Recommended method https://bookfere.com/post/970.html
Then install KTerm on your Kindle, you can find it here.

https://bookfere.com/post/98.html

https://github.com/bfabiszewski/kterm/releases

Once installed, you have a terminal on your Kindle. Before installing Debian you need to generate a Debian image suitable for your device.

You need to execute MakeImage.sh on a suitable Linux system and wait for it to complete (there are two versions of this script depending on the country, the content only changes about the mirror website, which allows you to download the mirror faster, and later apt will also be changed to the corresponding mirror site.)

First you have to make sure you have debootstrap on your Linux system. On Ubuntu and other systems, you can get it by sudo apt-get install debootstrap .

It is worth mentioning that most versions of Kindle have only 8G memory, so I set the default ext3 partition size to 1GB (1024b). If you have a machine with 32G high memory such as KIndle pw 4, you can modify the MakeImage.sh script In 'dd if=/dev/zero of=debian.ext3 bs=1M count=1024' replace 1024 with the size you want (unit is B).

After completing this script without errors you will get a partition file named debian.ext3. (I will provide a debian.ext3 file with a partition size of 3G using the University of Science and Technology of China mirror that can be used well in China.)
Now, move the file to the root directory of the Kindle (the directory where the Kindle is opened with a computer is the root directory, i.e. /mnt/us/ on the Kinale system)

The files that need to be moved are:

debian.ext3

RunBeforeDebian.sh

RunDebian.sh

UpdateInitScript.sh

In your Kindle terminal enter:

cd /mnt/us

Enter the root directory.

./RunDebian.sh --root

Enter single-user mode Debian's single-user mode.

cd /deboostrap

./deboostrap --second-stage

Complete the installation of the Debian system.

(If you fail here, type CTRL-D to exit single-user mode and start with ./RunDebian.sh --r )

passwd

Change your root user password.

CTRL-D

Exit single-user mode.

./RunDebian.sh

Log in to Debian with the root account.

adduaer uasrname

Create a new user.

apt-get install sudo

apt-get install vim

vim /etc/sudoers

Edit the configuration file.

xxx ALL=(ALL) ALL

To add configuration, in the opened configuration file, find root ALL=(ALL) ALL, and add a line below.

Where xxx is the username you want to join.

CTRL-D

Exit single-user mode.

./RunBeforeDebian.sh

Now you can enter the Debian system by typing debian.

debian --root to enter single-user mode


If you have any questions, you can contact me by email.

jex.zucker@outlook.com

2846554322@qq.com

(The author is a student, it may take a month to recover...)

University of Science and Technology of China mirror debian.ext3

https://zuckertechnology-my.sharepoint.com/:u:/g/personal/jex_zuckertechnology_onmicrosoft_com/EaR1UOgokNFMvouAFbJusMkBO6K1-DHbyi0XutucueQnfg?e=8UFi6V
