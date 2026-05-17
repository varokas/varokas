---
layout: post
title: Using ESLint with Visual Studio Code
date: '2017-06-15 00:00:00 +0000'
slug: using-eslint-with-visual-studio-code
permalink: "/using-eslint-with-visual-studio-code/"
author: Varokas Panusuwan
tags: []
excerpt: |2

  First, we need to install eslint as a node module. Also install the react plugin if we are using React.
canonical_url: https://medium.com/@varokas/using-eslint-with-visual-studio-code-2bd73baa35a9
ghost_id: 5e929aca9c3d50000174a32e
visibility: public
---

<p>First, we need to install eslint as a node module. Also install the react plugin if we are using React.</p><pre><code>yarn add eslint — dev
yarn add eslint-plugin-react — dev</code></pre><p>Then we can either initialize eslint using a script.</p><pre><code>./node_modules/.bin/eslint --init</code></pre><p>Or conveniently use this template (.eslintrc.json)</p><!--kg-card-begin: html--><script src="https://gist.github.com/varokas/a4b899ade5d93ec45ce6da452e776f09.js"></script><!--kg-card-end: html--><p>Then go to VSCode, Install ESLint extension and we are good to go.

</p>
