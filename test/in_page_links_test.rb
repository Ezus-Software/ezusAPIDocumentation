require_relative "test_helper"
require "nokogiri"

# Anchors are generated from the headings at build time, so only the built page
# can tell whether an in-page link resolves. Run `bundle exec rake build` first.
class InPageLinksTest < Minitest::Test
  def setup
    unless File.exist?(Docs::BUILT_PAGE)
      flunk "build/index.html is missing — run `bundle exec rake build` first"
    end

    @page = Nokogiri::HTML(File.read(Docs::BUILT_PAGE, encoding: "utf-8"))
  end

  def test_every_in_page_link_resolves_to_a_heading
    ids = @page.css("[id]").map { |node| node["id"] }.to_set

    broken = @page.css("a[href^='#']").map { |a| a["href"].delete_prefix("#") }
                  .reject(&:empty?).uniq.sort
                  .reject { |anchor| ids.include?(anchor) }

    assert_empty broken, "in-page links pointing at no heading: #{broken.join(", ")}"
  end

  def test_no_two_headings_share_an_anchor
    ids = @page.css("h1[id], h2[id], h3[id]").map { |node| node["id"] }
    duplicates = ids.tally.select { |_, count| count > 1 }.keys.sort

    assert_empty duplicates, "several headings generate the same anchor: #{duplicates.join(", ")}"
  end
end
