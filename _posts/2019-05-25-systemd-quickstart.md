---
layout: post
title: SystemD Quickstart
date: '2019-05-25 17:19:00 +0000'
slug: systemd-quickstart
permalink: "/systemd-quickstart/"
author: Varokas Panusuwan
tags: []
feature_image: https://images.unsplash.com/reserve/81gZijLSWfge41LgzqQ6_Moving%20Parts.JPG?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjExNzczfQ
ghost_id: 5e929aca9c3d50000174a342
visibility: public
---

<p>A quite handy framework built-in to most Linux distro. SystemD helps in setting up a process that restarts itself on boot, and when it crash. This is what many packages do when apt-installed.</p><p>Doing it by hand is not complicated. But I couldn't find a single quickstart source to refer to. This is my public tl;dr notes in setting up systemd that should match most needs.</p><p>Let's say we are setting up <code>homebridge</code>. Replace that name with your service.</p><h3 id="the-service-file">The Service File</h3><p>Describe the service, where's the executable, who's the user that should run it as.</p><pre><code class="language-bash">file: /etc/systemd/system/homebridge.service

[Unit]
Description=HomeBridge server # A description 
After=syslog.target network-online.target

[Service]
Type=simple
User=pi # A username to run this service as
EnvironmentFile=/etc/default/homebridge #Environment Variable for the service. This is a separate file creating below

# See comments below for more information
ExecStart=/usr/bin/homebridge $HOMEBRIDGE_OPTS #As you'd type in command line. $HOMEBRIDGE_OPTS is from the EnvironmentFile defined below
Restart=on-failure
RestartSec=10
KillMode=process

[Install]
WantedBy=multi-user.target</code></pre><h3 id="the-environment-file">The Environment File</h3><p>Many processes are controlled by environments variable. It is usually better to separate those out as a file.  </p><pre><code class="language-bash">file: /etc/default/homebridge

HOMEBRIDGE_OPTS=-U /var/lib/homebridge
# DEBUG=*</code></pre><h3 id="startup-and-logging">Startup and Logging</h3><p>A 3 step dance.</p><pre><code class="language-bash"># This is to load any changes
# Do this everytime you a file content is changed
sudo systemctl daemon-reload

# Make the service restart every boot
sudo systemctl enable homebridge

# Start up the service
sudo systemctl start homebridge</code></pre><p>To see if the service really started up corrrectly.</p><pre><code class="language-bash">$ sudo systemctl status homebridge

● homebridge.service - Node.js HomeKit Server
   Loaded: loaded (/etc/systemd/system/homebridge.service; enabled; vendor preset: enabled)
   Active: active (running) since Sat 2019-05-25 17:56:31 BST; 5s ago
 Main PID: 13572 (homebridge)
   CGroup: /system.slice/homebridge.service
           └─13572 homebridge
</code></pre><p>To see the logs printed out by the service to system out</p><pre><code class="language-bash">$ sudo journalctl -u homebridge

May 25 17:56:31 raspberrypi systemd[1]: Started Node.js HomeKit Server.
May 25 17:56:34 raspberrypi homebridge[13572]: [2019-5-25 17:56:34] Loaded config.json with 1 accessories and 0 platforms.
May 25 17:56:34 raspberrypi homebridge[13572]: [2019-5-25 17:56:34] ---
May 25 17:56:34 raspberrypi homebridge[13572]: [2019-5-25 17:56:34] Loaded plugin: homebridge-webos-tv
May 25 17:56:34 raspberrypi homebridge[13572]: [2019-5-25 17:56:34] Registering accessory 'homebridge-webos-tv.webostv'
May 25 17:56:34 raspberrypi homebridge[13572]: [2019-5-25 17:56:34] ---
May 25 17:56:34 raspberrypi homebridge[13572]: [2019-5-25 17:56:34] Loading 1 accessories...
May 25 17:56:34 raspberrypi homebridge[13572]: [2019-5-25 17:56:34] [TV] Initializing webostv accessory...</code></pre><h3 id="references">References</h3><ul><li><a href="https://gist.github.com/johannrichard/0ad0de1feb6adb9eb61a/">https://gist.github.com/johannrichard/0ad0de1feb6adb9eb61a/</a></li><li><a href="https://www.digitalocean.com/community/tutorials/understanding-systemd-units-and-unit-files">https://www.digitalocean.com/community/tutorials/understanding-systemd-units-and-unit-files</a></li></ul>
