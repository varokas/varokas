---
layout: post
title: Using Tensorflow and Keras on M1 Macs
date: '2021-10-30 05:03:28 +0000'
slug: tensorflow-on-apple-silicon
permalink: "/tensorflow-on-apple-silicon/"
author: Varokas Panusuwan
tags: []
feature_image: https://images.unsplash.com/photo-1458432449677-469b01f8ed08?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxMTc3M3wwfDF8c2VhcmNofDExfHxtZXRhbCUyMGZsb3d8ZW58MHx8fHwxNjM1NTY5MjQy&ixlib=rb-1.2.1&q=80&w=2000
ghost_id: 617ccdfb3fe0480001198336
visibility: public
---

<p></p><p>Following the instruction here <a href="https://developer.apple.com/metal/tensorflow-plugin/">Tensorflow Plugin - Metal - Apple Developer</a></p><h3 id="python-miniforge-">Python (Miniforge)</h3><p>First, we need to install miniforge. Easiest way to do that is to use <a href="https://github.com/pyenv/pyenv">pyenv</a>. The tool allow us to install multiple version of pythons. More importantly, we can specify a version of python needed for each folder. Much more convinient than keep switching global versions</p><pre><code class="language-bash">pyenv install miniforge3

mkdir demo-tensorflow-metal
pyenv local miniforge3</code></pre><h3 id="install-tensorflow-and-it-dependencies">Install Tensorflow and it dependencies</h3><pre><code class="language-bash">conda install -c apple tensorflow-deps

python -m pip install tensorflow-macos
python -m pip install tensorflow-metal</code></pre><h3 id="install-and-run-jupyter">Install and Run Jupyter</h3><pre><code class="language-bash">conda install jupyterlab

jupyter lab</code></pre><h3 id="try-mnist-demo">Try MNIST demo</h3><p>Simply follow along with <a href="https://keras.io/examples/vision/mnist_convnet/">Keras MNIST Demo</a></p><p>If everything is set up correctly, we should see that Metal Device is set to M1</p><figure class="kg-card kg-image-card"><img src="/assets/images/ghost/2021/10/Screen-Shot-2021-10-29-at-9.55.56-PM.png" class="kg-image" alt loading="lazy" width="1186" height="318" srcset="/assets/images/ghost/size/w600/2021/10/Screen-Shot-2021-10-29-at-9.55.56-PM.png 600w, /assets/images/ghost/size/w1000/2021/10/Screen-Shot-2021-10-29-at-9.55.56-PM.png 1000w, /assets/images/ghost/2021/10/Screen-Shot-2021-10-29-at-9.55.56-PM.png 1186w" sizes="(min-width: 720px) 720px"></figure><p>Quite impressive performance from a fanless Macbook Air !</p><figure class="kg-card kg-image-card"><img src="/assets/images/ghost/2021/10/Screen-Shot-2021-10-29-at-9.56.23-PM.png" class="kg-image" alt loading="lazy" width="2000" height="1162" srcset="/assets/images/ghost/size/w600/2021/10/Screen-Shot-2021-10-29-at-9.56.23-PM.png 600w, /assets/images/ghost/size/w1000/2021/10/Screen-Shot-2021-10-29-at-9.56.23-PM.png 1000w, /assets/images/ghost/size/w1600/2021/10/Screen-Shot-2021-10-29-at-9.56.23-PM.png 1600w, /assets/images/ghost/size/w2400/2021/10/Screen-Shot-2021-10-29-at-9.56.23-PM.png 2400w" sizes="(min-width: 720px) 720px"></figure><figure class="kg-card kg-bookmark-card"><a class="kg-bookmark-container" href="https://github.com/varokas/demo-tensorflow-metal/blob/main/mnist.ipynb"><div class="kg-bookmark-content"><div class="kg-bookmark-title">demo-tensorflow-metal/mnist.ipynb at main · varokas/demo-tensorflow-metal</div><div class="kg-bookmark-description">Contribute to varokas/demo-tensorflow-metal development by creating an account on GitHub.</div><div class="kg-bookmark-metadata"><img class="kg-bookmark-icon" src="https://github.githubassets.com/favicons/favicon.svg" alt=""><span class="kg-bookmark-author">GitHub</span><span class="kg-bookmark-publisher">varokas</span></div></div><div class="kg-bookmark-thumbnail"><img src="https://opengraph.githubassets.com/f45aceb1790981163dd54ca23ead4ac8b64735313f5c2ef12dad2d7437592778/varokas/demo-tensorflow-metal" alt=""></div></a></figure><h3 id="references">References</h3><ul><li><a href="https://developer.apple.com/metal/tensorflow-plugin/">Tensorflow Plugin - Metal - Apple Developer</a></li><li><a href="https://keras.io/examples/vision/mnist_convnet/">Simple MNIST convnet</a></li></ul>
