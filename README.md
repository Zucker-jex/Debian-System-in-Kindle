[中文](README_zh.md)

# Preface

This project is designed for those who find the native Linux environment on Kindle intolerable. Like myself, you might simply want to do some lightweight code editing on your Kindle, but anyone familiar with its Linux environment knows its limitations. To enable coding on the go, this project was born.

Some have expressed skepticism about Kindle’s performance and the feasibility of this project, believing that running a Debian system on Kindle would be sluggish. In reality, when a Kindle boots up, it launches a service called `lab126_gui`, which powers its GUI interface. There are methods to stop this service and run Debian instead. While challenging, this may be addressed in future updates.

Initially, I intended to create a service that runs `stop lab126_gui` on startup followed by launching `kterm`. However, I discovered that `kterm` relies on services started by `lab126_gui`, leading me to abandon this approach. Another idea was to stop `lab126_gui`, mount the Debian image, and run `kterm` within Debian, but this introduced numerous issues ([details here](https://github.com/bfabiszewski/kterm/issues/26)). After discussing with `kterm`'s author, I adopted a workaround involving the `nohup` command, which allows instructions to run even after terminal termination. When `stop lab126_gui` is executed, all GUI windows close, preventing `kterm` from launching. Using `nohup xxx.sh` bypasses this by continuing execution despite terminal suspension.

For ease of use, I developed a KUAL plugin. Simply extract it to `/mnt/us/extensions/` and move the Debian image to the `sys` directory.

- [Demo Video](https://www.bilibili.com/video/BV1c94y1R72e)

# About

This is a script or program that allows you to mount a Debian environment on your Kindle.

## Process

### Prerequisites

First, jailbreak your Kindle. Jailbreaking enables the installation of unsigned applications. [Recommended method](https://bookfere.com/post/970.html).

Next, install Kterm on your Kindle. Find it at:

- https://bookfere.com/post/98.html
- https://github.com/bfabiszewski/kterm/releases

After installation, you’ll have a terminal on your Kindle. Before installing Debian, generate a Debian image compatible with your device. Run `MakeImage.sh` on a Linux system and wait for completion. There are two script versions for different regions, primarily differing in mirror sites to speed up downloads and configure `apt` sources. Ensure `debootstrap` is installed (on Ubuntu, use `sudo apt-get install debootstrap`). Most Kindles have 8GB storage, so the default ext3 partition size is 1GB. For higher-capacity models like Kindle PW 4 (32GB), modify `dd if=/dev/zero of=debian.ext3 bs=1M count=1024` in `MakeImage.sh` by replacing `1024` with your desired size (in MB).

Transfer these files to the Kindle’s `us` directory (mounted as `/mnt/us/` on the Kindle):

- `debian.ext3`
- `RunBeforeDebian.sh`
- `RunDebian.sh`
- `UpdateInitScript.sh`

### Kindle Setup

Follow these steps to launch Debian:

1. In your Kindle terminal, run:

   ```
   cd /mnt/us
   ```

2. Enter Debian’s single-user mode:

   ```
   ./RunDebian.sh --root
   ```

3. Execute:

   ```
   cd /debootstrap
   ./debootstrap --second-stage
   ```

   This initiates Debian installation. If issues arise, press CTRL-D to exit, then retry from `./RunDebian.sh --root`.

4. Set the root password:

   ```
   passwd
   ```

5. Press CTRL-D to exit.

6. Start Debian:

   ```
   ./RunDebian.sh
   ```

   Log in as `root`.

7. Run:
   ```
   ./RunBeforeDebian.sh
   ```
   Now, type `debian` to enter Debian. Use `debian --root` for single-user mode.

For issues, submit an Issue or contact me via email.
