#!/bin/sh 
DEMO="CDK Install Demo"
AUTHORS="Andrew Block, Eric D. Schabell"
PROJECT="git@github.com:redhatdemocentral/cdk-install-demo.git"
PRODUCT="Container Development Kit"
CDK_HOME=./target
SRC_DIR=./installs
SUPPORT_DIR=./support
PRJ_DIR=./projects
CDK_PLUGINS_DIR=$CDK_HOME/cdk/plugins
CDK=cdk-2.1.0.zip
CDK_DOWNLOAD_LINK="http://developers.redhat.com/download-manager/file//cdk-2.1.0.zip"
OSX_BOX=rhel-cdk-kubernetes-7.2-25.x86_64.vagrant-virtualbox.box
LINUX_BOX=rhel-cdk-kubernetes-7.2-25.x86_64.vagrant-libvirt.box
VAGRANTFILE=VagrantFile-rhel-ose
CDK_BOX_VERSION=cdkv2
VERSION=2.1.0

# wipe screen.
clear 

echo
echo "#######################################################################"
echo "##                                                                   ##"   
echo "##  Setting up the ${DEMO}                                  ##"
echo "##                                                                   ##"   
echo "##                                                                   ##"   
echo "##    ####  ###  #   # #####  ###  ##### #   # ##### ####            ##"
echo "##   #     #   # ##  #   #   #   #   #   ##  # #     #   #           ##"
echo "##   #     #   # # # #   #   #####   #   # # # ###   ####            ##"
echo "##   #     #   # #  ##   #   #   #   #   #  ## #     #  #            ##"
echo "##    ###   ###  #   #   #   #   # ##### #   # ##### #   #           ##"
echo "##                                                                   ##"   
echo "##            ####  ##### #   #   #   # ##### #####                  ##"
echo "##            #   # #     #   #   #  #    #     #                    ##"
echo "##            #   # ###   #   #   ###     #     #                    ##"
echo "##            #   # #      # #    #  #    #     #                    ##"
echo "##            ####  #####   #     #   # #####   #                    ##"
echo "##                                                                   ##"   
echo "##                                                                   ##"   
echo "##  brought to you by ${AUTHORS}                 ##"
echo "##                                                                   ##"   
echo "##  ${PROJECT}            ##"
echo "##                                                                   ##"   
echo "#######################################################################"
echo

# Ensure Vagrant avaiable.
#
command -v vagrant -v >/dev/null 2>&1 || { echo >&2 "Vagrant is required but not installed yet... download here: https://www.vagrantup.com/downloads.html"; exit 1; }
echo "Vagrant is installed..."
echo 

# Ensure VirtualBox available.
#
if [[ `uname` == 'Darwin' ]]; then
	command -v VirtualBox -h >/dev/null 2>&1 || { echo >&2 "VirtualBox is required but not installed yet... downlaod here: https://www.virtualbox.org/wiki/Downloads"; exit 1; }
	echo "VirtualBox is installed..."
	echo
fi

# Ensure CDK downloaded.
#
if [[ -r $SRC_DIR/$CDK ]] || [[ -L $SRC_DIR/$CDK ]]; then
	echo Product sources are present...
	echo
else
	echo Need to download $CDK package from the Customer Portal 
    echo $CDK_DOWNLOAD_LINK
	echo and place it in the $SRC_DIR directory to proceed...
	echo
	exit
fi

# Ensure correct Vagrant box downloaded.
#
if [[ `uname` == 'Darwin' ]]; then
	# OSX Vagrant box.
	if [[ -r $SRC_DIR/$OSX_BOX ]] || [[ -L $SRC_DIR/$OSX_BOX ]]; then
		echo OSX Vagrant box present...
	  echo
  else
	  echo Need to download $OSX_BOX from the Customer Portal 
      echo $CDK_DOWNLOAD_LINK
	  echo and place it in the $SRC_DIR directory to proceed...
	  echo
	  exit
  fi
else
	# Linux Vagrant box.
	if [[ -r $SRC_DIR/$LINUX_BOX ]] || [[ -L $SRC_DIR/$LINUX_BOX ]]; then
		echo Linux Vagrant box present...
	  echo
  else
	  echo Need to download $LINUX_BOX from the Customer Portal 
      echo $CDK_DOWNLOAD_LINK
	  echo and place it in the $SRC_DIR directory to proceed...
	  echo
	  exit
  fi
fi

# Remove the old insallation, if it exists.
#
if [[ -x $CDK_HOME ]]; then
	echo "  - removing existing installation..."
	echo
	rm -rf $CDK_HOME
fi

# Run installation.
#
echo "Setting up installation now..."
echo
mkdir $CDK_HOME
unzip -q $SRC_DIR/$CDK -d $CDK_HOME

# Add memory adjusted Vagrantfile for OSE image.
#
echo "Copying over VagrantFile with rhel-ose larger memory settings..."
echo
cp $SUPPORT_DIR/$VAGRANTFILE $CDK_HOME/cdk/components/rhel/rhel-ose/Vagrantfile

echo "Installing provided Vagrant plugins..."
echo
cd $CDK_PLUGINS_DIR
vagrant plugin install *.gem 

echo
echo "Checking that plugins installed, looking for:"
echo 
echo "  -> vagrant-registration"
echo "  -> vagrant-service-manager"
echo "  -> vagrant-sshfs"
echo
vagrant plugin list

# determine which Vagrant box to add.
#
cd ../../../
if [[ `uname` == 'Darwin' ]]; then
	# OSX Vagrant box.
	echo
  echo "Adding the RHEL Vagrant box..."
  echo
  vagrant box add $CDK_BOX_VERSION $SRC_DIR/$OSX_BOX
else 
	# Linux Vagrant box.
	#
	echo
  echo "Adding the libvirt Vagrant box..."
  echo
  vagrant box add $CDK_BOX_VERSION $SRC_DIR/$LINUX_BOX
fi

if [ $? -ne 0 ]; then
  echo
  echo "Detected a previous installation of this demo..."
  echo
	echo "Cleaning out previous Vagrant box $CDK_BOX_VERSION entry..."
	echo
	vagrant box remove $CDK_BOX_VERSION

	echo 
  echo "Cleanup done, re-trying the installation."
  echo
	if [[ `uname` == 'Darwin' ]]; then
		# OSX Vagrant box.
	  echo
    echo "Adding the RHEL Vagrant box..."
    echo
    vagrant box add --name $CDK_BOX_VERSION $SRC_DIR/$OSX_BOX
  else 
	  # Linux Vagrant box.
	  echo
    echo "Adding the libvirt Vagrant box..."
    echo
    vagrant box add --name $CDK_BOX_VERSION $SRC_DIR/$LINUX_BOX
  fi
fi

echo
echo "Checking that $CDK_BOX_VERSION is listed..."
echo
vagrant box list

echo
echo "========================================================================="
echo "=                                                                       ="
echo "=  Now you can start up pre-defined Vagrant boxes using the provided    ="
echo "=  Vagrant files or you can initialze an empty box and create your own  ="
echo "=  Vagrant file.                                                        ="
echo "=                                                                       ="
echo "=  For example, using a provided Vagrant file means going to its        ="
echo "=  directory and start a RHEL CDK Vagrant box.                          ="
echo "=                                                                       ="
echo "=  Two Vagrant files are provided with the CDK for uses cases           ="
echo "=  described below as we show you how to start each below.              ="
echo "=                                                                       ="
echo "=                                                                       ="
echo "=  1. OpenShift Enterprise (rhel-ose):                                  ="
echo "=                                                                       ="
echo "=     $ cd ./target/cdk/components/rhel/rhel-ose; vagrant up            ="
echo "=                                                                       ="
echo "=                                                                       ="
echo "=  2. Single-node Kubernetes setup (rhel-k8s-singlenode-setup):         ="
echo "=                                                                       ="
echo "=     $ cd ./target/cdk/components/rhel/misc/rhel-k8s-singlenode-setup  ="
echo "=                                                                       ="
echo "=     $ vagrant up                                                      ="
echo "=                                                                       ="
echo "=                                                                       ="
echo "=  Finally, initialize a Vagrant box for using your own Vagrant file:   ="
echo "=                                                                       ="
echo "=     $ mkdir ./target/mycdkv2                                          ="
echo "=     $ cd ./target/mycdkv2                                             ="
echo "=     $ vagrant init cdkv2                                              ="
echo "=     $ vagrant up                                                      ="
echo "=                                                                       ="
echo "=  This completes the $DEMO setup.                           ="              
echo "=                                                                       ="
echo "========================================================================="
echo                                                                    

