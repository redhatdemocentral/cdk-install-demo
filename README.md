Red Hat CDK Easy Install Demo
=============================
If you are looking to develop containerized applications for Red Hat Enterprise Linux systems, the Red Hat Container Development Kit (CDK) can help you by providing 
a Red Hat container development environment you can install locally. It includes the same container development and run-time tools used to create and deploy containers 
for large data centers. 

To get started with the provided pre-configured containers, [see the online documentation.](https://access.redhat.com/documentation/en/red-hat-enterprise-linux-atomic-host/version-7/container-development-kit-installation-guide/) If you are fairly new to container development, see the online [Getting Started with Container Development.](https://access.redhat.com/documentation/en/red-hat-enterprise-linux-atomic-host/version-7/getting-started-with-container-development-kit)


Option 1 - Install on your machine
----------------------------------
1. [Download and unzip.](https://github.com/redhatdemocentral/cdk-install-demo/archive/master.zip)

2. Add products as needed, see installs directory for list, [free downloads here](http://developers.redhat.com/products/cdk/get-started/).

3. Run 'init.sh' or 'init.bat' file. Windows init.bat will point you to the windows installer.

4. Read and follow displayed instructions and enjoy the Red Hat Container Development Kit (CDK) on your local machine!


Getting started
---------------
The following containers can be started after installing this project for you to start exploring:

OpenShift Enterprise - a containerized version of OpenShift Enterprise can be started that can be accesses through a Web console in
your browser or via the OpenShift command line tools. Explore your very own private PaaS developer experience with this container.

     $ cd ./target/cdk/components/rhel/rhel-ose
     $ vagrant up

     OpenShift console available at: https://10.1.2.2:8443/console
     Login as 'admin' with password 'admin'

Kubernetes - a container to set you up for exploring a Kubernetes cluster. It is setup to run as an all-in-one Kubernetes master to
manage pods and node for running multiple pods.
  
     $ cd ./target/cdk/components/rhel/misc/rhel-k8s-singlenode-setup
     $ vagrant up 


Notes
-----
Should your local network DNS not handle the resolution of the above address, giving you page not found errors, you can apply the
following to your local hosts file:

```
$ sudo vi /etc/hosts

# add host for CDK demo resolution.
10.1.2.2   10.1.2.2   10.1.2.2
```

If you halt your CDK image, when restarting you may encounter 'Application is not available' when trying to reach a project URL,
just locate and remove the router image as follows:

```
$ oc get pods -n default

NAME                       READY     STATUS             RESTARTS   AGE
docker-registry-1-deploy   0/1       DeadlineExceeded   0          9h
docker-registry-2-gfgc3    1/1       Running            0          9h
router-1-9ri9d             2/2       Running            0          9h

$ oc delete pod router-1-9ri9d -n default
```

This will restart the router and resolve your application URLs.


Supporting Articles
-------------------
- [Red Hat Container Development Kit installation in just minutes(video)](http://www.schabell.org/2016/06/redhat-cdk-installation-in-just-minutes-video.html)

- [Digital sign for Red Hat Container Development Kit (CDK)](http://www.schabell.org/2016/03/digital-sign-redhat-cdk.html)

- [How to install Red Hat Container Development Kit (CDK) in minutes](http://www.schabell.org/2016/02/howto-install-redhat-cdk-in-minutes.html)


Released versions
-----------------
See the tagged releases for the following versions of the product:

- v1.5 - based on CDK 2.1.0 and RHEL Vagrant boxes 7.2-25. 

- v1.4 - based on CDK 2.0.0 and RHEL Vagrant boxes 7.2-23. Patches and some clean up in OSE container startup.

- v1.3 - based on CDK 2.0.0 and RHEL Vagrant boxes 7.2-23.

- v1.2 - based on CDK 2.0.0 beta 5, RHEL Vagrant boxes 7.2-21 now freely available on developer.redhat.com.

- v1.1 - based on CDK 2.0.0 beta 5 and RHEL Vagrant boxes 7.2-21.

- v1.0 - based on CDK 2.0.0 beta 4 and RHEL Vagrant boxes 7.2-13.

[![Install video](https://github.com/redhatdemocentral/cdk-install-demo/blob/master/docs/demo-images/cdk-install-video.png?raw=true)](https://vimeo.com/ericschabell/cdk-install-demo)

![Digital sign](https://github.com/redhatdemocentral/cdk-install-demo/blob/master/docs/demo-images/red_hat_cdk_install_demo.jpg?raw=true)

![CDK OSE](https://github.com/redhatdemocentral/cdk-install-demo/blob/master/docs/demo-images/cdk-ose.png?raw=true)

