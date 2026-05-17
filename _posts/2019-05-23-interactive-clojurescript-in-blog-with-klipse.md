---
layout: post
title: Interactive ClojureScript in a blog with Klipse
date: '2019-05-23 05:09:54 +0000'
slug: interactive-clojurescript-in-blog-with-klipse
permalink: "/interactive-clojurescript-in-blog-with-klipse/"
author: Varokas Panusuwan
tags: []
feature_image: https://images.unsplash.com/photo-1488590528505-98d2b5aba04b?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjExNzczfQ
ghost_id: 5e929aca9c3d50000174a33f
visibility: public
codeinjection_head: |-
  <link rel="stylesheet" type="text/css" href="https://storage.googleapis.com/app.klipse.tech/css/codemirror.css">
  <style>
    pre.language-klipse {
      border: 0;
      background: #eef;
    }
  </style>
codeinjection_foot: |-
  <script>
      window.klipse_settings = {
          selector: '.language-klipse'// css selector for the html elements you want to klipsify
      };
  </script>
  <script src="https://storage.googleapis.com/app.klipse.tech/plugin/js/klipse_plugin.js"></script>
---

<p>I've always been looking  for ways to put interactive code in a blog. For Javascript, there's CodePen. For ClojureScript, there's <a href="https://github.com/viebel/klipse">KLIPSE</a></p><p>First, try fiddling with the ClojureScript expression below and be in awe at the marvel of modern technology!</p><pre><code class="language-klipse">(map #(* % 2) [1 2 3]) ;Try adding one more element between brackets.</code></pre><h3 id="preparing">Preparing</h3><p>Add the following script using code injection to the header. Click the Gear button on the top-right and select "Code Injection".</p><p>In <strong>Post Header</strong>, add the following CSS.</p><pre><code class="language-html">&lt;link rel="stylesheet" 
      type="text/css" 
      href="https://storage.googleapis.com/app.klipse.tech/css/codemirror.css"&gt;
&lt;style&gt;
  /* Override the theme's border and style it close to original klipse  */
  pre.language-klipse {
    border: 0;
    background: #eef;
  }
&lt;/style&gt;</code></pre><p>And <strong>Post Footer</strong>, the script</p><pre><code class="language-html">&lt;script&gt;
    window.klipse_settings = {
        // css selector the elements to klipsify
        selector: '.language-klipse'
    };
&lt;/script&gt;
&lt;script src="https://storage.googleapis.com/app.klipse.tech/plugin/js/klipse_plugin.js"&gt;
&lt;/script&gt;</code></pre><h3 id="usage">Usage</h3><p>Create a code card by typing <code>```klipse</code> then enter. Put in the code to show in the box. This merely creates the following &lt;html&gt; that the selector binds to</p><pre><code class="language-html">&lt;!-- Ghost created these tags in the final page, dont type this in. --&gt;
&lt;pre class="language-klipse"&gt;
  &lt;code class="language-klipse"&gt;
    .. (your code here)
  &lt;/code&gt;
&lt;/pre&gt;</code></pre><h3 id="note">Note</h3><ul><li>The script is not minified. Per instruction in GitHub</li></ul><blockquote>Pay attention: for clojure interactive snippets, you must use the <strong>non-minified</strong> version of klipse as for the moment, self-host cljs doesn't support advanced compilation!</blockquote><ul><li>If you are tired of injecting code in every post, you can put it in site's code injection. This works in a similar way to setup a code for <a href="https://docs.ghost.org/integrations/google/">Google Analytics</a>. Just be aware that the script is quite large (~1MB).</li><li>The original <a href="http://blog.klipse.tech/clojure/2016/03/17/klipse.html">launch blog</a> is very inspiring, but the instruction is quite outdated. Follow instructions in github.</li><li>The author also writes a <a href="http://blog.klipse.tech/">blog</a> about Clojure and is currently writing a book. </li></ul><p></p><p></p>
