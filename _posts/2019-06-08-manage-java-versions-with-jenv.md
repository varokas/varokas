---
layout: post
title: Manage Java Versions with JEnv
date: '2019-06-08 04:45:20 +0000'
slug: manage-java-versions-with-jenv
permalink: "/manage-java-versions-with-jenv/"
author: Varokas Panusuwan
tags: []
feature_image: https://images.unsplash.com/photo-1473923377535-0002805f57e8?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjExNzczfQ
ghost_id: 5e929aca9c3d50000174a343
visibility: public
---

<p>Experimenting with different versions of Java made easier by a handy tool.</p><h3 id="install">Install</h3><p>First, install JEnv itself.</p><pre><code class="language-bash">brew install jenv
</code></pre><p>JEnv simply assist in managing Java versions. We have to install various Java versions by ourselves.</p><pre><code class="language-bash">brew tap homebrew/cask-versions
brew cask install java11</code></pre><p>Put these two lines in <code>~/.bash_profile</code> or <code>~/.zshrc</code></p><pre><code class="language-bash">export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"</code></pre><p>After that, just restart the shell for these changes to be picked up </p><h3 id="add-java-versions">Add Java versions</h3><p>Find existing Java path, then use <code>jenv add &lt;path&gt;</code>. Where <code>&lt;path&gt;</code> is <code>/Library/Java/JavaVirtualMachines/&lt;version&gt;/Contents/Home</code>. The correct version should be recognized by the tool</p><pre><code class="language-bash">$ ls -l /Library/Java/JavaVirtualMachines

total 0
drwxr-xr-x  3 varokas  staff  96 Aug  9  2018 jdk1.8.0_181.jdk
drwxr-xr-x@ 3 varokas  staff  96 Jan 18 00:22 openjdk-11.0.2.jdk

$ jenv add /Library/Java/JavaVirtualMachines/jdk1.8.0_181.jdk/Contents/Home
oracle64-1.8.0.181 added
1.8.0.181 added
1.8 added

$ jenv add /Library/Java/JavaVirtualMachines/openjdk-11.0.2.jdk/Contents/Home
openjdk64-11.0.2 added
11.0.2 added
11.0 added</code></pre><p>We can then inspect all recognized version.</p><pre><code class="language-bash">$ jenv versions
* system (set by /Users/varokas/.jenv/version)
  1.8
  1.8.0.181
  11.0
  11.0.2
  openjdk64-11.0.2</code></pre><p>Then we can switch between Java versions like so.</p><pre><code class="language-bash">$ jenv global 11.0
$ java -version
openjdk version "11.0.2" 2019-01-15
OpenJDK Runtime Environment 18.9 (build 11.0.2+9)
OpenJDK 64-Bit Server VM 18.9 (build 11.0.2+9, mixed mode)

$ jenv global 1.8
$ java -version
java version "1.8.0_181"
Java(TM) SE Runtime Environment (build 1.8.0_181-b13)
Java HotSpot(TM) 64-Bit Server VM (build 25.181-b13, mixed mode)</code></pre><h3 id="java_home">JAVA_HOME</h3><p>The environments variable usually are not as important as long as <code>javac</code> can be executed from shell. Regardless, we could set it like so.</p><pre><code class="language-bash">jenv enable-plugin export
echo $JAVA_HOME</code></pre><h3 id="references">References</h3><ul><li><a href="http://www.jenv.be">jEnv - Manage your Java environment</a></li></ul>
