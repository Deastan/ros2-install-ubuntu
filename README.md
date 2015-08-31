# ros2-install-ubuntu

##ABOUT ROS2
Version 2.0 of the Robot Operating System (ROS)

Follow https://github.com/ros2/ros2/wiki/Linux-Development-Setup for more info.

##COMPILATION
System requirements: Ubuntu Linux Trusty Tahr 14.04 on 64-bit.

If you do not have this release go to your home directory and first run `sudo ./create_trusty_chroot.sh`  to create 
a trusty new file system. Afterwards, run `./ros2_install.sh` to install ROS2 and create a new workspace.

If you already have trusty, just run `sudo ./ros2_install.sh`.
