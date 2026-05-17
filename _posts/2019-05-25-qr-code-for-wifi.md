---
layout: post
title: Generate QR Code for WiFi
date: '2019-05-25 04:20:22 +0000'
slug: qr-code-for-wifi
permalink: "/qr-code-for-wifi/"
author: Varokas Panusuwan
tags:
- javascript
feature_image: https://images.unsplash.com/photo-1516496636080-14fb876e029d?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjExNzczfQ
ghost_id: 5e929aca9c3d50000174a341
visibility: public
codeinjection_head: <link rel="stylesheet" type="text/css" href="https://storage.googleapis.com/app.klipse.tech/css/codemirror.css">
codeinjection_foot: |
  <script>
      window.klipse_settings = {
          selector_eval_js: '.language-klipse-eval-js', // css selector for the html elements you want to klipsify
      };
  </script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.qrcode/1.0/jquery.qrcode.min.js"></script>
  <script src="https://storage.googleapis.com/app.klipse.tech/plugin_prod/js/klipse_plugin.min.js"></script>
---

<p>Instead of having your guests hunting for WiFi name and type in your weird password, let them scan a QR code and connect with ease.</p><p>Change <code>wifi-name</code> , <code>wifi-password</code> below and save the QR code.</p><pre><code class="language-klipse-eval-js">const wifi_name = "wifi-name"
const wifi_password = "wifi-password"

escape = (s) =&gt; s.replace(/\\|;|,|:/g, c =&gt; `\\{c}`)
const name = escape(wifi_name)
const pass = escape(wifi_password)

const str = `WIFI:T:WPA;S:${name};P:${pass};;`

const dataUrl = jQuery('#qrcode').empty().qrcode({text: str}).find('canvas')[0].toDataURL()
jQuery('#qr_img').attr('src',dataUrl)
str</code></pre><p></p><!--kg-card-begin: html--><div id="qrcode" style="display:none"></div>
<img id="qr_img" style="width:40%" src="">
<p></p><!--kg-card-end: html--><p>To download the code, right-click and select "Save Image As..". Or Long-press and "Save Image" if you are on iOS.</p><h3 id="scanning-the-code-ios-">Scanning the Code (iOS)</h3><figure class="kg-card kg-image-card"><img src="/assets/images/ghost/2019/05/IMG_B4A3E8F10D07-1.jpeg" class="kg-image" alt loading="lazy"></figure><ol><li>Open iOS camera</li><li>Point it at the QR Code</li><li>Tap the popped up notification</li></ol><h3 id="generate-code-from-terminal">Generate code from terminal</h3><p>Understandably, you may not be comfortable typing your wifi-password in a browser. We could also generate a QR code via terminal. </p><pre><code class="language-bash">brew install qrencode

qrencode -o code.png "WIFI:T:WPA;S:wifi-name;P:wifi-password;;"</code></pre><h3 id="references">References</h3><ul><li><a href="https://github.com/zxing/zxing/wiki/Barcode-Contents#wi-fi-network-config-android-ios-11">https://github.com/zxing/zxing/wiki/Barcode-Contents#wi-fi-network-config-android-ios-11</a></li><li><a href="http://jeromeetienne.github.io/jquery-qrcode/">http://jeromeetienne.github.io/jquery-qrcode/</a></li><li><a href="https://fukuchi.org/works/qrencode/">https://fukuchi.org/works/qrencode/</a></li></ul>
