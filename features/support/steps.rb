require 'aruba/cucumber'

Aruba.configure do |config|
  config.fixtures_directories = %w(spec/assets)
  puts %(The cwd is "#{config.working_directory}")
  puts %(The fixtures_directories value is "%w(#{config.fixtures_directories.join(" ")})")
  puts "The fixture path prefix is \"#{config.fixtures_path_prefix}\"."
end

Given("test fixtures are in {string}") do |path|
  @baseName = path
  %w(cityDetails_000.png cityDetails_007.png cityDetails_010.png citydetails.rb citydetails.xml).all? do
    |file|
    Dir[@baseName].include? file
  end
end

# When("I run `ssex {string}`") do |path|
#   `./bin/ssex #{path}`
# end

Then("a perfect Ruby file appears next to the atlas file") do
  gen = File.read(@baseName)
  gen.index 
end
