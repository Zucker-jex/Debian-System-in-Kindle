说在前面

这个项目适用于，无法忍受kindle自身的Linux环境的人。
比如像我，只是想在Kindle上做一些轻量化的代码编辑工作，但是只要了解过的人都知道kindle上的Linux环境是个残废。
为了能随时方便的码字，诞生了这个项目。

有些人对kindle的机能以及该项目的运行提出了疑问，认为在kindle上运行Debian系统会十分卡顿。
在kindle开机后所运行的服务中，存在一个名为lab126_gui的服务。这个服务构成了Kindle的gui。
因此可以通过某些手段来结束这个服务后运行debian系统。
是个坑，可能会在下一次版本的更新中填上。

我本来想编写一个服务，在Kindle开机时运行stop lab126_gui后运行kterm，但是kterm的运行需要lab126_gui拉起的各种服务依赖，放弃。
另一个思路，在结束lab126_gui后挂载Debian镜像，在Debian中运行kterm，但是存在各种问题（具体请见[https://github.com/bfabiszewski/kterm/issues/26]），与kterm的作者交谈后我选择了一个有点曲折的方法。
在这里我需要介绍一个命令nohup，可以不挂起的运行指令。当我们在lab126_gui中运行stop lab126_gui时gui所提供的所有窗口将关闭，无法执行kterm。但使用nohup xxx.sh就可以无视终端挂起，继续运行指令。

为了方便运行，我写了一个KUAL插件，只需要解压到/mnt/us/extensions/，并将Debian镜像移动到目录内sys即可。

视频介绍：https://www.bilibili.com/video/BV1c94y1R72e?spm_id_from=333.999.0.0

关于

这是一个可以让你在Kindle上挂载Debian环境的程序或者脚本。

过程

你需要做的第一件事就是越狱你的Kindle。越狱过程涉及允许将未签名的应用程序安装到您的Kindle。推荐的方法https://bookfere.com/post/970.html
然后在你的Kindle上面安装Kterm，你可以在以下网址上找到它。

https://bookfere.com/post/98.html

https://github.com/bfabiszewski/kterm/releases

安装完成后，你就拥有了一个在Kindle上的终端。安装Debian前需要生成一个适合你设备的Debian映像。

你需要在一个合适的Linux系统上面执行MakeImage.sh并且等待他完成（根据国家的不同这个脚本有两个版本，内容上只有关于镜像网站的改变，可以让你更快的下载镜像，并且后期的apt也会更改为对应的镜像网站。）

首先你要确定在你的Linux系统上面拥有debootstrap，在Ubuntu等系统上，你可以通过sudo apt-get install debootstrap来获得它。

值得一提的是，大部分版本的Kindle它的内存只有8G，所以我设置的默认ext3分区大小为1GB如果你拥有Kindle pw 4等拥有32G高内存的机器,你可以修改MakeImage.sh脚本中'dd if=/dev/zero of=debian.ext3 bs=1M count=1024'把其中的1024换成你想要的大小(单位是MB)。

在没有报错的完成这个脚本后你将会得到一个名为debian.ext3的分区文件。
现在，将文件移动到Kindle的根目录（用计算机打开Kindle的目录为根目录，即 Kinale 系统上的 /mnt/us/ 目录）

需要移动的文件有：

debian.ext3

RunBeforeDebian.sh

RunDebian.sh

UpdateInitScript.sh

在你的Kindle终端输入：

cd /mnt/us

进入根目录。

./RunDebian.sh --root

进入单用户模式Debian的单用户模式。

cd /debootstrap

./debootstrap --second-stage

完成Debian系统的安装。

（如果你在这里失败了，键入CTRL-D退出单用户模式，并从./RunDebian.sh --r开始）

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

增加配置，在打开的配置文件中，找到root ALL=(ALL) ALL，在下面添加一行。

其中xxx是你要加入的用户名称。

CTRL-D

退出单用户模式。

./RunBeforeDebian.sh

现在你可以通过键debian入来进入Debian系统。

debian --root进入单用户模式


如果你有任何问题，可以通过邮箱与我取得联系。

jex.zucker@outlook.com

2846554322@qq.com

(笔者是学生，可能会出现一个月才能恢复的情况。。。)


Speaking in front

This project is suitable for people who cannot tolerate the Kindle's own Linux environment.

For example, like me, I just want to do some lightweight code editing work on the Kindle, but anyone who knows about it knows that the Linux environment on the Kindle is a cripple.

In order to facilitate the coding at any time, this project was born.

Some people have raised questions about the functionality of the Kindle and the operation of the project, believing that running the Debian system on the Kindle would be very cumbersome.

In the service running after the Kindle is powered on, there is a service named lab126_ GUI services. This service constitutes the GUI of the Kindle.

Therefore, it is possible to end this service and run the Debian system through certain means.

It is a pit that may be filled in in the next version update.

I originally wanted to write a service that runs stop lab126 when the Kindle starts up_ Run kterm after gui, but the operation of kterm requires lab126_ The various service dependencies caused by GUI are abandoned.

Another way of thinking is to end lab126_ After gui, mount the Debian image and run kterm in Debian, but there are various issues(please refer to https://github.com/bfabiszewski/kterm/issues/26)After talking to the author of kterm, I chose a somewhat convoluted approach.

Here I need to introduce a command called nohup, which can run instructions without hanging. When we were in lab126_ Running stop lab126 in GUI_ All windows provided by the gui will be closed during gui, and kterm cannot be executed. But using nohup xxx.sh can ignore terminal hangs and continue running instructions.

For ease of operation, I have written a KUAL plugin that simply needs to be uncompressed to/mnt/us/extensions/and moved the Debian image to the directory sys.

Video introduction: https://www.bilibili.com/video/BV1c94y1R72e?spm_id_from=333.999.0.0

About

This is a program or script that allows you to mount Debian environments on a Kindle.

Process

The first thing you need to do is jailbreak your Kindle. The jailbreak process involves allowing unsigned applications to be installed on your Kindle. Recommended methods https://bookfere.com/post/970.html
Then install Kterm on your Kindle, which you can find at the following website.

https://bookfere.com/post/98.html
https://github.com/bfabiszewski/kterm/releases

After the installation is completed, you will have a terminal on the Kindle. Before installing Debian, you need to generate a Debian image that is suitable for your device.

You need to execute MakeImage.sh on a suitable Linux system and wait for it to complete(there are two versions of this script depending on the country, and the content only includes changes to the image website, which can help you download the image faster, and the later apts will also be changed to the corresponding image website)

Firstly, you need to ensure that you have debootstrap on your Linux system. On systems such as Ubuntu, you can obtain it through sudo apt-get install debootstrap.

It is worth mentioning that most versions of Kindle only have 8GB of memory, so the default ext3 partition size I set is 1GB. If you have a machine with 32GB of high memory such as Kindle PW 4, you can modify the 'dd if=/dev/zero of=debian. ext3 bs=1M count=1024' in the MakeImage.sh script to replace 1024 with the size you want (in MB).

After completing this script without any errors, you will receive a partition file named debian.ext3.

Now, move the files to the root directory of the Kindle (the directory where you open the Kindle on your computer is the root directory, which is the/mnt/us/directory on the Kindle system)

The files that need to be moved include:

Debian. ext3

RunBeforeDebian.sh

RunDebian.sh

UpdateInitScript.sh

On your Kindle terminal, enter:

cd/mnt/us

Enter the root directory.

./RunDebian. sh -- root

Enter single user mode Debian's single user mode.

cd/debootstrap

./debootstrap -- second stage

Complete the installation of Debian system.

(If you fail here, type CTRL-D to exit single user mode and start with./RunDebian. sh -- r)

passwd

Change your root user password.

CTRL-D

Exit single user mode.

./RunDebian.sh

Log in to Debian using the root account.

adduaer uasrname

Create a new user.

apt get install sudo

apt get install vim

vim/etc/sudoers

Edit the configuration file.

xxx ALL=(ALL) ALL

Add configuration, in the opened configuration file, find root ALL=(ALL) ALL, and add a line below.

Where xxx is the name of the user you want to join.

CTRL-D

Exit single user mode.

./RunBeforeDebian.sh

Now you can enter the Debian system by pressing the debian key.

debian -- root enters single user mode

If you have any questions, you can contact me through email.

jex.zucker@outlook.com
2846554322@qq.com

(The author is a student and may take a month to recover.)
