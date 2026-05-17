---
layout: post
title: เมื่อไหร่ใช้ composition เมื่อไหร่ใช้ inheritance
date: '2017-06-25 00:00:00 +0000'
slug: "-------------composition--------------inheritance"
permalink: "/-------------composition--------------inheritance/"
author: Varokas Panusuwan
tags: []
excerpt: |2

  ทำไมเรายังต้องคุยเรื่องนี้กันอีกนะ
canonical_url: https://medium.com/@varokas/%E0%B9%80%E0%B8%A1%E0%B8%B7%E0%B9%88%E0%B8%AD%E0%B9%84%E0%B8%AB%E0%B8%A3%E0%B9%88%E0%B9%83%E0%B8%8A%E0%B9%89-composition-%E0%B9%80%E0%B8%A1%E0%B8%B7%E0%B9%88%E0%B8%AD%E0%B9%84%E0%B8%AB%E0%B8%A3%E0%B9%88%E0%B9%83%E0%B8%8A%E0%B9%89-inheritance-fcca9af05f60
ghost_id: 5e929aca9c3d50000174a328
visibility: public
---

<h3 id="-">ทำไมเรายังต้องคุยเรื่องนี้กันอีกนะ</h3><h3 id="--1">สรุปแบบขี้เกียจอ่าน</h3><p>โดยมุมมองจาก Emergent Design</p><ul><li>Inherit เมื่อต้องการบังคับว่า ทั้งหมดเหมือนเดิมยกเว้นจุดเล็กๆ</li><li>Composite เมื่อต้องการตัดจุดหนึ่งออกมาจากส่วนเดิมที่สามารถมี implementation หลายแบบ (encapsulate variations)</li><li>Composite over Inheritance เพราะปัญหาการออกแบบจำนวนมาก เป็นการลดความซับซ้อนโดยการ encapsulate variations</li><li>ใช้ Commonality-Variability Analysis เสมอเวลาออกแบบ อย่ารีบ encapsulate สิ่งที่ยังไม่จำเป็น(ด้วย composite)</li></ul><hr><h3 id="inheritance-">Inheritance มาจากไหน</h3><p>มักเกิดจากการที่เราเอาของเดิม มา “แก้นิดเดียว” ให้ได้การทำงานตามต้องการ เช่น เรามีโปรแกรมนึง อ่านจากไฟล์ ประมวลผล แล้วพิมพ์ออกหน้าจอ ซึ่งต่อมาต้องการให้พิมพ์ออกเครื่องพิมพ์ด้วย</p><figure class="kg-card kg-image-card"><img src="/assets/images/ghost/downloaded_images/-------------composition--------------inheritance/1-_UUWPIcH5yQx1Fvsjbbp2g.png" class="kg-image" alt loading="lazy"></figure><p>แบบนี้เรากำลังบอกคนอื่นว่า มีโปรแกรมอยู่แล้ว มีอีกตัวนึงซึ่งเหมือนตัวเดิมเลยแค่แก้ตอนเขียนเป็นเขียนไฟล์แทน ซึ่งไม่น่าจะตรงกับสิ่งที่เราจะสื่อ</p><h3 id="-composite">แปลงเป็น Composite</h3><p>สิ่งที่เราต้องการจะสื่อ น่าจะเป็นว่า มีโปรแกรมอยู่<strong>ตัวเดียว </strong>แต่มีการเขียนออกไปได้สองทางคือ 1. หน้าจอ 2. เครื่องพิมพ์</p><p>ซึ่งก็คือ การ encapsulate การ write ออกมาต่างหากแบบนี้</p><figure class="kg-card kg-image-card kg-card-hascaption"><img src="/assets/images/ghost/downloaded_images/-------------composition--------------inheritance/1-XGf9aZTd1wrPyBXOovMX_g.png" class="kg-image" alt loading="lazy"><figcaption>Encapsulate Variation of Output Writing</figcaption></figure><h3 id="-inhertance">เมื่อไหร่ใช้ Inhertance</h3><p>ในอีกมุมนึง ถ้าเราอยากจะบอกว่า โปรแกรมของเราต้องมีการทำงานตามลำดับนี้</p><p>1. อ่าน 2. ประมวลผล 3. เขียน</p><p>และเราบังคับให้โปรแกรมอื่นๆอีกหลายอัน ที่ออกมาจากต้นแบบของเราจะมีลำดับตามที่กำหนดข้างบน แต่มีส่วน (2. ประมวลผล) เท่านั้นที่ต่างกัน จะได้แบบนี้</p><figure class="kg-card kg-image-card kg-card-hascaption"><img src="/assets/images/ghost/downloaded_images/-------------composition--------------inheritance/1-0mS2owZTwThXduGUREuANg.png" class="kg-image" alt loading="lazy"><figcaption>ภาษาไฮโซเค้าเรียกว่า template method pattern</figcaption></figure><h3 id="--2">ทำไมเรายังต้องคุยเรื่องนี้กันอีกนะ</h3><p>ทำไมเราไม่ทำ Commonality-Variability Analysis อย่างสม่ำเสมอ แล้วจะชัดเองว่าควรทำอะไร โดยเน้นความเข้าใจตรงกับโปรแกรมเมอร์คนอื่นๆว่าเราต้องการซ่อนความซับซ้อนไว้ตรงไหน</p><p>ของบางอย่างที่เหมาะกับ inheritance นานๆไปซับซ้อนขึ้นอาจจะเหมาะกับ composite มากกว่าก้อได้ (มักจะไม่ไปในทางกลับกัน)</p><p>ในอีกมุมนึง ถ้าของยังไม่มี variation จะไปรีบไปตัดออกมาก็จะเป็นการเพิ่มความซับซ้อนให้กับโปรแกรมเปล่าๆ

</p>
