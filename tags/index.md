---
layout: default
title: Tags
permalink: /tags/
---

<section class="archive">
  <h2 class="section-label">Tags</h2>

  <ul class="tag-cloud">
    {% assign sorted_tags = site.tags | sort %}
    {% for tag in sorted_tags %}
      <li>
        <a class="tag" href="{{ '/tags/' | append: tag[0] | append: '/' | relative_url }}">{{ tag[0] }}<em>{{ tag[1].size }}</em></a>
      </li>
    {% endfor %}
  </ul>
</section>
