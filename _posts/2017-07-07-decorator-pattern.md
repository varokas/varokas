---
layout: post
title: Decorator Pattern
date: '2017-07-07 00:00:00 +0000'
slug: decorator-pattern
permalink: "/decorator-pattern/"
author: Varokas Panusuwan
tags: []
excerpt: |2

  จาก บทความที่แล้วเรื่อง CVA บอกว่าถ้าหา common-variable จาก context of use ไปเรื่อยๆ จะเจอดีไซน์ที่ดีได้โดยไม่ต้องพยายามท่องจำ Design…
feature_image: /assets/images/ghost/downloaded_images/Decorator-Pattern/1-Dy_N7bqHsGqg04d-PvvlOg-1.png
canonical_url: https://medium.com/@varokas/decorator-pattern-6693eb14dba5
ghost_id: 5e929aca9c3d50000174a333
visibility: public
---

<p>จาก <a href="https://varokas.com/commonality-variability-analysis-cva-9da5802283d8">บทความที่แล้วเรื่อง CVA</a> บอกว่าถ้าหา common-variable จาก context of use ไปเรื่อยๆ จะเจอดีไซน์ที่ดีได้โดยไม่ต้องพยายามท่องจำ Design Pattern</p><p>ทำให้ดูอีกตัวอย่างนึง</p><h3 id="requirement">Requirement</h3><ul><li>ร้านกาแฟนางเงือก ขยายกิจการ ทำโปรแกรมคิดค่าชานม</li><li>ชานมเลือกใส่ของเพิ่มเป็น ไข่มุก 10 บาท, เฉาก๊วย 15 บาท</li><li>ราคาชานม คิดจาก ค่าชานม กับ ค่าของเพิ่มรวมๆกัน</li></ul><h3 id="context-of-use">Context of Use</h3><p>โปรแกรมต้องการคิดราคาของชานม (ไม่ได้พูดถึงการชง สต็อกสินค้า ฯลฯ)</p><figure class="kg-card kg-image-card"><img src="/assets/images/ghost/downloaded_images/Decorator-Pattern/1-G2NteWAYurWjOXwF4x7uZQ.png" class="kg-image" alt loading="lazy"></figure><h3 id="common">Common</h3><p>ของเพิ่ม</p><ul><li>ใส่เพิ่มเข้าไปใน ชานม ได้เหมือนกัน</li><li>มีราคาเหมือนกัน (เวลาคิดตังก็เอาราคาชา + ราคาของเพิ่มในชารวมๆกัน)</li></ul><figure class="kg-card kg-image-card"><img src="/assets/images/ghost/downloaded_images/Decorator-Pattern/1-gEZE-wYGL2h3wzIFdWxE6g.png" class="kg-image" alt loading="lazy"></figure><ul><li>มอง context เดิมอีกที ทั้งชานม และ ของเพิ่ม มี ราคา เอาไปคิดเงินได้เหมือนกัน กลายเป็นสินค้า (Product)</li></ul><figure class="kg-card kg-image-card"><img src="/assets/images/ghost/downloaded_images/Decorator-Pattern/1-eU1jKxQRysHH8BItYn99Bw.png" class="kg-image" alt loading="lazy"></figure><h3 id="variable">Variable</h3><ul><li>ของเพิ่มมีหลายแบบ และราคาไม่เท่ากัน</li></ul><figure class="kg-card kg-image-card kg-card-hascaption"><img src="/assets/images/ghost/downloaded_images/Decorator-Pattern/1-Dy_N7bqHsGqg04d-PvvlOg.png" class="kg-image" alt loading="lazy"><figcaption>ภาษาไฮโซเรียกว่า Decorator Pattern</figcaption></figure><h3 id="-">ข้อสังเกต</h3><ul><li>MilkTea ไม่ได้แยกออกมาเป็นชาหลายแบบ เพราะเห็นๆอยู่ว่ามีแบบเดียว</li><li>เรียกว่า Product เพราะ context of use คือ การขายของ เลยไม่ได้เรียกว่า Drinks</li><li>Requirement จริง ไม่ได้แยกออกมาให้เห็นง่ายขนาดนี้ จงเน้นความเข้าใจปัญหามากกว่าการแก้ปัญหา</li><li>เมื่อเราเข้าใจปัญหา ดีไซน์และโค้ดที่เขียนออกมาก็จะเรียบง่าย</li></ul>
