require 'aruba/cucumber'

Aruba.configure do |config|
  config.fixtures_directories = %w(spec/assets)
#  puts %(The cwd is "#{config.working_directory}")
#  puts %(The fixtures_directories value is "%w(#{config.fixtures_directories.join(" ")})")
#  puts "The fixture path prefix is \"#{config.fixtures_path_prefix}\"."
end

Given("test fixtures are in {string}") do |path|
  @baseName = path
  %w(cityDetails_000.png cityDetails_007.png cityDetails_010.png citydetails.rb citydetails.xml).all? do
    |file|
    Dir[@baseName].include? file
  end
end

Given("the cwd is as follow:") do
  puts Dir.pwd
end

Given("the path to the samples directory") do
  @samplesPath = Pathname.new(Dir.pwd + '/samples')
end

Then("the output should contain the path to the samples directory") do
  expect(last_command_stopped).to have_output an_output_string_including(@samplesPath.to_s)
end
