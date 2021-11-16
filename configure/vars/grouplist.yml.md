---
grouplist:
  - name: editors
    Description: Editing files
    Commands:
  - "/usr/bin/sudoedit"

  - name: filemgmt
    Description: Managing files
    Commands:
  - "/bin/cp"
  - "/bin/mv"
  - "/usr/bin/rsync"
  - "/bin/rm"
  - "/bin/ls"
  - "/bin/echo"
  - "/bin/cat"
  - "/usr/bin/tail"
  - "/bin/mkdir"
  - "/bin/rmdir"
  - "/usr/bin/du"
  - "/bin/df"
  - "/usr/bin/ncdu"

  - name: filemgmt-show
    Description: Displaying files
    Commands:
  - "/bin/vi"
  - "/bin/vim"
  - "/bin/view"
  - "/usr/bin/bzless"
  - "/usr/bin/bzmore"
  - "/usr/bin/lzless"
  - "/usr/bin/lzmore"
  - "/usr/bin/xzless"
  - "/usr/bin/xzmore"
  - "/usr/bin/zless"
  - "/usr/bin/zmore"
  - "/usr/sbin/vipw"
  - "/bin/more"
  - "/usr/bin/less"

  - name: filemgmt-find
    Description: Searching files
    Commands:
  - "/bin/find"
  - name: fileperm
    Description: Managing file permissions
    Commands:
  - "/bin/chgrp"
  - "/bin/chmod"
  - "/bin/chown"
  - name: fileperm-acl
    Description: Managing ACLs
    Commands:
  - "/usr/bin/chacl"
  - "/usr/bin/gefacl"
  - "/usr/bin/setfacl"
  - name: locate
    Description: Managing locate database
    Commands:
  - "/usr/bin/updatedb"
  - name: networking
    Description: Managing network connections
    Commands:
  - "/sbin/ifconfig"
  - "/sbin/mii-tool"
  - "/usr/bin/net"
  - "/sbin/ifdown"
  - "/sbin/ifup"
  - "/bin/netstat"
  - name: firewall
    Description: Managing firewall configuration
    Commands:
  - "/sbin/iptables"
  - "/usr/sbin/lokkit"
  - "/usr/bin/system-config-firewall-tui"
  - "/usr/bin/firewall-cmd"
  - "/usr/bin/firewall-offline-cmd"
  - name: time
    Description: Managing time/date configuration
    Commands:
  - "/sbin/hwclock"
  - "/bin/timedatectl"
  - "/usr/sbin/ntpdate"
  - name: processes
    Description: Managing processes
    Commands:
  - "/bin/kill"
  - "/usr/bin/killall"
  - "/bin/nice"
  - "/usr/bin/renice"
  - "/usr/sbin/lsof"
  - "/sbin/fuser"
  - name: selinux
    Description: Managing SELinux
    Commands:
  - "/sbin/ausearch"
  - "/usr/bin/audit2allow"
  - "/usr/bin/audit2why"
  - "/usr/sbin/semanage"
  - "/usr/sbin/semodule"
  - "/usr/sbin/setsebool"
  - "/usr/sbin/setenforce"
  - "/usr/sbin/load_policy"
  - name: selinux-files
    Description: Managing SELinux file contexts
    Commands:
  - "/sbin/setfiles"
  - "/sbin/fixfiles"
  - "/usr/bin/chcon"
  - "/sbin/restorecon"
  - name: services
    Description: Managing system services
    Commands:
  - "/sbin/service"
  - "/bin/systemctl"
  - "/sbin/chkconfig"
  - name: shells
    Description: Shells and other bad software
    Commands:
  - "/bin/bash"
  - "/bin/csh"
  - "/bin/dash"
  - "/bin/ksh"
  - "/bin/mksh"
  - "/bin/sh"
  - "/bin/tcsh"
  - "/bin/zsh"
  - "/usr/bin/scl"
  - "/usr/bin/screen"
  - "/usr/bin/tmux"
  - name: software
    Description: Managing software
    Commands:
  - "/bin/rpm"
  - "/usr/bin/up2date"
  - "/usr/bin/yum"
  - "/usr/sbin/yum-complete-transaction"
  - "/usr/bin/yumdownloader"
  - "/usr/bin/yum-config-manager"
  - "/usr/bin/dnf"
  - "/usr/bin/package-cleanup"
  - "/usr/sbin/rpmconf"
  - "/usr/bin/needs-restarting"
  - name: storage-mount
    Description: Managing storage mounts
    Commands:
  - "/bin/mount"
  - "/bin/umount"
  - name: storage-part
    Description: Managing storage partitions
    Commands:
  - "/sbin/fdisk"
  - "/sbin/sfdisk"
  - "/sbin/parted"
  - "/sbin/partprobe"
  - name: storage-lvm
    Description: Managing LVM storage
    Commands:
  - "/sbin/pvchange"
  - "/sbin/pvcreate"
  - "/sbin/pvdisplay"
  - "/sbin/pvmove"
  - "/sbin/pvremove"
  - "/sbin/pvresize"
  - "/sbin/pvs"
  - "/sbin/pvscan"
  - "/sbin/vgchange"
  - "/sbin/vgcreate"
  - "/sbin/vgdisplay"
  - "/sbin/vgexport"
  - "/sbin/vgextend"
  - "/sbin/vgimport"
  - "/sbin/vgreduce"
  - "/sbin/vgremove"
  - "/sbin/vgrename"
  - "/sbin/vgs"
  - "/sbin/vgscan"
  - "/sbin/lvchange"
  - "/sbin/lvcreate"
  - "/sbin/lvdisplay"
  - "/sbin/lvextend"
  - "/sbin/lvreduce"
  - "/sbin/lvremove"
  - "/sbin/lvrename"
  - "/sbin/lvresize"
  - "/sbin/lvscan"
  - "/sbin/lvs"
  - name: storage-fs
    Description: Managing file systems
    Commands:
  - "/sbin/mkfs"
  - "/sbin/mkfs.ext3"
  - "/sbin/mkfs.ext4"
  - "/sbin/mkfs.xfs"
  - "/sbin/resize2fs"
  - "/sbin/tune2fs"
  - "/sbin/xfs_growfs"
  - name: storage-generic
    Description: Generic storage commands
    Commands:
  - "/usr/bin/iostat"
  - "/usr/sbin/iotop"
  - "/usr/bin/rescan-scsi-bus.sh"
  - "/usr/bin/scsi-rescan"
  - "/sbin/multipath"
  - "/sbin/badblocks"
  - "/sbin/blkid"
  - name: su
    Description: Switching user context
    Commands:
  - "/bin/su"
  - "/sbin/sulogin"
  - "/sbin/sushell"
  - "/sbin/runuser"
  - name: usermgmt
    Description: Managing users and groups
    Commands:
  - "/usr/sbin/useradd"
  - "/usr/sbin/userdel"
  - "/usr/sbin/usermod"
  - "/usr/sbin/groupadd"
  - "/usr/sbin/groupdel"
  - "/usr/sbin/groupmod"
  - "/usr/bin/id"
  - "/usr/bin/gpasswd"
  - "/usr/bin/chage"
  - "/bin/passwd"
  - "/usr/bin/passwd"
  - "/usr/bin/chfn"
  - "/usr/bin/chsh"
  - name: monitoring
    Description: Managing monitoring
    Commands:
  - "/usr/bin/omd"
  - "/usr/sbin/nagios"
  - "/usr/sbin/naemon"
  - name: ipa-client
    Description: Managing IPA clients
    Commands:
  - "/usr/sbin/ipa-client-install"
  - "/usr/sbin/ipa-client-automount"
  - "/usr/sbin/ipa-certupdate"
  - "/usr/bin/ipa-getcert"
  - "/usr/sbin/ipa-getkeytab"
  - "/usr/sbin/ipa-join"
  - "/usr/sbin/ipa-rmkeytab"
  - "/usr/sbin/sss_cache"
  - name: ipa-server
    Description: Managing IPA servers
    Commands:
  - "/usr/bin/ipa"
  - "/usr/sbin/ipa-ca-install"
  - "/usr/sbin/ipa-csreplica-manage"
  - "/usr/sbin/ipa-otptoken-import"
  - "/usr/sbin/ipa-restore"
  - "/usr/sbin/ipa-upgradeconfig"
  - "/usr/sbin/ipa-adtrust-install"
  - "/usr/sbin/ipactl"
  - "/usr/sbin/ipa-kra-install"
  - "/usr/sbin/ipa-replica-conncheck"
  - "/usr/sbin/ipa-winsync-migrate"
  - "/usr/sbin/ipa-advise"
  - "/usr/sbin/ipa-dns-install"
  - "/usr/sbin/ipa-ldap-updater"
  - "/usr/sbin/ipa-replica-install"
  - "/usr/sbin/ipa-server-certinstall"
  - "/usr/sbin/ipa-backup"
  - "/usr/sbin/ipa-managed-entries"
  - "/usr/sbin/ipa-replica-manage"
  - "/usr/sbin/ipa-server-install"
  - "/usr/sbin/ipa-cacert-manage"
  - "/usr/sbin/ipa-compat-manage"
  - "/usr/sbin/ipa-nis-manage"
  - "/usr/sbin/ipa-replica-prepare"
  - "/usr/sbin/ipa-server-upgrade"
  - name: mysql-server
    Description: Managing MySQL servers
    Commands:
  - "/usr/bin/mysqladmin"
  - "/usr/bin/mysql_secure_installation"
  - "/usr/bin/mysql_install_db"
  - name: postfix
    Description: Managing Postfix servers
    Commands:
  - "/usr/bin/newaliases"
  - "/usr/sbin/postalias"
  - "/usr/sbin/postconf"
  - "/usr/sbin/postfix"
  - "/usr/sbin/postlock"
  - "/usr/sbin/postmap"
  - "/usr/sbin/postsuper"
  - name: nfs-server
    Description: Managing NFS servers
    Commands:
  - "/usr/sbin/exportfs"
  - name: nfs-client
    Description: Managing NFS mounts
    Commands:
  - "/sbin/mount.nfs"
  - "/sbin/mount.nfs4"
  - "/sbin/umount.nfs"
  - "/sbin/umount.nfs4"
  - name: power
    Description: Managing power
    Commands:
  - "/usr/sbin/reboot"
  - "/usr/sbin/poweroff"
  - "/sbin/shutdown"
  - "/usr/sbin/halt"
  - name: docker
    Description: Managing Docker containers
    Commands:
  - "/usr/bin/docker"
  - "/usr/bin/docker-storage-setup"
  - "/usr/bin/docker-compose"
  - name: gitlab
    Description: Managing GitLab and GitLab CI installations
    Commands:
  - "/usr/bin/gitlab-ci-multi-runner"
  - name: system-who
    Description: Stalking systems users
    Commands:
  - "/usr/bin/w"
  - "/usr/bin/who"
  - "/usr/bin/lastlog"
  - name: samba-server
    Description: Managing Samba servers
    Commands:
  - "/usr/bin/smbpasswd"
  - "/usr/bin/testparm"
  - "/usr/bin/net"
  - "/usr/bin/pdbedit"
  - "/usr/bin/profiles"
  - "/usr/bin/smbstatus"
  - "/usr/bin/eventlogadm"
  - name: cron
    Description: Managing cronjobs
    Commands:
  - "/usr/bin/crontab"

