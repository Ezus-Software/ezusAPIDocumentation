# Runs every documentation check. See DEFINITION_OF_DONE.md.
#   bundle exec ruby test/all.rb
require_relative "test_helper"

Dir.glob(File.join(__dir__, "*_test.rb")).sort.each { |file| require file }
