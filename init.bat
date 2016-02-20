@ECHO OFF
setlocal

set PROJECT_HOME=%~dp0
set DEMO=CDK Install Demo
set AUTHORS=Andrew Block, Eric D. Schabell
set PROJECT=git@github.com:eschabell/cdk-install-demo.git
set PRODUCT=Container Development Kit
set CDK_HOME=%PROJECT_HOME%target
set SRC_DIR=%PROJECT_HOME%installs
set SUPPORT_DIR=%PROJECT_HOME%support
set PRJ_DIR=%PROJECT_HOME%projects
set CDK_PLUGINS_DIR=%CDK_HOME%\cdk\plugins
set CDK=cdk-2.0.0-beta4.zip
set WINDOWS_BOX=rhel-cdk-kubernetes-7.2-13.x86_64.vagrant-vmware-fusion.box
set CDK_BOX_VERSION=cdkv2
set VERSION=2.0.0-beta4

REM wipe screen.
cls


echo.
echo ###############################################################
echo ##                                                           ##
echo ##  Setting up the %DEMO%                     ##
echo ##                                                           ##
echo ##                                                           ##
echo ##    ####  ###  #   # #####  ###  ##### #   # ##### ####    ##
echo ##   #     #   # ##  #   #   #   #   #   ##  # #     #   #   ##
echo ##   #     #   # # # #   #   #####   #   # # # ###   ####    ##
echo ##   #     #   # #  ##   #   #   #   #   #  ## #     #  #    ##
echo ##    ###   ###  #   #   #   #   # ##### #   # ##### #   #   ##
echo ##                                                           ##   
echo ##            ####  ##### #   #   #   # ##### #####          ##
echo ##            #   # #     #   #   #  #    #     #            ##
echo ##            #   # ###   #   #   ###     #     #            ##
echo ##            #   # #      # #    #  #    #     #            ##
echo ##            ####  #####   #     #   # #####   #            ##
echo ##                                                           ##
echo ##                                                           ##
echo ##  brought to you by %AUTHORS%        ##
echo ##                                                           ##
echo ##  %PROJECT%    ##
echo ##                                                           ##
echo ###############################################################
echo.

call where vagrant >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
	echo Vagrant is required but not installed yet... download here: https://www.vagrantup.com/downloads.html.
	GOTO :EOF
)
echo Vagrant is installed...

call where VirtualBox >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
	echo VirtualBox is required but not installed yet... downlaod here: https://www.virtualbox.org/wiki/Downloads
	GOTO :EOF
)
echo VirtualBox is installed...

REM TODO: check for cdk tools and vagrant box for windows.

REM Check for existing install.
if exist "%CDK_HOME%" (
         echo  - removing existing installation....
         echo.
         rmdir /s /q %CDK_HOME%"
)

REM Run installation.
echo Setting up installation now...
echo.
mkdir "%CDK_HOME%"
REM TODO: unzip cdk tools into ./target

echo Installing some Vagrant plugins...
echo.
cd "%CDK_PLUGINS_DIR%"
call vagrant plugin install vagrant-registration vagrant-adbinfo landrush

echo.
echo Checking that plugins installed, looking for:
echo. 
echo  - vagrant-registration
echo  - vagrant-adbinfo
echo  - landrush
echo.
call vagrant plugin list

echo.
echo Adding the VMWARE Vagrant box...
echo.
cd ..\..\..\
call vagrant box add --name "%CDK_BOX_VERSION%" "%SRC_DIR%/%WINDOWS_BOX%%"

if %ERRORLEVEL% NEQ 0 (

  echo.
  echo Detected a previous installation of this demo...
  echo.
	echo Cleaning out previous Vagrant box %CDK_BOX_VERSION% entry...
	echo.
	call vagrant box remove "%CDK_BOX_VERSION%"

	echo.
  echo Cleanup done, re-trying the installation...
  call vagrant box add --name "%CDK_BOX_VERSION%" "%SRC_DIR%/%WINDOWS_BOX%%"
  
)

echo Checking that $CDK_BOX_VERSION is listed...
echo.
call vagrant box list

echo.
echo ====================================================================
echo =                                                                  =
echo =  Now you can start up pre-defined Vagrant boxes using the        =
echo =  provided Vagrant files or you can initialze an empty box and    =
echo =  create your own Vagrant file.                                   =
echo =                                                                  =
echo =  For example, using a provided Vagrant file means going to its   =
echo =  directory and start a RHEL CDK Vagrant box.                     =
echo =                                                                  =
echo =  Three Vagrant files are provided with the CDK for uses cases    =
echo =  described below as we show you how to start each below.         =
echo =                                                                  =
echo =                                                                  =
echo =  1. Docker Eclipse integration [rhel-docker-eclipse]:            =
echo =                                                                  =
echo =     $ cd target\cdk\components\rhel\rhel-docker-eclipse          =
echo =                                                                  =
echo =     $ vagrant up                                                 =
echo =                                                                  =
echo =                                                                  =
echo =  2. Single-node Kubernetes setup [rhel-k8s-singlenode-setup]:    =
echo =                                                                  =
echo =     $ cd target\cdk\components\rhel\rhel-k8s-singlenode-setup    =
echo =                                                                  =
echo =     $ vagrant up                                                 =
echo =                                                                  =
echo =                                                                  =
echo =  3. OpenShift Enterprise [rhel-ose]:                             =
echo =                                                                  =
echo =     $ cd target\cdk\components\rhel\rhel-ose                     =
echo =                                                                  =
echo =     $ vagrant up                                                 =
echo =                                                                  =
echo =                                                                  =
echo =  Finally, initialize a Vagrant box for using your own Vagrant    =
echo =  file [make your own]:                                           =
echo =                                                                  =
echo =     $ mkdir target\mycdkv2                                       =
echo =     $ cd target\mycdkv2                                          =
echo =     $ vagrant init cdkv2                                         =
echo =     $ vagrant up                                                 =
echo =                                                                  =
echo =                                                                  =
echo =  This completes the %DEMO% setup.                     =             
echo =                                                                  =
echo ====================================================================
echo.
                                                                    
