---
layout: post
title:  '[Solved] Python Pynotify- gio.Error: The connection is closed'
date: 2015-03-15
description: 'This post discusses the problem of `gio.Error: Connection Closed` error in Pynotify, its causes and steps to solve the problem.'
tags: python programming troubleshooting
categories: troubleshooting 
---

Pynotify
======
Pynotify is a Python package providing tools for implementing Observer programming pattern. These tools include signals, conditions and variables. Pynotify comes handy when one wants to write a script which outputs some "notification" pop-up on the desktop. Pynotify relies on Dbus IPC bus and problem occurred in Dbus may cause Pynotify to break. There is a well-known problem that usually occurs while using Pynotify. We discuss the problem below and solution to overcome the problem.

Problem
======
Whenever we use show() method of pynotify to show the message in pop-up window, it gives you error in the following format:
```python
Traceback (most recent call last):
  File "NotifyMe.py", line 14, in <module>
    notifications.show()
gio.Error: Connection Closed
```
The gio.Error is related to Dbus suggesting that the connection to Dbus is closed. 

Cause
=====
I was working on one project which uses Pynotify and I encountered the same problem. After a lot of research I found out that I was calling my script with root user. If you are also running your script with root user, then it may be the problem. The problem is that root does not have a dbus session running. I found out that it does not even own XScreen. I assume we want to use Dbus session that belongs to the logged in user.

Solution
======
There are two or three workarounds to tackle the problem and get your pynotify script working. We discuss those solutions below:
  * ***Quit Root User Session***: Most probably current Dbus session belongs to normal user which is currently logged in. So, better and simple way to avoid above problem is to quit root user session using "ctrl+d" and run the script again. 
  * ***Use GKsu***: GKSu is a library that provides a Gtk+ frontend to su and sudo. GUI applications should be started with gksu, not su or sudo.
  * ***Add "root" User to Dbus Group***: A simple workaround can be adding the "root" user to Dbus group to give it the permission to connect to Dbus. I have not verified this step. So, if it works for you, please let me know in the comments section.
  * ***Exporting Display Variable***: Another workaround that MAY help in solving the problem is exporting display variable. Add following lines of code to start of your python script and see if it helps. <br/>
  ```python
  import os
  os.environ['DISPLAY'] = ':0.0'
  ```
  
  I hope above solutions will work for you and you'd be able to work with pynotify in your projects. 