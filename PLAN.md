# Ghost to Jekyll Migration Plan

Source export: `minimal-engineering.ghost.2026-05-17-13-13-43.json`

Export summary:

- Ghost version: `5.105.0`
- Site title: `Minimal Engineering`
- Posts: `61`
- Published posts: `48`
- Draft posts: `13`
- Pages: `0`
- Tags: `5`
- Users/authors: `2`
- Posts with feature images: `33`
- Posts with image references in HTML: `52`

## 1. Decide Migration Scope

- [x] Migrate only published posts; do not include drafts.
- [x] Set target URL/domain for `_config.yml` to `https://www.varokas.com`.
- [x] Preserve Ghost URLs exactly with Jekyll permalinks.
- [x] Leave Unsplash images as external URLs.
- [x] Download Ghost-hosted assets from `https://www.varokas.com`.
- [x] Exclude Ghost membership/newsletter/product data from the static site.

Confirmed scope:

- Publish the 48 published posts into `_posts`.
- Do not migrate the 13 drafts.
- Preserve post slugs with `permalink: /:slug/`.
- Download and localize `__GHOST_URL__/content/images/...` assets from `https://www.varokas.com/content/images/...`.
- Keep remote Unsplash image URLs unchanged.
- Ignore Ghost-only membership, offers, newsletters, products, and Stripe tables.

## 2. Create Jekyll Project Structure

- [x] Add a `Gemfile` with `jekyll`, `webrick`, and needed plugins.
- [x] Add `_config.yml` with site metadata, permalink settings, Markdown engine, and collections.
- [x] Create directories:
  - `_posts`
  - `_layouts`
  - `_includes`
  - `assets/css`
  - `assets/images`
  - `scripts`
- [x] Add a minimal default layout, post layout, index page, tag pages, and feed support.
- [x] Add `.gitignore` entries for `_site`, `.jekyll-cache`, `.sass-cache`, and `vendor`.

## 3. Write the Ghost Conversion Script

- [x] Create `scripts/convert_ghost_to_jekyll.rb` or `scripts/convert_ghost_to_jekyll.py`.
- [x] Parse `db[0].data.posts`, `tags`, `users`, `posts_tags`, and `posts_authors`.
- [x] Convert each published Ghost post into `_posts/YYYY-MM-DD-slug.md`.
- [x] Skip draft posts.
- [x] Emit YAML front matter:
  - `layout`
  - `title`
  - `date`
  - `slug`
  - `permalink`
  - `author`
  - `tags`
  - `excerpt`
  - `feature_image`
  - `canonical_url`
  - `ghost_id`
  - `visibility`
  - `codeinjection_head`
  - `codeinjection_foot`
- [x] Preserve the Ghost HTML body initially instead of attempting risky HTML-to-Markdown conversion.
- [x] Escape YAML safely for Thai titles, punctuation-heavy slugs, quotes, and multiline excerpts.
- [x] Preserve `codeinjection_head` and `codeinjection_foot` only if needed by specific posts.

## 4. Migrate Images and Links

- [x] Replace `__GHOST_URL__/content/images/...` references with local Jekyll asset paths.
- [x] Download Ghost content images from `https://www.varokas.com/content/images/...`.
- [x] Leave Unsplash feature images and inline images as external URLs.
- [x] Store images under `assets/images/YYYY/MM/...` or `assets/images/ghost/...`.
- [x] Update post HTML image `src`, `srcset`, and feature image front matter.
- [x] Preserve `alt` text and captions from Ghost HTML where present.
- [x] Generate a report of any missing, unreachable, or still-external images.

## 5. Preserve Taxonomy and Navigation

- [x] Map Ghost tags from `posts_tags` to Jekyll front matter tags.
- [x] Create tag archive pages for:
  - `getting-started`
  - `blog`
  - `ghost-tag`
  - `klipse`
  - `javascript`
- [x] Create an author archive only if both authors have published posts.
- [x] Build the homepage as a reverse-chronological post index.
- [x] Add RSS feed and sitemap support.

## 6. Handle Ghost-Specific Features

- [x] Review posts that include `lexical`, `mobiledoc`, or special embedded HTML.
- [x] Check for Ghost cards, embeds, galleries, bookmarks, or signup forms in the HTML.
- [x] Replace unsupported Ghost widgets with static HTML equivalents.
- [x] Remove membership/newsletter callouts because membership features are out of scope.
- [x] Keep canonical URLs if they point to useful historical locations.

## 7. Verify Content Quality

- [x] Run the conversion script and inspect a sample of older and newer posts.
- [x] Check Thai titles and body text render correctly.
- [x] Check code blocks, tables, embeds, and inline images.
- [x] Confirm every published post has the expected URL.
- [x] Confirm drafts are not generated or included in the production build.
- [x] Run a link checker against the generated `_site`.
- [x] Search generated files for unresolved placeholders:
  - `__GHOST_URL__`
  - `ghost.org`
  - broken `/content/images/` paths

## 8. Build and Local Preview

- [x] Run `bundle install`.
- [x] Run `bundle exec jekyll build`.
- [x] Run `bundle exec jekyll serve`.
- [x] Open the local site and verify:
  - Homepage
  - Individual posts
  - Tag pages
  - RSS feed
  - Sitemap
  - Mobile layout
- [x] Fix Liquid, YAML, or HTML build warnings before deployment.

## 9. Deployment Preparation

- [x] Choose hosting target: GitHub Pages, Cloudflare Pages, Netlify, or another static host.
- [x] Add host-specific config if needed.
- [x] Add CI build workflow if deploying from Git.
- [x] Configure custom domain and HTTPS.
- [x] Add redirects from old Ghost paths if the URL shape changes.
- [ ] Submit sitemap after deployment.

## 10. Acceptance Criteria

- [x] All 48 published Ghost posts build as Jekyll posts.
- [x] Ghost drafts are not migrated.
- [x] No generated page contains `__GHOST_URL__`.
- [x] Existing slugs remain stable.
- [x] Tags and authors are preserved where present.
- [x] Images either render locally or are explicitly documented as external/missing.
- [x] `bundle exec jekyll build` exits successfully.
- [x] The generated site can be browsed locally without obvious layout or encoding issues.
