---
layout: default
title: Tags
permalink: /tags/
---

<section class="archive">
  <h1>Tags</h1>

  <ul class="tag-list">
    {% assign sorted_tags = site.tags | sort %}
    {% for tag in sorted_tags %}
      <li>
        <a href="{{ '/tags/' | append: tag[0] | append: '/' | relative_url }}">{{ tag[0] }}</a>
        <span>{{ tag[1].size }}</span>
      </li>
    {% endfor %}
  </ul>
</section>
