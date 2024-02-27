# 说在前面

这个项目适用于，无法忍受kindle自身的Linux环境的人。\
比如像我，只是想在Kindle上做一些轻量化的代码编辑工作，但是只要了解过的人都知道kindle上的Linux环境是个残废。\
为了能随时方便的码字，诞生了这个项目。

有些人对kindle的机能以及该项目的运行提出了疑问，认为在kindle上运行Debian系统会十分卡顿。\
在kindle开机后所运行的服务中，存在一个名为lab126_gui的服务。这个服务构成了Kindle的gui。\
因此可以通过某些手段来结束这个服务后运行debian系统。\
是个坑，可能会在下一次版本的更新中填上。

我本来想编写一个服务，在Kindle开机时运行stop lab126_gui后运行kterm，但是kterm的运行需要lab126_gui拉起的各种服务依赖，放弃。\
另一个思路，在结束lab126_gui后挂载Debian镜像，在Debian中运行kterm，但是存在各种问题（[具体请见](https://github.com/bfabiszewski/kterm/issues/26)），与kterm的作者交谈后我选择了一个有点曲折的方法。\
在这里我需要介绍一个命令nohup，可以不挂起的运行指令。当我们在lab126_gui中运行stop lab126_gui时gui所提供的所有窗口将关闭，无法执行kterm。但使用nohup xxx.sh就可以无视终端挂起，继续运行指令。

为了方便运行，我写了一个KUAL插件，只需要解压到/mnt/us/extensions/，并将Debian镜像移动到目录内sys即可。

- [视频介绍](https://www.bilibili.com/video/BV1c94y1R72e)

# 关于
这是一个可以让你在Kindle上挂载Debian环境的程序或者脚本。

## 过程
### 前置要求
你需要做的第一件事就是越狱你的Kindle。越狱过程涉及允许将未签名的应用程序安装到您的Kindle。[推荐的方法](ttps://bookfere.com/post/970.html)\
后在你的Kindle上面安装Kterm，你可以在以下网址上找到它。
- https://bookfere.com/post/98.html
- https://github.com/bfabiszewski/kterm/releases

安装完成后，你就拥有了一个在Kindle上的终端。安装Debian前需要生成一个适合你设备的Debian映像。\
你需要在一个合适的Linux系统上面执行MakeImage.sh并且等待他完成（根据国家的不同这个脚本有两个版本，内容上只有关于镜像网站的改变，可以让你更快的下载镜像，并且后期的apt也会更改为对应的镜像网站。）\
首先你要确定在你的Linux系统上面拥有debootstrap，在Ubuntu等系统上，你可以通过sudo apt-get install debootstrap来获得它。\
值得一提的是，大部分版本的Kindle它的内存只有8G，所以我设置的默认ext3分区大小为1GB如果你拥有Kindle pw 4等拥有32G高内存的机器,你可以修改MakeImage.sh脚本中'dd if=/dev/zero of=debian.ext3 bs=1M count=1024'把其中的1024换成你想要的大小(单位是MB)。\
在没有报错的完成这个脚本后你将会得到一个名为debian.ext3的分区文件。\
现在，将文件移动到Kindle的us目录（用计算机打开Kindle驱动器的目录，即 Kinale 系统上的 /mnt/us/ 目录）\
需要移动的文件有：
- debian.ext3
- RunBeforeDebian.sh
- RunDebian.sh
- UpdateInitScript.sh

### Kindle上的操作
在你的Kindle终端输入：
- cd /mnt/us 进入根目录。
- ./RunDebian.sh --root 进入单用户模式Debian的单用户模式。
- cd /debootstrap
- ./debootstrap --second-stage 进Debian系统安装。（如果你在这里失败了，键入CTRL-D退出单用户模式，并从./RunDebian.sh --r开始）
- passwd 修改你的root用户密码。
- CTRL-D

- ./RunDebian.sh
- 用root账号登录Debian。

- ./RunBeforeDebian.sh

现在你可以通过键debian入来进入Debian系统。\
debian --root进入单用户模式

如果你有任何问题，可以通过邮箱与我取得联系。

# Speaking ahead
This project is suitable for people who cannot tolerate Kindle's own Linux environment\
For example, like me, I just want to do some lightweight code editing work on the Kindle, but anyone who knows about it knows that the Linux environment on the Kindle is a cripple\
In order to easily code characters at any time, this project was born.
Some people have raised doubts about the functionality of Kindle and the operation of the project, believing that running the Debian system on Kindle would be very sluggish\
There is a service called lab126_gui running in the Kindle after startup. This service constitutes the GUI of Kindle\
Therefore, it is possible to end this service and run the Debian system through certain means\
It's a pit that may be filled in in the next version update.
I originally intended to write a service that would run kterm after stopping lab126_gui on Kindle startup, but the operation of kterm required various service dependencies pulled by lab126_gui, so I gave up\
Another approach is to mount a Debian image after ending lab126_gui and run kterm in Debian, but there are various issues ([see details](https://github.com/bfabiszewski/kterm/issues/26))After talking to the author of kterm, I chose a somewhat convoluted approach\
Here I need to introduce a command called nohup, which can run instructions without hanging. When we run stop lab126_gui in lab126_gui, all windows provided by the gui will close and kterm cannot be executed. But using nohup xxx.sh can ignore terminal hang and continue running instructions.
For ease of operation, I have written a KUAL plugin that only needs to be decompressed to/mnt/us/extensions/and the Debian image moved to the directory sys.
- [Video Introduction](https://www.bilibili.com/video/BV1c94y1R72e)

# About
This is a program or script that allows you to mount Debian environments on Kindle.
## Process
### Pre requirements
The first thing you need to do is jailbreak your Kindle. The jailbreak process involves allowing unsigned applications to be installed on your Kindle. [Recommended method]（ ttps://bookfere.com/post/970.html ）\
After installing Kterm on your Kindle, you can find it at the following website.
- https://bookfere.com/post/98.html
- https://github.com/bfabiszewski/kterm/releases

After installation, you will have a terminal on the Kindle. Before installing Debian, you need to generate a Debian image that is suitable for your device\
You need to execute MakeImage.sh on a suitable Linux system and wait for it to complete (there are two versions of this script depending on the country, and the content only includes changes to the image website, which can help you download the image faster, and the later apts will also be changed to the corresponding image website)\
Firstly, you need to ensure that you have debootstrap on your Linux system. On systems such as Ubuntu, you can obtain it by installing debootstrap through sudo apt-get\
It is worth mentioning that most versions of Kindle only have 8GB of memory, so the default ext3 partition size I set is 1GB. If you have a machine with 32GB of high memory such as Kindle PW 4, you can modify the MakeImage.sh script to 'dd if=/dev/zero of=debian. ext3 bs=1M count=1024' and replace 1024 with the size you want (in MB)\
After completing this script without any errors, you will receive a partition file named debian.axt3\
Now, move the files to the us directory of Kindle (open the directory of Kindle drive on your computer, which is the/mnt/us/directory on the Kindle system)\
The files that need to be moved include:
- Debin.ext3
- RunBeforeDebian.sh
- RunDebian.sh
- UpdateInitScript.sh
### Operations on Kindle
On your Kindle terminal, enter:
- Enter the root directory with cd/mnt/us.
- ./RunDebian.sh -- Root enters single user mode Debian's single user mode.
- cd /debootstrap
- ./debuotstrap -- second-stage is installed on the Debian system. (If you fail here, type CTRL-D to exit single user mode and start from./RunDebian. sh -- r)
- passwd Change your root user password.
- CTRL-D
- ./RunDebian.sh
- Log in to Debian with the root account.

- ./RunBeforeDebian.sh

Now you can enter the Debian system by pressing the Debian key\

Debian -- root enters single user mode

If you have any questions, you can contact me through email.
