#!/usr/bin/env ruby
# frozen_string_literal: true

require "fileutils"
require "net/http"
require "set"
require "uri"

ROOT = File.expand_path("..", __dir__)
POSTS_DIR = File.join(ROOT, "_posts")
ASSETS_DIR = File.join(ROOT, "assets", "images", "ghost")
REPORT_PATH = File.join(ROOT, "scripts", "ghost_image_migration_report.txt")
SOURCE_HOST = "https://www.varokas.com"
GHOST_IMAGE_PATTERN = %r{(?:__GHOST_URL__|#{Regexp.escape(SOURCE_HOST)})(/content/images/[^"'\s<>)]+)}

def encoded_uri(url)
  URI.parse(URI::DEFAULT_PARSER.escape(url))
end

def get_response(uri, limit = 5)
  raise "too many redirects for #{uri}" if limit.zero?

  Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == "https", open_timeout: 10, read_timeout: 30) do |http|
    response = http.get(uri.request_uri)
    if response.is_a?(Net::HTTPRedirection)
      next_uri = URI.join(uri, response.fetch("location"))
      return get_response(next_uri, limit - 1)
    end

    response
  end
end

def download(source_url, destination_path)
  return :exists if File.exist?(destination_path) && File.size?(destination_path)

  FileUtils.mkdir_p(File.dirname(destination_path))
  response = get_response(encoded_uri(source_url))

  unless response.is_a?(Net::HTTPSuccess)
    return "HTTP #{response.code}"
  end

  File.binwrite(destination_path, response.body)
  :downloaded
rescue StandardError => error
  error.message
end

post_paths = Dir.glob(File.join(POSTS_DIR, "*.md")).sort
post_contents = post_paths.to_h { |path| [path, File.read(path)] }

ghost_paths = post_contents.values.flat_map do |content|
  content.scan(GHOST_IMAGE_PATTERN).flatten
end.to_set

download_results = {}
rewrite_map = {}

ghost_paths.sort.each do |ghost_path|
  source_url = "#{SOURCE_HOST}#{ghost_path}"
  relative_asset_path = ghost_path.sub(%r{\A/content/images/}, "")
  destination_path = File.join(ASSETS_DIR, relative_asset_path)
  local_url = "/assets/images/ghost/#{relative_asset_path}"
  result = download(source_url, destination_path)

  download_results[ghost_path] = {
    source_url: source_url,
    local_url: local_url,
    result: result
  }

  replacement = result == :downloaded || result == :exists ? local_url : source_url
  rewrite_map["__GHOST_URL__#{ghost_path}"] = replacement
  rewrite_map["#{SOURCE_HOST}#{ghost_path}"] = replacement
end

post_contents.each do |path, content|
  rewritten = content.gsub(GHOST_IMAGE_PATTERN) do
    rewrite_map.fetch($&)
  end
  rewritten = rewritten.gsub("__GHOST_URL__", "")
  File.write(path, rewritten) if rewritten != content
end

File.open(REPORT_PATH, "w") do |report|
  report.puts "Ghost image migration report"
  report.puts "Source host: #{SOURCE_HOST}"
  report.puts "Unique Ghost image references: #{ghost_paths.length}"
  report.puts

  download_results.sort.each do |ghost_path, info|
    report.puts "#{info[:result]}	#{ghost_path}	#{info[:local_url]}	#{info[:source_url]}"
  end
end

downloaded_count = download_results.values.count { |info| info[:result] == :downloaded }
existing_count = download_results.values.count { |info| info[:result] == :exists }
failed_count = download_results.length - downloaded_count - existing_count

puts "Ghost image references: #{ghost_paths.length}"
puts "Downloaded: #{downloaded_count}"
puts "Already present: #{existing_count}"
puts "Failed: #{failed_count}"
puts "Report: #{REPORT_PATH}"
