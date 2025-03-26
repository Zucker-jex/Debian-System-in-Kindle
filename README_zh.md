[English](README.md)

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

如果遇到任何问题，欢迎提交 Issue 或通过邮箱与我联系。
