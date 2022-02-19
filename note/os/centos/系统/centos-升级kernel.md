# CentOS 安装或升级最新的内核
> https://www.linuxprobe.com/update-kernel-centos7.html





#检查已安装的内核版本
uname -sr

 

如果我们现在进入 https://www.kernel.org/，在撰写本文时，我们看到最新的内核版本是4.10.1（其他版本可以从同一网站获得）。

还要考虑的一个重要的事情是内核版本的生命周期 - 如果你当前使用的版本接近它的生命周期结束，那么在该日期后将不会提供更多的 bug 修复。关于更多信息，请参阅内核发布页。

步骤 2：在 CentOS 7 中升级内核
大多数现代发行版提供了一种使用 yum 等包管理系统和官方支持的仓库升级内核的方法。

但是，这只会升级内核到仓库中可用的最新版本 - 而不是在 https://www.kernel.org/ 中可用的最新版本。不幸的是，Red Hat 只允许使用前者升级内核。

与 Red Hat 不同，CentOS 允许使用 ELRepo，这是一个第三方仓库，可以将内核升级到最新版本。

要在 CentOS 7 上启用 ELRepo 仓库，请运行：

# rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
# rpm -Uvh http://www.elrepo.org/elrepo-release-7.0-2.el7.elrepo.noarch.rpm
教你三步在CentOS 7 中安装或升级最新的内核教你三步在CentOS 7 中安装或升级最新的内核

在 CentOS 7 启用 ELRepo

仓库启用后，你可以使用下面的命令列出可用的内核相关包：

# yum --disablerepo="*" --enablerepo="elrepo-kernel" list available
教你三步在CentOS 7 中安装或升级最新的内核教你三步在CentOS 7 中安装或升级最新的内核

yum - 找出可用的内核版本

接下来，安装最新的主线稳定内核：

# yum --enablerepo=elrepo-kernel install kernel-ml
教你三步在CentOS 7 中安装或升级最新的内核教你三步在CentOS 7 中安装或升级最新的内核

在 CentOS 7 中安装最新的内核版本

最后，重启机器并应用最新内核，接着运行下面的命令检查最新内核版本：

uname -sr
教你三步在CentOS 7 中安装或升级最新的内核教你三步在CentOS 7 中安装或升级最新的内核

验证内核版本

步骤 3：设置 GRUB 默认的内核版本
为了让新安装的内核成为默认启动选项，你需要如下修改 GRUB 配置：

打开并编辑 /etc/default/grub 并设置 GRUB_DEFAULT=0。意思是 GRUB 初始化页面的第一个内核将作为默认内核。

GRUB_TIMEOUT=5
GRUB_DEFAULT=0
GRUB_DISABLE_SUBMENU=true
GRUB_TERMINAL_OUTPUT="console"
GRUB_CMDLINE_LINUX="rd.lvm.lv=centos/root rd.lvm.lv=centos/swap crashkernel=auto rhgb quiet"
GRUB_DISABLE_RECOVERY="true"
接下来运行下面的命令来重新创建内核配置。

# grub2-mkconfig -o /boot/grub2/grub.cfg
教你三步在CentOS 7 中安装或升级最新的内核教你三步在CentOS 7 中安装或升级最新的内核

在 GRUB 中设置内核

重启并验证最新的内核已作为默认内核。

教你三步在CentOS 7 中安装或升级最新的内核教你三步在CentOS 7 中安装或升级最新的内核

在 CentOS 7 中启动默认内核版本

恭喜你！你已经在 CentOS 7 中升级内核了
















