---
layout: default
---

<section class="home">
  <section class="home-latest">
    <h2 class="section-label">Latest</h2>
    {% for post in site.posts limit: 4 %}
      <article class="post-card">
        <h3 class="post-card-title"><a href="{{ post.url | relative_url }}">{{ post.title }}</a></h3>
        <p class="post-card-excerpt">{{ post.excerpt | strip_html | normalize_whitespace | truncatewords: 28 }}</p>
        <p class="meta">
          <time datetime="{{ post.date | date_to_xmlschema }}">{{ post.date | date: "%Y-%m-%d" }}</time>{% if post.tags and post.tags.size > 0 %} &middot; {% for tag in post.tags %}<a href="{{ '/tags/' | append: tag | append: '/' | relative_url }}">{{ tag }}</a>{% unless forloop.last %}, {% endunless %}{% endfor %}{% endif %}
        </p>
      </article>
    {% endfor %}
  </section>

  <section class="home-archive">
    <h2 class="section-label">Archive</h2>
    {% assign prev_year = "" %}
    {% for post in site.posts offset: 4 %}
      {% assign year = post.date | date: "%Y" %}
      {% if year != prev_year %}
        <h3 class="archive-year">{{ year }}</h3>
        {% assign prev_year = year %}
      {% endif %}
      <p class="archive-row">
        <a href="{{ post.url | relative_url }}">{{ post.title }}</a>
        <time datetime="{{ post.date | date_to_xmlschema }}">{{ post.date | date: "%b %-d" }}</time>
      </p>
    {% endfor %}
  </section>
</section>
