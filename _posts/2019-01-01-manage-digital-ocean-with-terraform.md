---
layout: post
title: Manage Digital Ocean with Terraform
date: '2019-01-01 00:00:00 +0000'
slug: manage-digital-ocean-with-terraform
permalink: "/manage-digital-ocean-with-terraform/"
author: Varokas Panusuwan
tags: []
excerpt: |2

  สำหรับคนที่ชอบเปิดเอา Compute Node มาเล่นแต่ยังไม่ใช้ Kubernetes ถ้าใช้ Terraform เราก็จะสามารถ สร้างและเชื่อมกับ DNS ได้เลยเร็วๆ บน…
feature_image: /assets/images/ghost/downloaded_images/Manage-Digital-Ocean-with-Terraform/1-3bi_J6ufIUsZNnCGUxBowA-1.png
canonical_url: https://medium.com/@varokas/manage-digital-ocean-with-terraform-a30221964adf
ghost_id: 5e929aca9c3d50000174a322
visibility: public
---

<figure class="kg-card kg-image-card"><img src="/assets/images/ghost/downloaded_images/Manage-Digital-Ocean-with-Terraform/1-3bi_J6ufIUsZNnCGUxBowA.png" class="kg-image" alt loading="lazy"></figure><p>สำหรับคนที่ชอบเปิดเอา Compute Node มาเล่นแต่ยังไม่ใช้ Kubernetes ถ้าใช้ Terraform เราก็จะสามารถ สร้างและเชื่อมกับ DNS ได้เลยเร็วๆ บน Digital Ocean ปกติเห็นตัวอย่างในเวปจะมีแต่ใช้ AWS กัน</p><p>เข้าไปดูเต็มๆได้เลยที่นี่</p><p><a href="https://github.com/varokas/tf-scripts/blob/master/modules/do/main.tf"><strong>varokas/tf-scripts</strong></a><br><a href="https://github.com/varokas/tf-scripts/blob/master/modules/do/main.tf"><em>Terraform Scripts. Contribute to varokas/tf-scripts development by creating an account on GitHub.</em></a><a href="https://github.com/varokas/tf-scripts/blob/master/modules/do/main.tf">github.com</a></p><p>ด้านบนสุดของไฟล์จะเป็นการประกาศ provider ที่ใช้ พร้อมกับ Credential ที่จะใช้ ส่วนมาจะประกาศเป็น variables ไว้จะได้ไม่เผลอ commit เข้ามา แล้วใส่ของจริงไว้ใน terraform.tfvars ซึ่งจะเป็น .gitignore ไว้</p><pre><code>provider "digitalocean" {
  token = "${var.do_token}"
}

provider "cloudflare" {
  email = "${var.cloudflare_email}"
  token = "${var.cloudflare_token}"
}</code></pre><p>จากนั้นก็อัพโหลด public key ที่จะใช้เข้าไป `public_key_path` default ไว้ที่ ~/.ssh/terraform.pub เปลี่ยนได้ตามใจชอบ</p><pre><code>resource "digitalocean_ssh_key" "terraform" {
  name       = "terraform"
  public_key = "${file(var.public_key_path)}"
}</code></pre><p>จากนั้นก็สร้าง droplet ได้เลย ตรงนี้จะมีจุดที่ทำได้ไม่ดีอย่างนึง ต้องบอก Digital Ocean ว่า MD5 Fingerprint ของ public key ที่จะใช้คืออะไร (แทนที่จะใช้ชื่อที่เพิ่ง upload ไป !?!) ก็เลยต้องประกาศตัวแปรไว้ แล้วก็อปค่าไปแปะเอาเอง</p><pre><code>$ ssh-keygen -E md5 -lf ~/.ssh/terraform.pub | awk '{print $2}'
MD5:89:1b:3e:b1:cd:37:53:9c:78:19:48:6b:e6:df:81:fe</code></pre><p>เวลาก็อปมาไม่ต้องเอา MD5: มาด้วย ได้เป็นแบบนี้</p><pre><code>terraform_ssh_fingerprint="89:1b:3e:b1:cd:37:53:9c:78:19:48:6b:e6:df:81:fe"</code></pre><p>จากนั้นก็เอามาใช้ได้ใน droplet resource</p><pre><code>resource "digitalocean_droplet" "winter" {
  image  = "ubuntu-18-04-x64"
  name   = "winter"
  region = "sfo2"
  size   = "s-1vcpu-1gb"
  backups = "true"
  ssh_keys = ["${var.terraform_ssh_fingerprint}"]
}</code></pre><p>สุดท้ายเอา ip address ที่ได้ มา register DNS ผ่าน Cloudflare แบบนี้</p><pre><code># Create DNS record on CloudFlare
resource "cloudflare_record" "winter" {
  domain = "varokas.com"
  name   = "blog"
  value  = "${digitalocean_droplet.winter.ipv4_address}"
  type   = "A"
  ttl    = 3600
}</code></pre><p>จากนั้นก็สั่ง terraform apply แล้วก็ใช้ได้เลย

</p><pre><code>$ ssh -i ~/.ssh/terraform root@winter.varokas.com</code></pre>
