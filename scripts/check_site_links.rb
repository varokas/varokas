#!/usr/bin/env ruby
# frozen_string_literal: true

require "cgi"
require "pathname"
require "set"
require "uri"

ROOT = File.expand_path("..", __dir__)
SITE_DIR = File.join(ROOT, "_site")
ATTR_PATTERN = /\b(?:href|src)=["']([^"']+)["']/
SRCSET_PATTERN = /\bsrcset=["']([^"']+)["']/
PLACEHOLDER_PATTERN = /__GHOST_URL__|\/content\/images\//

def ignored_url?(url)
  url.empty? ||
    url.start_with?("#", "mailto:", "tel:", "javascript:", "data:") ||
    url.match?(%r{\Ahttps?://})
end

def strip_url(url)
  url.split("#", 2).first.split("?", 2).first
end

def target_path(source_file, url)
  clean_url = CGI.unescape(strip_url(url))
  return nil if clean_url.empty?

  if clean_url.start_with?("/")
    File.join(SITE_DIR, clean_url)
  else
    File.expand_path(clean_url, File.dirname(source_file))
  end
end

def existing_target?(path)
  return true if File.file?(path)
  return true if File.directory?(path) && File.file?(File.join(path, "index.html"))

  File.file?("#{path}.html")
end

missing = []
placeholder_files = []

Dir.glob(File.join(SITE_DIR, "**", "*.html")).sort.each do |file|
  content = File.read(file)
  placeholder_files << file if content.match?(PLACEHOLDER_PATTERN)

  urls = content.scan(ATTR_PATTERN).flatten
  content.scan(SRCSET_PATTERN).flatten.each do |srcset|
    urls.concat(srcset.split(",").map { |entry| entry.strip.split(/\s+/).first })
  end

  urls.uniq.each do |url|
    next if ignored_url?(url)

    path = target_path(file, url)
    missing << [file, url] if path && !existing_target?(path)
  end
end

unless placeholder_files.empty?
  puts "Found unresolved placeholders:"
  placeholder_files.each { |file| puts "  #{file.sub("#{ROOT}/", "")}" }
end

unless missing.empty?
  puts "Found missing internal links or assets:"
  missing.each do |file, url|
    puts "  #{file.sub("#{ROOT}/", "")}\t#{url}"
  end
end

if placeholder_files.empty? && missing.empty?
  puts "site link check ok"
  exit 0
end

exit 1
