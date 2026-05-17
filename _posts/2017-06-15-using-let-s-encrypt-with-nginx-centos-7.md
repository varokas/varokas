---
layout: post
title: Using Let’s Encrypt with Nginx CentOS 7
date: '2017-06-15 00:00:00 +0000'
slug: using-let-s-encrypt-with-nginx-centos-7
permalink: "/using-let-s-encrypt-with-nginx-centos-7/"
author: Varokas Panusuwan
tags: []
excerpt: |2

  This is to recap the steps outlined in this digital ocean’s post
canonical_url: https://medium.com/@varokas/using-lets-encrypt-with-nginx-centos-7-2f569a09da90
ghost_id: 5e929aca9c3d50000174a338
visibility: public
---

<p>This is to recap the steps outlined in this digital ocean’s <a href="https://www.digitalocean.com/community/tutorials/how-to-secure-nginx-with-let-s-encrypt-on-centos-7">post</a></p><h3 id="setup-firewall">Setup Firewall</h3><pre><code>sudo firewall-cmd --add-port=443/tcp --permanent
sudo firewall-cmd --add-port=80/tcp --permanent
sudo firewall-cmd --reload</code></pre><h3 id="install-nginx">Install Nginx</h3><pre><code>sudo yum install nginx</code></pre><h3 id="configure-nginx-for-domain-validation">Configure Nginx for Domain Validation</h3><p>Let’s Encrypt needs to know that you are the legitimate domain owner. The easiest way to prove this is to add a path in nginx that Let’s Encrypt public server can call and validate</p><pre><code>$ sudo vi /etc/nginx/default.d/le-well-known.conf

location ~ /.well-known {
  allow all;
}

$ sudo systemctl restart nginx</code></pre><h3 id="obtain-the-cert">Obtain the cert</h3><pre><code>$ sudo certbot certonly -a webroot --webroot-path=/usr/share/nginx/html -d example.com -d www.example.com</code></pre><h3 id="generate-strong-diffie-hellman-group">Generate Strong Diffie-Hellman Group</h3><pre><code>$ sudo openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048</code></pre><h3 id="add-cert-to-nginx">Add Cert to Nginx</h3><pre><code>## /etc/nginx/conf.d/ssl.conf

server {
  listen 443 http2 ssl;
  server_name example.com www.example.com;
  ssl_certificate /etc/letsencrypt/live/example.com/fullchain.pem;
  ssl_certificate_key /etc/letsencrypt/live/example.com/privkey.pem;

  #################################################################
  # from https://cipherli.st/ 
  #and https://raymii.org/s/tutorials/Strong_SSL_Security_On_nginx.html         ###########################################################

  ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
  ssl_prefer_server_ciphers on;
  ssl_ciphers “EECDH+AESGCM:EDH+AESGCM:AES256+EECDH:AES256+EDH”;
  ssl_ecdh_curve secp384r1;
  ssl_session_cache shared:SSL:10m;
  ssl_session_tickets off;
  ssl_stapling on;
  ssl_stapling_verify on;

  resolver 8.8.8.8 8.8.4.4 valid=300s;
  resolver_timeout 5s;

  # Disable preloading HSTS for now. You can use the commented out header line that includes
  # the “preload” directive if you understand the implications.

  add_header Strict-Transport-Security “max-age=63072000;includeSubdomains; preload”;
  add_header Strict-Transport-Security “max-age=63072000;includeSubdomains”;
  add_header X-Frame-Options DENY;
  add_header X-Content-Type-Options nosniff;

##################################

# END https://cipherli.st/ BLOCK #

##################################

  ssl_dhparam /etc/ssl/certs/dhparam.pem;

  location ~ /.well-known {
    allow all;
  }

  # The rest of your server block
  root /usr/share/nginx/html;
  index index.html index.htm;

  location / {
    # First attempt to serve request as file, then
    # as directory, then fall back to displaying a 404.
    try_files $uri $uri/ =404;
  }
}</code></pre><h3 id="setup-http-redirects-to-https">Setup HTTP redirects to HTTPs</h3><pre><code>$ sudo vi /etc/nginx/default.d/ssl-redirect.conf

return 301 https://$host$request_uri;

$ sudo systemctl restart nginx</code></pre><p><strong>Enable Nginx</strong></p><pre><code>$ sudo systemctl enable nginx</code></pre><h3 id="setup-auto-renewal">Setup Auto Renewal

</h3><pre><code>$ sudo certbot renew
$ sudo crontab -e

30 2 * * 1 /usr/bin/certbot renew &gt;&gt; /var/log/le-renew.log
35 2 * * 1 /usr/bin/systemctl reload nginx

$ sudo systemctl restart nginx</code></pre>
