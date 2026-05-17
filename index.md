---
layout: default
title: Posts
---

<section class="archive">
  <h1>Posts</h1>

  <ul class="post-list">
    {% for post in site.posts %}
      <li>
        <a href="{{ post.url | relative_url }}">{{ post.title }}</a>
        <time datetime="{{ post.date | date_to_xmlschema }}">{{ post.date | date: "%Y-%m-%d" }}</time>
      </li>
    {% endfor %}
  </ul>
</section>
