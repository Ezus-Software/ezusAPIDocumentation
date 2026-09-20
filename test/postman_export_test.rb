require_relative "test_helper"
require "json"

# The Postman collection ships with the documentation: it has to stay valid
# JSON, and to carry exactly the documented routes.
class PostmanExportTest < Minitest::Test
  def test_the_export_is_valid_json
    JSON.parse(File.read(Docs::POSTMAN, encoding: "utf-8"))
  rescue JSON::ParserError => e
    flunk "source/ezus_api_postman.json is not valid JSON: #{e.message}"
  end

  def test_every_documented_route_has_a_request
    exported = Docs.postman_requests.map { |r| [r[:method], r[:name]] }.to_set

    missing = Docs.documented_routes
                  .reject { |r| exported.include?([r[:method], r[:route]]) }
                  .map { |r| "#{r[:method]} #{r[:route]} (#{r[:topic]})" }

    assert_empty missing, "documented but absent from the Postman export: #{missing.join(", ")}"
  end

  def test_every_request_matches_a_documented_route
    documented = Docs.documented_routes.map { |r| [r[:method], r[:route]] }.to_set

    extra = Docs.postman_requests
                .reject { |r| documented.include?([r[:method], r[:name]]) }
                .map { |r| "#{r[:method]} #{r[:name]}" }

    assert_empty extra, "in the Postman export but documented nowhere: #{extra.join(", ")}"
  end

  def test_every_request_url_targets_its_route
    mismatched = Docs.postman_requests.reject do |request|
      path = request[:raw_url].sub("{{baseUrl}}", "").split("?").first
      path == "/#{request[:name]}"
    end.map { |r| "#{r[:name]} -> #{r[:raw_url]}" }

    assert_empty mismatched, "requests whose URL does not match their name: #{mismatched.join(", ")}"
  end
end
