#!/bin/bash
# Software License Agreement (BSD)
#
# Author    Anita Inchauspe <anita@erlerobotics.com>
# Copyright (c) 2014-2015, Erle Robotics, Inc., All rights reserved.
#
# Redistribution and use in source and binary forms, with or without modification, are permitted provided that
# the following conditions are met:
# * Redistributions of source code must retain the above copyright notice, this list of conditions and the
#   following disclaimer.
# * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the
#   following disclaimer in the documentation and/or other materials provided with the distribution.
# * Neither the name of Clearpath Robotics nor the names of its contributors may be used to endorse or
#   promote products derived from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED
# WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
# PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR
# ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
# TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
# HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
# NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.

#For more info: https://github.com/ros2/examples/wiki

#This function creates a new file system, chroot

create_chroot()
{
debootstrap trusty ~/trusty_ros2
cd ~/trusty_ros2

#Write into chroot
cat << EOF > chroot.sh 
	sudo mount -o bind /dev ~/trusty_ros2/dev
	sudo mount -o bind /proc ~/trusty_ros2/proc
	sudo mount -o bind /sys ~/trusty_ros2/sys
	chroot ~/trusty_ros2
EOF

chmod +x chroot.sh   #make it executable

#Write in sources.list 

cat << EOF > ~/trusty_ros2/etc/apt/sources.list 
	#------------------------------------------------------------------------------#
	#                            OFFICIAL UBUNTU REPOS                             #
	#------------------------------------------------------------------------------#

	deb http://mx.archive.ubuntu.com/ubuntu/ trusty main restricted
	deb-src http://mx.archive.ubuntu.com/ubuntu/ trusty main restricted

	deb http://mx.archive.ubuntu.com/ubuntu/ trusty-updates main restricted
	deb-src http://mx.archive.ubuntu.com/ubuntu/ trusty-updates main restricted

	deb http://mx.archive.ubuntu.com/ubuntu/ trusty universe
	deb-src http://mx.archive.ubuntu.com/ubuntu/ trusty universe
	deb http://mx.archive.ubuntu.com/ubuntu/ trusty-updates universe
	deb-src http://mx.archive.ubuntu.com/ubuntu/ trusty-updates universe

	deb http://mx.archive.ubuntu.com/ubuntu/ trusty multiverse
	deb-src http://mx.archive.ubuntu.com/ubuntu/ trusty multiverse
	deb http://mx.archive.ubuntu.com/ubuntu/ trusty-updates multiverse
	deb-src http://mx.archive.ubuntu.com/ubuntu/ trusty-updates multiverse

	deb http://mx.archive.ubuntu.com/ubuntu/ trusty-backports main restricted universe multiverse
	deb-src http://mx.archive.ubuntu.com/ubuntu/ trusty-backports main restricted universe multiverse

	deb http://security.ubuntu.com/ubuntu trusty-security main restricted
	deb-src http://security.ubuntu.com/ubuntu trusty-security main restricted
	deb http://security.ubuntu.com/ubuntu trusty-security universe
	deb-src http://security.ubuntu.com/ubuntu trusty-security universe
	deb http://security.ubuntu.com/ubuntu trusty-security multiverse
	deb-src http://security.ubuntu.com/ubuntu trusty-security multiverse

	deb http://archive.canonical.com/ubuntu trusty partner
	deb-src http://archive.canonical.com/ubuntu trusty partner

	deb http://extras.ubuntu.com/ubuntu trusty main
	deb-src http://extras.ubuntu.com/ubuntu trusty main

EOF

}

#Call create_chroot function and run it

create_chroot
mv ~/ros2_install.sh ~/trusty_ros2
cd ~/trusty_ros2
./chroot.sh


