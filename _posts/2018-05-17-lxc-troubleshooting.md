---
layout: post
title: LXC Containers Not Authorized to Change Passwords
date: 2018-05-17
description: 'How to fix the error - "..... is not authorized to change the password"'
comments: true
tags: cloud containers sre devops lxc troubleshooting
categories: troubleshooting
---
This problem occurs especially when LXC Containers are run on a host machine with CentOS distribution. When we want to create an user inside the container, we get an error which says `..... is not authorized to change the password of <user_name>`.    

The Problem
========
This problem occurs especially when LXC Containers are run on a host machine with CentOS distribution. When we want to create an user inside the container, we get an error which says "..... is not authorized to change the password of user_name". A snippet of the error is shown below:    
```
[~]# passwd testuser

passwd: unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 is not authorized to change the password of testuser
```

The Solution 
========
The culprit behind this problem usually is SELinux. When set to "Enforcing" or "Permissive", the SELinux would deny the user to change user parameters inside the containers like passwords as we encountered in the problem. Though, it is not safe to disable SELinux; we can solve above problem temporarily by checking the status of SELinux and disabling it. To get the "passwd" command work inside the container, follow the steps below:    

1. Check SELinux settings on CentOS Host Machine    
```
[~]$ sestatus
SELinux status:                 enabled
SELinuxfs mount:                /selinux
Current mode:                   enforcing
Mode from config file:          enforcing
Policy version:                 24
Policy from config file:        targeted
```

2. Check SELinux settings on Guest
```
[~]$ sestatus
SELinux status:                 enabled
SELinuxfs mount:                /selinux
Current mode:                   enforcing
```

3. Disable SELinux from Config file
  * Go to the config file located at `/etc/selinux/config` 
  * Change SELINUX option to disabled 
  * Save and close the file    
  
4. Reboot the Host Machine
5. After reboot, check SELinux setting parameter using getenforce
```
[~]$ getenforce
Disabled
```   

Now, check again if the problem still persists in the guest virtual machine. This temporary fix should solve the problem.