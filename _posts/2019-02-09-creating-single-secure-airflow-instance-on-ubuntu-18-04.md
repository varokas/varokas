---
layout: post
title: Creating Single secure Airflow instance on Ubuntu 18.04
date: '2019-02-09 00:00:00 +0000'
slug: creating-single-secure-airflow-instance-on-ubuntu-18-04
permalink: "/creating-single-secure-airflow-instance-on-ubuntu-18-04/"
author: Varokas Panusuwan
tags: []
excerpt: |2

  Airflow installation beyond the basics are pretty involved. This is my notes on how. This note assumes the reader wanted to access airflow…
feature_image: /assets/images/ghost/downloaded_images/Creating-Single-secure-Airflow-instance-on-Ubuntu-18-04/1-pgkHmdsaWdJ5fcFmxIZ6sw-1.jpeg
canonical_url: https://medium.com/@varokas/creating-single-secure-airflow-instance-on-ubuntu-18-04-9441b6d966b
ghost_id: 5e929aca9c3d50000174a31f
visibility: public
---

<p><a href="https://airflow.apache.org">Airflow</a> installation beyond the basics are pretty involved. This is my notes on how. This note assumes the reader wanted to access airflow from public web and …</p><ul><li>have a domain name to use</li><li>Know how to create an ubuntu instance in the cloud (AWS, GCE, etc), with a sudo access</li><li>Know how to config a firewall to that instance</li></ul><h3 id="create-a-linux-user-for-airflow">Create a linux user for AirFlow</h3><p>We will be creating a user airflow. We are going to install and set up services using this user. It is better to isolate this user from the user that we use to log in.</p><p>For Google Cloud Engine, this is simply to login with a new user</p><pre><code>$ gcloud compute ssh airflow@airflow</code></pre><p>Or create it manually using this link : [<a href="https://www.digitalocean.com/community/tutorials/how-to-create-a-sudo-user-on-ubuntu-quickstart">How To Create a Sudo User on Ubuntu Quickstart | DigitalOcean</a>]</p><p>From this point, it will be assumed that we are logged in with the user airflow</p><h3 id="install-airflow">Install Airflow</h3><p>First install pip3. Python3 is already installed with Ubuntu 18.04</p><pre><code>$ sudo apt update
$ sudo apt install python3-pip</code></pre><p>Now Install airflow</p><pre><code># To allow airflow to install 
$ export AIRFLOW_GPL_UNIDECODE=yes

# Install the package itself
$ pip3 install apache-airflow</code></pre><p>Restart the shell to make sure PATH is update for pip3 (or log off / log on ssh again). Otherwise, we cannot execute `airflow` from the bash.</p><p>After logged back in, run airflow once to create `~/airflow` directory</p><pre><code>$ airflow</code></pre><h3 id="create-postgresdb-as-backend-database">Create PostgresDB as backend database</h3><p>Although airflow by default use sqlite, it will be restricted to only 1 task at a time. we should just go ahead and setup a proper database backend.</p><pre><code>$ sudo apt install postgresql</code></pre><p>Then create the database, a user and their password. psql only works with the user postgres, so we need to sudo as that user</p><pre><code>$ sudo -u postgres psql -c "create database airflow"
$ sudo -u postgres psql -c "create user airflow with encrypted password 'mypass'";
$ sudo -u postgres psql -c "grant all privileges on database airflow to airflow";</code></pre><p>After that install a package in airflow to support postgresql</p><pre><code>$ pip3 install apache-airflow[postgres]
$ pip3 install psycopg2</code></pre><p>Change airflow config to connect to the newly created database.</p><pre><code>### vi ~/airflow/airflow.cfg ###

sql_alchemy_conn = postgresql+psycopg2://airflow:mypass@localhost/airflow</code></pre><p>Run command to initialize database</p><pre><code>$ airflow initdb</code></pre><h3 id="test-run">Test Run</h3><p>At this point we should test run that airflow works. Make sure port 8080 is open</p><pre><code>$ airflow web server -p 8080</code></pre><p>In order to start running a job, a schedule needs to also run in foreground. Logs in with another session of ssh then execute</p><pre><code>$ airflow scheduler</code></pre><p>To test run a job. Go to http://&lt;yoursite&gt;:8080. Dont forget to turn “ON” the DAG before clicking run.</p><figure class="kg-card kg-image-card"><img src="/assets/images/ghost/downloaded_images/Creating-Single-secure-Airflow-instance-on-Ubuntu-18-04/1-lQhX5gvYMtphbep7UHdw5Q.png" class="kg-image" alt loading="lazy"></figure><h3 id="create-service-with-systemd">Create Service with Systemd</h3><p>So that airflow runs in background and starts up automatically with the server.</p><ul><li><a href="https://github.com/apache/airflow/tree/master/scripts/systemd">https://github.com/apache/airflow/tree/master/scripts/systemd</a>)</li><li><a href="https://www.linode.com/docs/quick-answers/linux-essentials/what-is-systemd/">https://www.linode.com/docs/quick-answers/linux-essentials/what-is-systemd/</a></li></ul><p>First copy the default systemd service script from airflow github</p><pre><code>$ sudo curl -o /etc/systemd/system/airflow-webserver.service https://raw.githubusercontent.com/apache/airflow/master/scripts/systemd/airflow-webserver.service

$ sudo curl -o /etc/systemd/system/airflow-scheduler.service https://raw.githubusercontent.com/apache/airflow/master/scripts/systemd/airflow-scheduler.service</code></pre><p>The default script was meant to be run in CentOS/Redhat. So we need to adjust some parameters.</p><pre><code>#############################################################
### sudo vi /etc/systemd/system/airflow-webserver.service ### 
#############################################################

# EnvironmentFile=/etc/sysconfig/airflow (comment out this line)
Environment="PATH=/home/airflow/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
ExecStart=/home/airflow/.local/bin/airflow webserver — pid /home/airflow/airflow-webserver.pid

############################################################# 
### sudo vi /etc/systemd/system/airflow-scheduler.service ### 
#############################################################

# EnvironmentFile=/etc/sysconfig/airflow (comment out this line)
Environment="PATH=/home/airflow/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

ExecStart=/home/airflow/.local/bin/airflow scheduler</code></pre><p>After the services files are edited, reload it to systemd daemon</p><pre><code>$ sudo systemctl daemon-reload</code></pre><p>Then start the servers</p><pre><code>$ sudo systemctl start airflow-webserver
$ sudo systemctl start airflow-scheduler</code></pre><p>We can check the status of each service using command</p><pre><code>$ sudo systemctl status airflow-webserver
$ sudo systemctl status airflow-scheduler</code></pre><figure class="kg-card kg-image-card"><img src="/assets/images/ghost/downloaded_images/Creating-Single-secure-Airflow-instance-on-Ubuntu-18-04/1-M41uhEmGhJIwXbrVCDob8Q.png" class="kg-image" alt loading="lazy"></figure><p>If all is well, enable these two services to start at boot</p><pre><code>$ sudo systemctl enable airflow-webserver
$ sudo systemctl enable airflow-scheduler</code></pre><h3 id="secure-with-nginx-and-ssl">Secure with Nginx and SSL</h3><p>Although airflow can do SSL by itself, it is probably better to use it via nginx proxy so that the certs are taken care of automatically by letsencrypt.</p><p>This is just a shorthand note of <a href="https://www.digitalocean.com/community/tutorials/how-to-secure-nginx-with-let-s-encrypt-on-ubuntu-18-04">https://www.digitalocean.com/community/tutorials/how-to-secure-nginx-with-let-s-encrypt-on-ubuntu-18-04</a></p><p>First Install and enable nginx. Make sure port 80 is enabled.</p><pre><code>$ sudo apt install nginx

# Verify that nginx works by going to http://&lt;yoursite&gt;

$ sudo systemctl enable nginx</code></pre><p>Create Nginx config to proxy from port 80 -&gt;8080.</p><pre><code>### sudo vi /etc/nginx/sites-available/airflow ### 

server {
    listen 80;
    server_name &lt;your server name&gt;;

location / {
        proxy_pass http://localhost:8080;
        proxy_set_header Host $host;
        proxy_redirect off;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
    }
}</code></pre><p>Then create replace the default config with this one</p><pre><code>$ sudo rm /etc/nginx/sites-enabled/default
$ sudo ln -s /etc/nginx/sites-available/airflow /etc/nginx/sites-enabled/airflow

# Run to check that nginx configs are correct
$ sudo nginx -t

# Reload the config, no need for restart
$ sudo systemctl reload nginx</code></pre><p>After that modify airflow config to enable proxy</p><pre><code>### vi ~/airflow/airflow.cfg ###

enable_proxy_fix = True

###

# Restart airflow webserver
$ sudo systemctl restart airflow-webserver</code></pre><p>Verify by going to http://&lt;yoursite&gt; (without the port 8080). It should be proxied correctly.</p><p>At this point we can drop 8080 from firewall.</p><h3 id="ssl-with-certbot">SSL with Certbot</h3><p>Make sure port 443 (https) is open</p><pre><code>$ sudo add-apt-repository ppa:certbot/certbot
$ sudo apt install python-certbot-nginx

$ sudo certbot --nginx -d www.yourwebsite.com

Answer some prompts 
(When asked to choose whether to redirect, say yes (2)
Please choose whether or not to redirect HTTP traffic to HTTPS, removing HTTP access.)</code></pre><p>Verify by going to http://&lt;yoursite&gt; (without the port 8080). It should get redirected to https://&lt;yoursite&gt; and the website should be displayed correctly.</p><h3 id="protect-with-simple-password-auth">Protect with simple password auth</h3><p>Airflow has a few security connectors. The simplest one asked us to add username/password via command line</p><ul><li><a href="https://airflow.apache.org/security.html#password">https://airflow.apache.org/security.html#password</a></li></ul><p>Install flash-bcrypt (The manual does not mentioned this)</p><pre><code>$ pip3 install flask-bcrypt</code></pre><p>Then edit config file</p><pre><code>### vi ~/airflow/airflow.cfg ### 

[webserver]
authenticate = True
auth_backend = airflow.contrib.auth.backends.password_auth

####

$ sudo systemctl restart airflow-webserver</code></pre><p>Create an airflow user from command line

</p><pre><code class="language-python">/# navigate to the airflow installation directory/
$ cd ~/airflow
$ python3

import airflow
from airflow import models, settings
from airflow.contrib.auth.backends.password_auth import PasswordUser
user = PasswordUser(models.User())
user.username = 'new_user_name'
user.email = 'new_user_email@example.com'
user.password = 'set_the_password'
session = settings.Session()
session.add(user)
session.commit()
session.close()
exit()</code></pre>
