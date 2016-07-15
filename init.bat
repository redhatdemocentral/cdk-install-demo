@ECHO OFF
setlocal

set PROJECT_HOME=%~dp0
set DEMO=CDK Install Demo
set AUTHORS=Andrew Block, Eric D. Schabell
set PROJECT=git@github.com:redhatdemocentral/cdk-install-demo.git
set PRODUCT=Container Development Kit
set CDK_HOME=%PROJECT_HOME%target
set SRC_DIR=%PROJECT_HOME%installs
set SUPPORT_DIR=%PROJECT_HOME%support
set PRJ_DIR=%PROJECT_HOME%projects
set CDK_PLUGINS_DIR=%CDK_HOME%\cdk\plugins
set CDK=cdk-2.0.0.zip
set CDK_DOWNLOAD_LINK=https://access.redhat.com/downloads/content/293/ver=2/rhel---7/2.0.0/x86_64/product-software
set WINDOWS_BOX=rhel-cdk-kubernetes-7.2-23.x86_64.vagrant-virtualbox.box
set CDK_BOX_VERSION=cdkv2
set VERSION=2.0.0

REM wipe screen.
cls


echo.
echo #######################################################################
echo ##                                                                   ##
echo ##  Setting up the %DEMO%                             ##
echo ##                                                                   ##
echo ##                                                                   ##
echo ##    ####  ###  #   # #####  ###  ##### #   # ##### ####            ##
echo ##   #     #   # ##  #   #   #   #   #   ##  # #     #   #           ##
echo ##   #     #   # # # #   #   #####   #   # # # ###   ####            ##
echo ##   #     #   # #  ##   #   #   #   #   #  ## #     #  #            ##
echo ##    ###   ###  #   #   #   #   # ##### #   # ##### #   #           ##
echo ##                                                                   ##   
echo ##            ####  ##### #   #   #   # ##### #####                  ##
echo ##            #   # #     #   #   #  #    #     #                    ##
echo ##            #   # ###   #   #   ###     #     #                    ##
echo ##            #   # #      # #    #  #    #     #                    ##
echo ##            ####  #####   #     #   # #####   #                    ##
echo ##                                                                   ##
echo ##                                                                   ##
echo ##  brought to you by %AUTHORS%                ##
echo ##                                                                   ##
echo ##  %PROJECT%  ##
echo ##                                                                   ##
echo #######################################################################
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

echo.
echo =======================================================================
echo =                                                                     =
echo =  Red Hat provides an installer for use on windows, please see       =
echo =  here for instructions and details:                                 =
echo =                                                                     =
echo =  http://developers.redhat.com/products/cdk/get-started              =
echo =                                                                     =
echo =======================================================================
echo.
                                                                    
