# 说在前面

这个项目是为那些无法忍受 Kindle 自身的 Linux 环境的人设计的。就像我一样，只是想在 Kindle 上进行一些轻量级的代码编辑工作，但任何了解 Kindle 上 Linux 环境的人都知道，它功能有限。为了方便随时编写代码，这个项目应运而生。

有些人对 Kindle 的性能和本项目的运行效果表示怀疑，他们认为在 Kindle 上运行 Debian 系统会非常卡顿。事实上，Kindle 启动后会运行一个名为 `lab126_gui` 的服务，它构成了 Kindle 的 GUI 界面。可以通过某些方法停止这个服务后运行 Debian 系统。虽然这是个挑战，但可能会在未来版本中得到解决。

我本来打算编写一个服务，在 Kindle 启动时运行 `stop lab126_gui` 后再运行 `kterm`，但后来发现 `kterm` 的运行依赖于 `lab126_gui` 启动的各种服务，因此放弃了这个想法。另一个方案是，在结束 `lab126_gui` 后挂载 Debian 镜像，并在 Debian 中运行 `kterm`。不过，这个方法存在许多问题（[详见此处](https://github.com/bfabiszewski/kterm/issues/26)）。与 `kterm` 的作者交流后，我采取了一个稍显曲折的方法。这里需要介绍 `nohup` 命令，它可以在不挂起终端的情况下运行指令。当我们在 `lab126_gui` 中运行 `stop lab126_gui` 时，GUI 提供的所有窗口都会关闭，无法执行 `kterm`。但使用 `nohup xxx.sh` 就可以无视终端挂起，继续运行指令。

为了方便操作，我编写了一个 KUAL 插件。只需解压到 `/mnt/us/extensions/` 目录，并将 Debian 镜像移动到 sys 目录即可。

- [视频介绍](https://www.bilibili.com/video/BV1c94y1R72e)

# 关于

这是一个可以让你在 Kindle 上挂载 Debian 环境的程序或脚本。

## 过程

### 前置要求

首先，你需要越狱你的 Kindle。越狱过程包括允许将未签名的应用程序安装到你的 Kindle 上。[推荐的方法](https://bookfere.com/post/970.html)。

然后，在你的 Kindle 上安装 Kterm。你可以在以下网址找到它：
- https://bookfere.com/post/98.html
- https://github.com/bfabiszewski/kterm/releases

安装完成后，你就拥有了一个 Kindle 上的终端。在安装 Debian 之前，需要生成一个适合你设备的 Debian 镜像。你需要在一个合适的 Linux 系统上执行 `MakeImage.sh` 并等待其完成。根据国家的不同，这个脚本有两个版本，内容上主要是关于镜像网站的不同，可以让你更快地下载镜像，并且后期的 apt 也会更改为对应的镜像网站。首先，你需要确保你的 Linux 系统上安装了 debootstrap，在 Ubuntu 等系统上，你可以通过 `sudo apt-get install debootstrap` 来获取它。值得一提的是，大部分 Kindle 的内存只有 8G，所以我设置默认的 ext3 分区大小为 1GB。如果你拥有 Kindle PW 4 等高内存的机型（如 32G），你可以修改 `MakeImage.sh` 脚本中的 `dd if=/dev/zero of=debian.ext3 bs=1M count=1024`，把其中的 `1024` 更换成你想要的大小（单位是 M）。成功完成这个脚本后，你将得到一个名为 `debian.ext3` 的分区文件。

现在，需要将以下文件移动到 Kindle 的 `us` 目录（即通过计算机打开 Kindle 驱动器的目录，相当于 Kindle 系统上的 `/mnt/us/` 目录）：

- `debian.ext3`
- `RunBeforeDebian.sh`
- `RunDebian.sh`
- `UpdateInitScript.sh`

### Kindle 上的操作

进行以下操作来启动 Debian 系统：

1. 在你的 Kindle 终端输入：
   ```
   cd /mnt/us
   ```
   这会将目录切换到根目录。

2. 运行下面的命令以进入 Debian 的单用户模式：
   ```
   ./RunDebian.sh --root
   ```

3. 输入以下命令：
   ```
   cd /debootstrap
   ./debootstrap --second-stage
   ```
   这会进入 Debian 系统的安装过程。如果在这个阶段遇到问题，输入 CTRL-D 退出单用户模式，然后从 `./RunDebian.sh --root` 开始重新尝试。

4. 修改你的 root 用户密码：
   ```
   passwd
   ```

5. 再次输入 CTRL-D 退出。

6. 启动 Debian 系统：
   ```
   ./RunDebian.sh
   ```
   现在可以使用 root 账号登录 Debian 了。

7. 运行：
   ```
   ./RunBeforeDebian.sh
   ```
   完成以上步骤后，你就可以通过输入 `debian` 来进入 Debian 系统了。如果需要进入单用户模式，请使用 `debian --root` 命令。


如果遇到任何问题，欢迎通过邮箱与我联系。

# Preface

This project is designed for those who cannot tolerate the native Linux environment on Kindle. Like myself, I just wanted to do some lightweight coding work on Kindle, but anyone familiar with the Linux environment on Kindle knows it is limited. To facilitate coding at any time, this project was born.

Some people are skeptical about the performance of Kindle and the operational effect of this project, thinking that running a Debian system on Kindle would be very sluggish. In fact, after Kindle is started, it runs a service called `lab126_gui`, which constitutes the GUI interface of Kindle. It is possible to stop this service and then run the Debian system by certain methods. Although this is a challenge, it might be resolved in future versions.

I initially intended to write a service that runs `stop lab126_gui` followed by `kterm` at Kindle's startup, but later found that the operation of `kterm` depends on various services started by `lab126_gui`, so I abandoned this idea. Another plan was to mount the Debian image after ending `lab126_gui`, and run `kterm` within Debian. However, this method has many issues ([see here for details](https://github.com/bfabiszewski/kterm/issues/26)). After communicating with the author of `kterm`, I took a slightly more circuitous approach. Here, the `nohup` command needs to be introduced, which can run instructions without hanging up the terminal. When we run `stop lab126_gui` in `lab126_gui`, all windows provided by the GUI will close, making it impossible to execute `kterm`. But using `nohup xxx.sh` allows us to ignore terminal suspension and continue running instructions.

For convenience, I wrote a KUAL plugin. Just unzip it to the `/mnt/us/extensions/` directory, and move the Debian image to the sys directory.

- [Video Introduction](https://www.bilibili.com/video/BV1c94y1R72e)

# About

This is a program or script that allows you to mount a Debian environment on your Kindle.

## Process

### Prerequisites

First, you need to jailbreak your Kindle. The jailbreaking process includes allowing unsigned applications to be installed on your Kindle. [Recommended method](https://bookfere.com/post/970.html).

Then, install Kterm on your Kindle. You can find it at the following addresses:
- https://bookfere.com/post/98.html
- https://github.com/bfabiszewski/kterm/releases

After installation, you will have a terminal on Kindle. Before installing Debian, you need to generate a Debian image suitable for your device. You need to execute `MakeImage.sh` on an appropriate Linux system and wait for it to complete. Depending on the country, there are two versions of this script, mainly concerning different mirror sites, allowing you to download the image faster, and the apt will also be changed to the corresponding mirror site later. First, you need to ensure that debootstrap is installed on your Linux system, which can be obtained on Ubuntu and other systems by `sudo apt-get install debootstrap`. It's worth mentioning that most Kindles only have 8G of memory, so I set the default size of the ext3 partition to 1GB. If you own a higher memory model like Kindle PW 4 (e.g., 32G), you can change `dd if=/dev/zero of=debian.ext3 bs=1M count=1024` in the `MakeImage.sh` script, replacing `1024` with the size you want (in M). After successfully completing this script, you will get a partition file named `debian.ext3`.

Now, you need to move the following files to the Kindle's `us` directory (that is, the directory opened by the computer's Kindle drive, equivalent to the `/mnt/us/` directory on the Kindle system):

- `debian.ext3`
- `RunBeforeDebian.sh`
- `RunDebian.sh`
- `UpdateInitScript.sh`

### Operations on Kindle

Perform the following operations to start the Debian system:

1. Enter in your Kindle terminal:
   ```
   cd /mnt/us
   ```
   This will switch the directory to the root directory.

2. Run the following command to enter Debian's single-user mode:
   ```
   ./RunDebian.sh --root
   ```

3. Enter the following command:
   ```
   cd /debootstrap
   ./debootstrap --second-stage
   ```
   This will start the installation process of the Debian system. If you encounter any issues at this stage, enter CTRL-D to exit single-user mode, then retry starting from `./RunDebian.sh --root`.

4. Change your root user password:
   ```
   passwd
   ```

5. Press CTRL-D again to exit.

6. Start the Debian system:
   ```
   ./RunDebian.sh
   ```
   Now you can log into Debian using the root account.

7. Run:
   ```
   ./RunBeforeDebian.sh
   ```
   After completing the above steps, you can enter the Debian system by typing `debian`. If you need to enter single-user mode, use the `debian --root` command.


If you encounter any problems, feel free to contact me via email.
