require_relative "test_helper"

# A new topic file is only rendered once its name is listed under `includes:` in
# index.html.md. The two lists have to match.
class IncludesTest < Minitest::Test
  def test_every_listed_topic_has_a_file
    missing = Docs.included_topics
                  .reject { |topic| File.exist?(File.join(Docs::INCLUDES, "_#{topic}.md")) }

    assert_empty missing, "listed under `includes:` but with no file: #{missing.join(", ")}"
  end

  def test_every_file_is_listed_under_includes
    on_disk = Dir.glob(File.join(Docs::INCLUDES, "_*.md"))
                 .map { |path| File.basename(path, ".md").delete_prefix("_") }

    unlisted = on_disk - Docs.included_topics

    assert_empty unlisted, "topic files missing from `includes:` in index.html.md: #{unlisted.join(", ")}"
  end
end
