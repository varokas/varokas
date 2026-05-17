---
layout: post
title: Callback and Promise
date: '2017-07-09 00:00:00 +0000'
slug: callback-and-promise
permalink: "/callback-and-promise/"
author: Varokas Panusuwan
tags: []
excerpt: |2

  การเรียกใช้โค้ด Asynchronus แบบชิคๆคุลๆ
canonical_url: https://medium.com/@varokas/callback-and-promise-f3e0724e0a8d
ghost_id: 5e929aca9c3d50000174a329
visibility: public
---

<p>การเรียกใช้โค้ด Asynchronus แบบชิคๆคุลๆ</p><h3 id="-">สรุปแบบขี้เกียจอ่าน</h3><ul><li>Sync ใส่ input เป็น parameter ได้ output ออกมาเป็น return ของ method</li><li>Callbacks ใส่ input และ callback function เป็น parameter ผลลัพธ์จะผ่านมาตอน function ที่ฝากไว้โดนเรียก(จากสวรรค์)</li><li>Promise ใส่ input ได้ output แต่ต้องไปแงะเอาข้อมูลข้างใน output มาใช้เอง</li></ul><p>ปล. ไว้เข้าใจ Generator, Async-Await แล้วจะมาอัพเดท</p><h3 id="sync">Sync</h3><p>อันนี้ไม่ใช่ async แต่ใส่มาไว้เปรียบเทียบ ใส่ input แล้วก็เรียก method ได้ output ตรงๆ</p><pre><code>function doStuff(input) {
  return "output";
}

let output = doStuff("input");
console.log(output);</code></pre><h3 id="callback">Callback</h3><p>ใส่ input เป็น parameter เหมือนปกติ แต่ใส่ callback method เข้าไปด้วย แต่จะไม่ได้อะไรคืนมาจาก method</p><p>output จะผ่านมาเป็น parameter ของ callback ที่ฝากไว้ จะทำอะไรกับ output นั้นก็ต้องใส่ไว้ที่ callback</p><pre><code>function doStuff(input, callback) {
  callback("output");
}

let myCallback = (output) =&gt; { console.log(output) };

doStuff("input", myCallback);</code></pre><h3 id="promise">Promise</h3><p>ใส่ input เป็น parameter เหมือนปกติ แล้วก็ได้ output ทาง method ซึ่งเหมือนจะโดนหลอกว่าได้ผลลัพธ์ปกติ แต่ต้องไป “แงะ” เอาผลลัพธ์ข้างในออกมาเอง</p><pre><code>function doStuff(input) {
  return Promise.resolve("output")
}

let returnedPromise = doStuff("input");

returnedPromise.then( (output) =&gt; {console.log(output);} )</code></pre><p>อันนี้จะทำให้เหมือนโดนหลอกว่าเป็น synchronous call แต่อย่าลืมว่า มันไม่ได้ block ตรงที่ then นะ มันจะผ่านไปเลย แล้วก็เรียก function ข้างในเมื่อ promise มันพร้อม</p><h3 id="convert-callback-to-promise">Convert Callback to Promise</h3><p>แปลงได้โดยการเรียกสร้าง promise ที่ไปเรียก method เดิม โดย callback ที่ส่งเข้าไปจะไปเรียก resolve ของ promise เมื่อต้องการจะส่ง output ออกมา

</p><pre><code>//Original callback accepting method
function doStuff(input, callback) {
  callback("output");
}

function doStuffPromise(input) {
  return new Promise((resolve) =&gt; {
    doStuff(input, (output) =&gt; { resolve(output); })
  })
}</code></pre>
