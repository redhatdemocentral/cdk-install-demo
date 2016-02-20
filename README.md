Container Development Kit Install Demo
======================================
If you are looking to develop containerized applications for Red Hat Enterprise
Linux systems, the Red Hat Container Development Kit (CDK) can help you by providing 
a Red Hat container development environment you can install locally. It includes the 
same container development and run-time tools used to create and deploy containers 
for large data centers. 

To get started with the provided pre-configured containers, [see the online documentation.](https://access.redhat.com/documentation/en/red-hat-enterprise-linux-atomic-host/version-7/container-development-kit-installation-guide/)
If you are fairly new to container development, see the online [Getting Started with Container Development.]
(https://access.redhat.com/documentation/en/red-hat-enterprise-linux-atomic-host/version-7/getting-started-with-container-development-kit)


Option 1 - Install on your machine
----------------------------------
1. [Download and unzip.](https://github.com/eschabell/cdk-install-demo/archive/master.zip)

2. Add products as needed (see installs directory).

3. Run 'init.sh' or 'init.bat' file. 'init.bat' must be run with Administrative privileges.

4. Read and follow displayed instructions and enjoy the Red Hat Container Development Kit (CDK) on your local machine!


Getting started
---------------
The following containers can be started after installing this project for you to start exploring:

OpenShift Enterprise - a containerized version of OpenShift Enterprise can be started that can be accesses through a Web console in
your browser or via the OpenShift command line tools. Explore your very own private PaaS developer experience with this container.

     $ cd ./target/cdk/components/rhel/rhel-ose
     $ vagrant up

Kubernetes - a container to set you up for exploring a Kubernetes cluster. It is setup to run as an all-in-one Kubernetes master to
manage pods and node for running multiple pods.
``
  $ cd ./target/cdk/components/rhel/rhel-ose

  $ vagrant up 
``

Eclipse - a container setup for you to use the Eclipse IDE with a Linux Tools/Docker Tooling plug-in allowing developers to manage
containers directly from their development environment.
``
  $ cd ./target/cdk/components/rhel/rhel-docker-eclipse

  $ vagrant up 
``


Supporting Articles
-------------------
- [How to install Red Hat Container Development Kit (CDK) in minutes](http://www.schabell.org/2016/02/howto-install-redhat-cdk-in-minutes.html)


Released versions
-----------------
See the tagged releases for the following versions of the product:

- v1.0 - based on CDK 2.0.0 beta 1 and RHEL Vagrant boxes 7.2-13.


![Install 1](https://github.com/eschabell/cdk-install-demo/blob/master/docs/demo-images/install-1.png?raw=true)

