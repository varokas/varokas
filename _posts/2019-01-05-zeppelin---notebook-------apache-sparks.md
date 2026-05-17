---
layout: post
title: Zeppelin — Notebook สำหรับApache Sparks
date: '2019-01-05 00:00:00 +0000'
slug: zeppelin---notebook-------apache-sparks
permalink: "/zeppelin---notebook-------apache-sparks/"
author: Varokas Panusuwan
tags: []
excerpt: |2

  สำหรับคนที่ติดใจเขียนโปรแกรมแบบ notebook ผ่าน jupyter ตอนนี้มีโปรเจคที่ค่อนข้างใหม่ชื่อ Apache Zeppelin เหมาะมากสำหรับสาย data ที่ใช้…
feature_image: /assets/images/ghost/downloaded_images/Zeppelin---Notebook-------Apache-Sparks/1-bJigZtBnodqs4vw8QbezEA-1.png
canonical_url: https://medium.com/@varokas/zeppelin-notebook-%E0%B8%AA%E0%B8%B3%E0%B8%AB%E0%B8%A3%E0%B8%B1%E0%B8%9Aapache-sparks-5719da64124c
ghost_id: 5e929aca9c3d50000174a320
visibility: public
---

<p>สำหรับคนที่ติดใจเขียนโปรแกรมแบบ notebook ผ่าน jupyter ตอนนี้มีโปรเจคที่ค่อนข้างใหม่ชื่อ Apache Zeppelin เหมาะมากสำหรับสาย data ที่ใช้ Apache Sparks</p><p>ข้อดีหลักๆ</p><ul><li>Integrate กับ Sparks และ SQL เนียนๆ visualization สวยๆ</li><li>วาง widget ไว้แนวขวางได้ด้วย ไม่ต้องเป็นแนวนอนอย่างเดียว</li><li>ปรับแต่ง UI ได้ด้วย Angular</li></ul><h3 id="-">วิธีลง</h3><p>ลง Sparks ก่อน เวลาลงถ้าไม่ได้ใช้ java8 ตัว brew จะบ่นๆ</p><pre><code>brew cask install homebrew/cask-versions/java8
brew install apache-spark</code></pre><p>จากนั้นลง Zeppelin ได้เลย ไม่จำเป็นต้องลง scala</p><pre><code>brew install apache-zeppelin</code></pre><h3 id="--1">ใช้งาน</h3><p>เรียกใช้ server แบบนี้</p><pre><code>zeppelin-daemon.sh start</code></pre><p>จากนั้นก็ไปที่ <a href="http://localhost:8080">http://localhost:8080</a> ได้เลย ตัว script จะรันแบบ daemon ไม่จำเป็นต้องเปิด terminal ทิ้งไว้</p><figure class="kg-card kg-image-card"><img src="/assets/images/ghost/downloaded_images/Zeppelin---Notebook-------Apache-Sparks/1-t6TTUf1nh3lktld-U-V6bg.png" class="kg-image" alt loading="lazy"></figure><p>เปิดตัวอย่าง Basic Features ขึ้นมาแล้วก็เลือก Run All paragraphs</p><figure class="kg-card kg-image-card"><img src="/assets/images/ghost/downloaded_images/Zeppelin---Notebook-------Apache-Sparks/1-MUoSJyRMxXiHoCriPSn3eA.png" class="kg-image" alt loading="lazy"></figure><figure class="kg-card kg-image-card"><img src="/assets/images/ghost/downloaded_images/Zeppelin---Notebook-------Apache-Sparks/1-tys4wJ80RajCGMLiAQr3fw.png" class="kg-image" alt loading="lazy"></figure><p>เมื่อรันเสร็จแล้วสามารถไปดู Job ใน Sparks UI ได้ด้วย</p><figure class="kg-card kg-image-card"><img src="/assets/images/ghost/downloaded_images/Zeppelin---Notebook-------Apache-Sparks/1-UE-oV1Fa2XvnBuoJhxZrpg.png" class="kg-image" alt loading="lazy"></figure><figure class="kg-card kg-image-card"><img src="/assets/images/ghost/downloaded_images/Zeppelin---Notebook-------Apache-Sparks/1-WiuFWLgZ9CO8871ujtStLw.png" class="kg-image" alt loading="lazy"></figure><h3 id="troubleshooting">Troubleshooting</h3><p>ถ้าตอนที่รันเจอ error แบบนี้</p><pre><code>error: scala.reflect.internal.MissingRequirementError: object scala in compiler mirror not found.</code></pre><p>ให้ลบ Java Version อื่นๆ ออกจากเครื่อง เก็น Java8 ที่ลงผ่าน brew ไว้อย่างเดียว

</p>
