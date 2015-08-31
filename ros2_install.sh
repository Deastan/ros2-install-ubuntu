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


#install_package function check's out if a package is already installed, if not it installs it. 

install_package()
{
        if test  ! "` dpkg -l |grep $*`"
        then
                apt-get -y install  $*
        fi
}


#Packages declaration

PACKAGES=( build-essential cppcheck cmake libopencv-dev python-empy python3-empy python3-setuptools python3-nose python3-pip python3-vcstool )


#Add ROS apt repositories to your system:

sh -c 'echo "deb http://packages.ros.org/ros/ubuntu `lsb_release -cs` main" > /etc/apt/sources.list.d/ros-latest.list'
apt-key adv --keyserver ha.pool.sks-keyservers.net --recv-keys 421C365BD9FF1F717815A3895523BAEEB01FA116

#Get the osrf (gazebo) debian repository:

sh -c 'echo "deb http://packages.osrfoundation.org/gazebo/ubuntu `lsb_release -cs` main" > /etc/apt/sources.list.d/gazebo-latest.list'
apt-key adv --keyserver ha.pool.sks-keyservers.net --recv-keys D2486D2DD83DB69272AFE98867170598AF249743

#Install GCC, G++ CMake and Python3 EmPy packages and setuptools

echo ".....Updating all packages....."
apt-get update -qq                      #(-qq) option shows just errors on the screen 

apt-get -y install git
apt-get -y install wget
apt-get -y install libopensplice64

for i in "${PACKAGES[@]}"
do
        install_package $i
done

pip3 install -U setuptools
apt-get update -qq


#Create a workspace and clone all repositories:

read -p "Please type a name for the workspace:  " nom
echo $nom
mkdir -p ~/$nom/src
cd ~/$nom
wget https://raw.githubusercontent.com/ros2/ros2/master/ros2.repos
vcs import ~/$nom/src < ros2.repos
echo "......\"$nom\" workspace created....."


if test ! "`dpkg -l |grep libopensplice64`"
then
        apt-get -y install libopensplice64  # from packages.osrfoundation.org
fi


#Add to .bashrc

touch ~/.bashrc
export OSPL_URI=file:///usr/etc/opensplice/config/ospl.xml


#Install one or more DDS implementations
#RTI Connext

#Java runtime installation

#sudo apt-get install openjdk-7-jre

#Debian packages built by OSRF

#apt-get update
#apt-get install libopensplice64 2> /dev/null # from packages.osrfoundation.org

#Build the prototype using the bootstrap script from ament_tools

src/ament/ament_tools/scripts/ament.py build --build-tests --symlink-install
. install/local_setup.bash


