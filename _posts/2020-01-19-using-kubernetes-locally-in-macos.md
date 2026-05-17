---
layout: post
title: Using Kubernetes Locally in MacOS
date: '2020-01-19 02:35:54 +0000'
slug: using-kubernetes-locally-in-macos
permalink: "/using-kubernetes-locally-in-macos/"
author: Varokas Panusuwan
tags: []
feature_image: https://images.unsplash.com/photo-1470645792662-dd18394f8c97?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=2000&fit=max&ixid=eyJhcHBfaWQiOjExNzczfQ
ghost_id: 5e929aca9c3d50000174a346
visibility: public
---

<h3 id="install-docker">Install Docker</h3><pre><code class="language-bash">brew cask install docker</code></pre><h3 id="install-kubernetes-in-docker">Install Kubernetes in Docker</h3><ul><li>Go to menu bar, select the whale icon -&gt; preferences</li><li>Select Kubernetes tab, then "Enable Kubernetes"</li></ul><figure class="kg-card kg-image-card"><img src="/assets/images/ghost/2020/01/Screen-Shot-2020-01-18-at-5.46.34-PM-1.png" class="kg-image" alt loading="lazy"></figure><h3 id="check-that-docker-is-working">Check that docker is working</h3><pre><code class="language-bash">~ ❯❯❯ docker run hello-world

Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (amd64)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker ID:
 https://hub.docker.com/

For more examples and ideas, visit:
 https://docs.docker.com/get-started/</code></pre><h3 id="check-that-kubernetes-is-working">Check that Kubernetes is working</h3><pre><code class="language-bash">~ ❯❯❯ kubectl create deployment hello-node --image=gcr.io/hello-minikube-zero-install/hello-node

~ ❯❯❯ kubectl get pods
NAME                          READY   STATUS              RESTARTS   AGE
hello-node-78cd77d68f-8qm4b   0/1     ContainerCreating   0          19s</code></pre><p>It may take a while for containers to be created the first time. </p><pre><code class="language-bash">~ ❯❯❯ kubectl get pods
NAME                          READY   STATUS    RESTARTS   AGE
hello-node-78cd77d68f-8qm4b   1/1     Running   0          2m10s</code></pre><p>Expose the service </p><pre><code class="language-bash">❯❯❯ kubectl expose deployment hello-node --type=LoadBalancer --port=8080
service/hello-node exposed</code></pre><p>Check that the service is exposed</p><pre><code class="language-bash">~ ❯❯❯ kubectl get services
NAME         TYPE           CLUSTER-IP       EXTERNAL-IP   PORT(S)          AGE
hello-node   LoadBalancer   10.111.189.114   localhost     8080:31077/TCP   5m37s
kubernetes   ClusterIP      10.96.0.1        &lt;none&gt;        443/TCP          28m


~ ❯❯❯ curl localhost:8080
Hello World!%</code></pre><p>Delete the service</p><pre><code>~ ❯❯❯ kubectl delete deployment hello-node
deployment.extensions "hello-node" deleted

~ ❯❯❯ kubectl delete service hello-node
service "hello-node" deleted</code></pre><h3 id="using-yaml-in-kubernetes">Using YAML in Kubernetes</h3><p>Create a yaml file for deployment</p><pre><code class="language-yaml">apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
  labels:
    app: nginx
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.7.9
        ports:
        - containerPort: 80
---
apiVersion: v1
kind: Service
metadata:
  name: nginx
spec:
  type: LoadBalancer
  ports:
  - port: 8080
    targetPort: 80
    protocol: TCP
    name: http
  selector:
    app: nginx</code></pre><p>Run the two spec in the yaml</p><pre><code class="language-bash">❯❯❯ kubectl create -f nginx.yaml
deployment.apps/nginx-deployment created
service/nginx created</code></pre><p>Check that nginx is working</p><pre><code class="language-bash">❯❯❯ curl localhost:8080
&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;head&gt;
&lt;title&gt;Welcome to nginx!&lt;/title&gt;
&lt;style&gt;
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
    }
&lt;/style&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;h1&gt;Welcome to nginx!&lt;/h1&gt;
&lt;p&gt;If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.&lt;/p&gt;

&lt;p&gt;For online documentation and support please refer to
&lt;a href="http://nginx.org/"&gt;nginx.org&lt;/a&gt;.&lt;br/&gt;
Commercial support is available at
&lt;a href="http://nginx.com/"&gt;nginx.com&lt;/a&gt;.&lt;/p&gt;

&lt;p&gt;&lt;em&gt;Thank you for using nginx.&lt;/em&gt;&lt;/p&gt;
&lt;/body&gt;
&lt;/html&gt;</code></pre><p>Delete the deployment and service</p><pre><code class="language-bash">❯❯❯ kubectl delete -f nginx.yaml
deployment.apps "nginx-deployment" deleted
service "nginx" deleted</code></pre><h3 id="references">References</h3><ul><li>MiniKube Installation - <a href="https://kubernetes.io/docs/tutorials/hello-minikube/">https://kubernetes.io/docs/tutorials/hello-minikube/</a></li><li>Deployments - <a href="https://kubernetes.io/docs/concepts/workloads/controllers/deployment/">https://kubernetes.io/docs/concepts/workloads/controllers/deployment/</a></li><li>Kube Services - <a href="https://kubernetes.io/docs/concepts/services-networking/connect-applications-service/">https://kubernetes.io/docs/concepts/services-networking/connect-applications-service/</a></li></ul>
