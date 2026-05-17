---
layout: post
title: GPU-accelerated Machine Learning on MacOS with Keras and PlaidML
date: '2019-06-19 04:46:14 +0000'
slug: keras-with-gpu-on-plaidml
permalink: "/keras-with-gpu-on-plaidml/"
author: Varokas Panusuwan
tags: []
feature_image: https://images.unsplash.com/photo-1555680206-9bc5064689db?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjExNzczfQ
ghost_id: 5e929aca9c3d50000174a344
visibility: public
---

<p>There aren't a lot of GPU-accelerated Machine Learning Framework in MacOS besides <a href="https://developer.apple.com/documentation/createml">CreateML</a> or <a href="https://github.com/apple/turicreate">TuriCreate</a>. Luckily, we could use PlaidML as a backend for <a href="https://keras.io">Keras</a> as it implements Metal Performance Shaader.</p><h3 id="install-keras">Install Keras</h3><p>Easiest way is installing Anaconda and install Keras in an environment</p><pre><code class="language-bash">$ brew install anaconda</code></pre><p>Creating an isolated environment for each of our project is also a good idea</p><pre><code class="language-bash">$ conda create -n keras
$ conda activate keras</code></pre><h3 id="install-plaid-ml">Install Plaid ML</h3><p>Installing and Configuring PlaidML is <a href="https://github.com/plaidml/plaidml">surprisingly easy</a>.</p><pre><code class="language-bash">$ pip install plaidml-keras

$ plaidml-setup</code></pre><figure class="kg-card kg-image-card"><img src="/assets/images/ghost/2019/06/carbon-5.png" class="kg-image" alt loading="lazy"></figure><p><code>plaidml-setup</code> automatically detects viable options in the system. Simply select the strongest GPU we have with <code>metal</code> in the name. The settings will be persisted as <code>.plaidml</code> in the home directory.</p><h3 id="integrating-with-keras">Integrating with Keras</h3><p>Simply set <code>KERAS_BACKEND</code> environment variable. Easiest way is to include this line in the same Python script </p><pre><code class="language-python">import os

os.environ["KERAS_BACKEND"] = "plaidml.keras.backend"</code></pre><p>Let's try with <a href="https://github.com/keras-team/keras/blob/master/examples/mnist_mlp.py">MNIST example</a> from Keras. Look for two messages confirming the backend used.</p><figure class="kg-card kg-image-card kg-card-hascaption"><img src="/assets/images/ghost/2019/06/Screen-Shot-2019-06-18-at-9.38.07-PM.png" class="kg-image" alt loading="lazy"><figcaption>Confirmed that Keras is using the specifed backend</figcaption></figure><figure class="kg-card kg-image-card kg-card-hascaption"><img src="/assets/images/ghost/2019/06/Screen-Shot-2019-06-18-at-9.39.56-PM.png" class="kg-image" alt loading="lazy"><figcaption>And again when creating model</figcaption></figure><p>Let the training begin!</p><figure class="kg-card kg-image-card"><img src="/assets/images/ghost/2019/06/Screen-Shot-2019-06-18-at-9.42.53-PM.png" class="kg-image" alt loading="lazy"></figure>
