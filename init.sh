#!/bin/sh 
DEMO="CDK Install Demo"
AUTHORS="Andrew Block, Eric D. Schabell"
PROJECT="git@github.com:eschabell/-demo.git"
PRODUCT="Container Development Kit"
CDK_HOME=./target
SRC_DIR=./installs
SUPPORT_DIR=./support
PRJ_DIR=./projects
CDK_PLUGINS_DIR=$CDK_HOME/cdk/plugins
CDK=cdk-2.0.0-beta4.zip
OSX_BOX=rhel-cdk-kubernetes-7.2-13.x86_64.vagrant-virtualbox.box
LINUX_BOX=
CDK_BOX_VERSION=cdkv2
VERSION=2.0.0-beta4

# wipe screen.
clear 

echo
echo "###############################################################"
echo "##                                                           ##"   
echo "##  Setting up the ${DEMO}                          ##"
echo "##                                                           ##"   
echo "##                                                           ##"   
echo "##    ####  ###  #   # #####  ###  ##### #   # ##### ####    ##"
echo "##   #     #   # ##  #   #   #   #   #   ##  # #     #   #   ##"
echo "##   #     #   # # # #   #   #####   #   # # # ###   ####    ##"
echo "##   #     #   # #  ##   #   #   #   #   #  ## #     #  #    ##"
echo "##    ###   ###  #   #   #   #   # ##### #   # ##### #   #   ##"
echo "##                                                           ##"   
echo "##            ####  ##### #   #   #   # ##### #####          ##"
echo "##            #   # #     #   #   #  #    #     #            ##"
echo "##            #   # ###   #   #   ###     #     #            ##"
echo "##            #   # #      # #    #  #    #     #            ##"
echo "##            ####  #####   #     #   # #####   #            ##"
echo "##                                                           ##"   
echo "##                                                           ##"   
echo "##  brought to you by ${AUTHORS}         ##"
echo "##                                                           ##"   
echo "##  ${PROJECT}                       ##"
echo "##                                                           ##"   
echo "###############################################################"
echo

# Ensure Vagrant avaiable.
#
command -v vagrant -v >/dev/null 2>&1 || { echo >&2 "Vagrant is required but not installed yet... download here: https://www.vagrantup.com/downloads.html"; exit 1; }
echo "Vagrant is installed..."
echo 

# Ensure VirtualBox available.
#
command -v VirtualBox -h >/dev/null 2>&1 || { echo >&2 "VirtualBox is required but not installed yet... downlaod here: https://www.virtualbox.org/wiki/Downloads"; exit 1; }
echo "VirtualBox is installed..."
echo

# Ensure CDK downloaded.
#
if [[ -r $SRC_DIR/$CDK ]] || [[ -L $SRC_DIR/$CDK ]]; then
	echo Product sources are present...
	echo
else
	echo Need to download $CDK package from the Customer Portal 
	echo and place it in the $SRC_DIR directory to proceed...
	echo
	exit
fi

# Ensure correct Vagrant box downloaded.
#
if [[ `uname` == 'Darwin' ]]; then

	# OSX Vagrant box.
	#
	if [[ -r $SRC_DIR/$OSX_BOX ]] || [[ -L $SRC_DIR/$OSX_BOX ]]; then
		echo OSX Vagrant box present...
	  echo
  else
	  echo Need to download $OSX_BOX from the Customer Portal 
	  echo and place it in the $SRC_DIR directory to proceed...
	  echo
	  exit
  fi

else

	# Linux Vagrant box.
	#
	if [[ -r $SRC_DIR/$LINUX_BOX ]] || [[ -L $SRC_DIR/$LINUX_BOX ]]; then
		echo Linux Vagrant box present...
	  echo
  else
	  echo Need to download $LINUX_BOX from the Customer Portal 
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
echo "Setting up installation now..."
echo
mkdir $CDK_HOME
unzip -q $SRC_DIR/$CDK -d $CDK_HOME

echo "Installing some Vagrant plugins..."
echo
cd $CDK_PLUGINS_DIR
vagrant plugin install vagrant-registration vagrant-adbinfo landrush

echo
echo "Checking that plugins installed, looking for:"
echo 
echo "  -> vagrant-registration"
echo "  -> vagrant-adbinfo"
echo "  -> landrush"
echo
vagrant plugin list

echo
echo "Adding the RHEL Vagrant box..."
echo
cd ../../../
vagrant box add --name $CDK_BOX_VERSION $SRC_DIR/$OSX_BOX

if [ $? -ne 0 ]; then
  echo
  echo "Detected a previous installation of this demo..."
  echo
	echo "Cleaning out previous Vagrant box $CDK_BOX_VERSION entry..."
	echo
	vagrant box remove $CDK_BOX_VERSION

	echo 
  echo "Cleanup done, re-trying the openshift-install-demo installation."
  echo
  vagrant box add --name $CDK_BOX_VERSION $SRC_DIR/$OSX_BOX
fi

echo
echo "Checking that $CDK_BOX_VERSION is listed..."
echo
vagrant box list

echo
echo "==================================================================="
echo "=                                                                 ="
echo "= After adding to path, you can use 'oc' from CLI to login:       ="
echo "=                                                                 ="
echo "=  $ oc login https://10.2.2.2                                    ="
echo "=                                                                 ="
echo "=  Authentication required for https://10.2.2.2:8443 (openshift)  ="
echo "=  Username: {insert-any-login-here}                              ="
echo "=                                                                 ="
echo "=  Login successful.                                              ="
echo "=                                                                 ="
echo "=  You don't have any projects. You can try to create a new       ="
echo "=  project, by running:                                           ="
echo "=                                                                 ="
echo "=  $ oc new-project                                               ="
echo "=                                                                 ="
echo "==================================================================="
echo
echo "==================================================================="
echo "=                                                                 ="
echo "= Now login via browser to OpenShift: https://10.2.2.2:8443       ="
echo "=                                                                 ="
echo "= To stop this demo use the following command:                    ="
echo "=                                                                 ="
echo "=  $ vagrant halt                                                 ="
echo "=                                                                 ="
echo "= $DEMO Setup Complete.                           ="
echo "=                                                                 ="
echo "==================================================================="
echo


exit
# Ensure Vagrant setup for target systems.
if [[ `uname` == 'Darwin' ]]; then
	# OSX does not require any actions.
else 
	# Linux needs some Vagrant setup.
	#
  # TODO.
fi



vagrant up --provider=virtualbox


