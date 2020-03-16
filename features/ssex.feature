Feature: Create source file using ssex
  In order to have a usable set of sprites in my game code
  As a DragonRuby game developer
  I want to generate a ready-to-use Ruby source declaration

  Scenario: Create a DragonRuby class declaration from a Kenney atlas file
    Given test fixtures are in 'city'
    When I copy a directory from "%/city" to "city"
    When I run `ssex "city/citydetails"`
    Then a file named "city/citydetails.rb" should exist
    Then the file "city/citydetails.rb" should match /cityDetails_000.=>{:path=>"city.cityDetails_000.png", :x=>125, :y=>64, :w=>22, :h=>37}/
