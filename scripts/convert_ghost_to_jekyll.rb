#!/usr/bin/env ruby
# frozen_string_literal: true

require "date"
require "fileutils"
require "json"
require "yaml"

ROOT = File.expand_path("..", __dir__)
EXPORT_PATH = File.join(ROOT, "minimal-engineering.ghost.2026-05-17-13-13-43.json")
POSTS_DIR = File.join(ROOT, "_posts")

def indexed_by_id(records)
  records.each_with_object({}) do |record, index|
    index[record["id"]] = record
  end
end

def grouped_relation(records, key)
  records.each_with_object(Hash.new { |hash, relation_key| hash[relation_key] = [] }) do |record, groups|
    groups[record[key]] << record
  end
end

def yaml_front_matter(data)
  yaml = data.compact.to_yaml
  yaml = yaml.sub(/\A---\n/, "")
  yaml = yaml.sub(/\n\.\.\.\n?\z/, "\n")
  "---\n#{yaml}---\n"
end

def post_date(post)
  DateTime.iso8601(post.fetch("published_at"))
end

def post_filename(post)
  date = post_date(post).strftime("%Y-%m-%d")
  "#{date}-#{post.fetch("slug")}.md"
end

def sorted_relations(relations)
  relations.sort_by { |relation| relation["sort_order"] || 0 }
end

def presence(value)
  value.to_s.empty? ? nil : value
end

raw_export = JSON.parse(File.read(EXPORT_PATH))
data = raw_export.fetch("db").first.fetch("data")

tags_by_id = indexed_by_id(data.fetch("tags", []))
users_by_id = indexed_by_id(data.fetch("users", []))
tags_by_post_id = grouped_relation(data.fetch("posts_tags", []), "post_id")
authors_by_post_id = grouped_relation(data.fetch("posts_authors", []), "post_id")

published_posts = data.fetch("posts", []).select { |post| post["status"] == "published" }

FileUtils.mkdir_p(POSTS_DIR)

generated_files = []

published_posts.each do |post|
  date = post_date(post)
  author_relation = sorted_relations(authors_by_post_id[post["id"]]).first
  author = users_by_id.dig(author_relation && author_relation["author_id"], "name")

  tag_slugs = sorted_relations(tags_by_post_id[post["id"]]).map do |relation|
    tags_by_id.dig(relation["tag_id"], "slug")
  end.compact

  front_matter = {
    "layout" => "post",
    "title" => post["title"],
    "date" => date.strftime("%Y-%m-%d %H:%M:%S %z"),
    "slug" => post["slug"],
    "permalink" => "/#{post["slug"]}/",
    "author" => author,
    "tags" => tag_slugs,
    "excerpt" => post["custom_excerpt"],
    "feature_image" => post["feature_image"],
    "canonical_url" => post["canonical_url"],
    "ghost_id" => post["id"],
    "visibility" => post["visibility"],
    "codeinjection_head" => presence(post["codeinjection_head"]),
    "codeinjection_foot" => presence(post["codeinjection_foot"])
  }

  body = post["html"].to_s.strip
  content = "#{yaml_front_matter(front_matter)}\n#{body}\n"
  path = File.join(POSTS_DIR, post_filename(post))

  File.write(path, content)
  generated_files << path
end

puts "Generated #{generated_files.length} published posts in #{POSTS_DIR}"
