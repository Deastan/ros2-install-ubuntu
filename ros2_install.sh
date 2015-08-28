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
install_package()
{
        if test  ! "` dpkg -l |grep $*`"
        then
                apt-get -qq install  $*
        fi
}

PACKAGES=( git wget build-essential cppcheck cmake libopencv-dev python-empy python3-empy python3-setuptools python3-nose python3-pip python3-vcstool )


#Add ROS apt repositories to your system:

sh -c 'echo "deb http://packages.ros.org/ros/ubuntu `lsb_release -cs` main" > /etc/apt/sources.list.d/ros-latest.list'
wget https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -O - | sudo apt-key add -

#Get the osrf (gazebo) debian repository:

sh -c 'echo "deb http://packages.osrfoundation.org/gazebo/ubuntu `lsb_release -cs` main" > /etc/apt/sources.list.d/gazebo-latest.list'
wget http://packages.osrfoundation.org/gazebo.key -O - | sudo apt-key add -


#Install GCC, G++ CMake and Python3 EmPy packages and setuptools

echo ".....Updating all packages....."
apt-get update -qq                      #(-qq)Show just errors on the screen 

for i in "${PACKAGES[@]}"
do
        install_package $i
done

apt-get update -qq

pip3 install -U setuptools

#Create a workspace and clone all repositories:

read -p "Please type a name for the workspace:  " nom
echo $nom
mkdir -p ~/$nom/src
cd ~/$nom
wget https://raw.githubusercontent.com/ros2/examples/master/ros2.repos
vcs import ~/$nom/src < ros2.repos
echo "......\"$nom\" workspace created....."
apt-get update -qq

if test ! "`dpkg -l |grep libopensplice64`"
then
        apt-get -qq install libopensplice64  # from packages.osrfoundation.org
fi
export OSPL_URI=file:///usr/etc/opensplice/config/ospl.xml


#Install one or more DDS implementations
#RTI Connext

#Java runtime installation

#sudo apt-get install openjdk-7-jre

#Debian packages built by OSRF

#apt-get update
#apt-get install libopensplice64 2> /dev/null # from packages.osrfoundation.org

#Add this to you ~/.bashrc

#export OSPL_URI=file:///usr/etc/opensplice/config/ospl.xml

#Build the prototype using the bootstrap script from ament_tools

