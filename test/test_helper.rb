require "minitest/autorun"
require "set"

# Helpers shared by the documentation checks. They read `source/` and the built
# `build/index.html`; nothing here calls the API or the network.
module Docs
  ROOT = File.expand_path("..", __dir__)
  INDEX = File.join(ROOT, "source", "index.html.md")
  INCLUDES = File.join(ROOT, "source", "includes")
  POSTMAN = File.join(ROOT, "source", "ezus_api_postman.json")
  BUILT_PAGE = File.join(ROOT, "build", "index.html")

  ROUTE_HEADING = /^## (GET|POST|PUT|DELETE|PATCH) (\S+)\s*$/

  module_function

  # The topic names listed under `includes:` in index.html.md, in their order.
  def included_topics
    front_matter = File.read(INDEX, encoding: "utf-8")[/^includes:\n(.*?)^\S/m, 1].to_s
    front_matter.scan(/^\s*-\s*(\S+)\s*$/).flatten
  end

  # Every documented route, in the order a reader meets it: the order of
  # `includes:`, then the order of the `## VERB route` headings inside each file.
  def documented_routes
    included_topics.flat_map do |topic|
      path = File.join(INCLUDES, "_#{topic}.md")
      next [] unless File.exist?(path)

      File.read(path, encoding: "utf-8").scan(ROUTE_HEADING).map do |method, route|
        { method: method, route: route, topic: topic }
      end
    end
  end

  # Every request of the Postman collection, in its order, folders flattened.
  def postman_requests(items = postman_collection["item"])
    items.flat_map do |item|
      found = []
      if item["request"]
        found << {
          name: item["name"],
          method: item["request"]["method"],
          raw_url: item["request"].dig("url", "raw").to_s
        }
      end
      found + (item["item"] ? postman_requests(item["item"]) : [])
    end
  end

  def postman_collection
    @postman_collection ||= JSON.parse(File.read(POSTMAN, encoding: "utf-8"))
  end
end
