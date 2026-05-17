---
layout: post
title: Commonality-Variability Analysis (CVA)
date: '2017-06-30 00:00:00 +0000'
slug: commonality-variability-analysis--cva-
permalink: "/commonality-variability-analysis--cva-/"
author: Varokas Panusuwan
tags: []
excerpt: |2

  เลิก “ใช้” Design Patterns กันเถอะ
feature_image: /assets/images/ghost/downloaded_images/Commonality-Variability-Analysis--CVA-/1-lyRouuERA46FupvAMx8tDA-1.png
canonical_url: https://medium.com/@varokas/commonality-variability-analysis-cva-9da5802283d8
ghost_id: 5e929aca9c3d50000174a334
visibility: public
---

<h3 id="-design-patterns-">เลิก “ใช้” Design Patterns กันเถอะ</h3><h3 id="-">สรุปแบบขี้เกียจอ่าน</h3><p>ในการออกแบบแทนที่จะดูว่าตรงกับ Pattern ไหน ให้เน้นไปดูว่าควรจะซ่อนความซับซ้อน (Encapsulate Variations) อย่างไร แล้ว Design Pattern จะออกมาให้เห็นเอง</p><ul><li>สิ่งที่เหมือนกัน Common ทำเป็น Abstract / Interface</li><li>สิ่งที่ต่างกัน Variable แยกออกมาใส่เป็น Class ต่างๆ</li><li>โดยพิจารณา Context of Use จะได้ทำเฉพาะสิ่งที่จำเป็น</li></ul><hr><h3 id="--1">มันคืออะไร?</h3><p>Commonality-Variability Analysis เป็นหลักการวิเคราะห์ระบบและดีไซน์ว่าทำ encapsulation ได้ถูกจุดไหม ครบถ้วนแล้วหรือยัง มาจาก<a href="http://tobeagile.com/wp-content/uploads/2011/12/CoplienThesis.pdf">วิทยานิพนธ์</a>ของ James Coplien เขียนไว้ปี 2000</p><h3 id="--2">ทำไปทำไม?</h3><p>CVA เป็นเครื่องมือหนึ่งในการ Encapsulate Variations ที่สอนง่ายและเข้าใจง่าย</p><blockquote>เลิกมองว่า Design Pattern คือ เครื่องมือเอามาใช้ซ่อนความซับซ้อนให้มองว่า Design Pattern เป็นผลลัพธ์โดยธรรมชาติจากกระบวนการซ่อนความซับซ้อน<br></blockquote><h3 id="commonaility">Commonaility</h3><p>หาจุดที่เหมือนกันเอามาเขียนเป็น class เดียวกัน ตัวอย่างเช่นเช่น ดินสอ กับ ปากกา จะได้แบบนี้</p><figure class="kg-card kg-image-card"><img src="/assets/images/ghost/downloaded_images/Commonality-Variability-Analysis--CVA-/1-KXeHTAQt_WD2AhnFDFdSHg.png" class="kg-image" alt loading="lazy"></figure><h3 id="variability">Variability</h3><p>เอาจุดที่ต่างกัน แยกออกมาใส่ไว้ใน subclass/implementation</p><figure class="kg-card kg-image-card"><img src="/assets/images/ghost/downloaded_images/Commonality-Variability-Analysis--CVA-/1-lyRouuERA46FupvAMx8tDA.png" class="kg-image" alt loading="lazy"></figure><h3 id="context-of-use">Context of Use</h3><p>จะเห็นได้ว่าสองอย่างนี้ มีอะไรเหมือนและต่างกันมากมาย แต่ที่มีประโยชน์ก็แค่ส่วนที่โปรแกรมเราจะใช้</p><p>สมมติว่าเป็นโปรแกรมวาดรูป เหลือที่ใช้แค่นี้</p><figure class="kg-card kg-image-card"><img src="/assets/images/ghost/downloaded_images/Commonality-Variability-Analysis--CVA-/1-Kln4NpHQ4sAZgnJX1Kj-Uw.png" class="kg-image" alt loading="lazy"></figure><p>เอาสิ่งที่ไม่เกี่ยวออกไป แล้วแก้ชื่อ Interface ให้ดีขึ้น ก็เหลือแค่นี้</p><figure class="kg-card kg-image-card kg-card-hascaption"><img src="/assets/images/ghost/downloaded_images/Commonality-Variability-Analysis--CVA-/1-ywox9OXnO3stugcO321vnA.png" class="kg-image" alt loading="lazy"><figcaption>ภาษาไฮโซเค้าเรียกว่า Strategy Pattern</figcaption></figure><h3 id="--3">เคล็ดวิชา</h3><ul><li>ย้ำอีกครั้งว่า กระบวนการ encapsulate variations เป็นเหตุที่ทำให้เกิด design patterns ไม่ใช่ในทางกลับกัน</li><li>ตอนทำจริง ให้ดู Context of Use ก่อน แล้วค่อยไปดู​ Common-Variable (อธิบายในนี้สลับกันเพราะเข้าใจง่ายกว่า)</li><li>ถ้าตั้งชื่อ interface/abstract ไม่ถูก ลองทบทวน Context of Use ดีๆ (อาจมีซ้อนกัน)</li><li>สิ่งที่ “เป็น” ต่างกันมักจะกลายเป็น Properties</li><li>สิ่งที่ “ทำ” ต่างกันมักจะกลายเป็น Methods/Functions</li></ul>
