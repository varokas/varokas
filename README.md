# varokas.com Blog

This repository contains the static Jekyll site for the blog at `varokas.com`.

The site is being migrated from the Ghost export:

```text
minimal-engineering.ghost.2026-05-17-13-13-43.json
```

## Run Locally

Install Ruby and Bundler first. Ruby 3.x is recommended. The Gemfile also pins `ffi` to a Ruby 2.6-compatible version for older macOS system Ruby installs.

Install dependencies:

```sh
bundle install
```

Start the local Jekyll server:

```sh
bundle exec jekyll serve
```

Open the site at:

```text
http://localhost:4000
```

To include unpublished drafts during local development, run:

```sh
bundle exec jekyll serve --drafts
```

## Build

Generate the static site into `_site`:

```sh
bundle exec jekyll build
```

## Notes

- Published Ghost posts will be migrated into `_posts`.
- Ghost drafts are intentionally not migrated.
- The site preserves Ghost post URLs with `permalink: /:slug/`.
- Ghost-hosted assets should be downloaded from `https://www.varokas.com`.
- Unsplash image URLs are kept as external URLs.
