---
layout: post
title: สร้าง Kubernetes Cluster บน Google Cloud Platform
date: '2019-01-04 00:00:00 +0000'
slug: k8-cluster-on-google-cloud-platform
permalink: "/k8-cluster-on-google-cloud-platform/"
author: Varokas Panusuwan
tags: []
excerpt: |2

  เนื่องจากเป็นโปรแกรมเมอร์งบจำกัด เพิ่งมีคนใจดีให้เครดิตมาลองเล่น GCP ก็เลยสร้าง Kubernetes Cluster ซะเลย ง่ายสุดก็เข้าไปกดคลิ๊กๆ…
feature_image: https://images.unsplash.com/photo-1463567517034-628c51048aa2?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjExNzczfQ
canonical_url: https://medium.com/@varokas/%E0%B8%AA%E0%B8%A3%E0%B9%89%E0%B8%B2%E0%B8%87-kubernetes-cluster-%E0%B8%9A%E0%B8%99-google-cloud-platform-1b18168db66d
ghost_id: 5e929aca9c3d50000174a321
visibility: public
---

<p>เนื่องจากเป็นโปรแกรมเมอร์งบจำกัด เพิ่งมีคนใจดีให้เครดิตมาลองเล่น GCP ก็เลยสร้าง Kubernetes Cluster ซะเลย ง่ายสุดก็เข้าไปกดคลิ๊กๆ แต่วันนี้จะมาลองทำบน command line ดู</p><p>จริงๆ ก็ทำตามขั้นตอนที่ลิงก์แหละ แต่สรุปมาให้</p><p><a href="https://cloud.google.com/kubernetes-engine/docs/how-to/creating-a-cluster"><strong>Creating a Cluster | Kubernetes Engine | Google Cloud</strong></a><br><a href="https://cloud.google.com/kubernetes-engine/docs/how-to/creating-a-cluster"><em>Google Cloud delivers secure, open, intelligent, and transformative tools to help enterprises modernize for today's…</em>cloud.google.com</a></p><ol><li>ลง Command Line Tool ของ Google Cloud ชื่อว่า gcloud</li></ol><pre><code class="language-bash">brew cask install google-cloud-sdk</code></pre><p>2. login ใช้ gcloud มันจะเปิดหน้า browser ขึ้นมาให้เราใส่ user/pass เข้าไป</p><pre><code class="language-bash">gcloud auth login</code></pre><p>เลือก Project ที่เราจะใช้ ดูรายชื่อ project ที่เรามีได้ที่นี่ <a href="https://console.cloud.google.com/cloud-resource-manager">https://console.cloud.google.com/cloud-resource-manager</a></p><pre><code class="language-bash">gcloud config set project PROJECT_ID</code></pre><p>3. สร้าง cluster</p><ul><li>machine type เลือก<a href="https://cloud.google.com/compute/pricing#standard_machine_types">ตามนี้</a> (ยากจนก็ใช้ g1-small, $14 ต่อเดือน)</li><li>num_nodes ตามต้องการ แต่ default คือ 3</li></ul><p>เลือกได้ว่าจะสร้างไว้ที่ zone เดียวหรือทั้ง region เลย ดูชื่อได้ <a href="https://cloud.google.com/compute/docs/regions-zones/#available">ที่นี่</a></p><ul><li>zone ที่เราจะสร้าง REGION_NAME-ZONE_NAME</li><li>region ที่เราจะสร้าง แต่ถ้าใส่ num_nodes ไปเท่าไหร่มันจะ x3</li></ul><pre><code class="language-bash">gcloud container clusters create CLUSTER_NAME --machine-type=g1-small --num-nodes=1 --zone=us-west1-a</code></pre><p>สร้างอยู่นานเหมือนกัน (ประมาณสองสามนาที)</p><p>4. สร้าง config สำหรับ kubectl</p><p>จากนั้นเราก็สามารถสั่งให้มันไปสร้าง config ให้กับ</p><pre><code>&gt; brew install kubectl

&gt; gcloud container clusters get-credentials CLUSTER_NAME --zone=us-west1-a

Fetching cluster endpoint and auth data.
kubeconfig entry generated for k8s.</code></pre><p>5. kubectl</p><p>เสร็จหมดแล้ว ใช้ kubectl ได้เลย</p><pre><code class="language-bash">kubectl get pods --all-namespaces | awk '{ print $2,$3 }'

NAME READY
event-exporter-v0.2.3-54f94754f4-j5m8s 2/2
fluentd-gcp-scaler-6d7bbc67c5-lrnz7 1/1
fluentd-gcp-v3.1.0-kxttm 2/2
heapster-v1.5.3-7bd845b96c-r5f8n 3/3
kube-dns-788979dc8f-8tpxm 4/4
kube-dns-autoscaler-79b4b844b9-v7v5f 1/1
kube-proxy-gke-k8s-default-pool-0c3f25d3-cpmt 1/1
l7-default-backend-5d5b9874d5-qsnwk 1/1
metrics-server-v0.2.1-7486f5bd67-xkrbb 2/2</code></pre><p>สำหรับขา UI เข้าไปดูผ่าน UI ได้ที่นี่ <a href="https://console.cloud.google.com/kubernetes/list">https://console.cloud.google.com/kubernetes/list</a></p><figure class="kg-card kg-image-card"><img src="/assets/images/ghost/downloaded_images/------Kubernetes-Cluster----Google-Cloud-Platform/1-i9ZVwQOc02o6GDR2EmHHqQ.png" class="kg-image" alt loading="lazy"></figure>
