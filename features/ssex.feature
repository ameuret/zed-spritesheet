Feature: Create source file using ssex
  In order to have a usable set of sprites in my game code
  As a DragonRuby game developer
  I want to generate a ready-to-use Ruby source declaration

  Scenario: Create a DragonRuby sprites module from a Kenney (XML) atlas file
    Given test fixtures are in 'city'
    When I copy a directory from "%/city" to "city"
    When I run `ssex "city/citydetails"`
    Then a file named "city/citydetails.rb" should exist
    Then the file "city/citydetails.rb" should match /cityDetails_000.=>{:path=>"city.cityDetails_000.png", :x=>125, :y=>64, :w=>22, :h=>37}/

  Scenario: Create a DragonRuby sprites module from a single image file
    Given test fixtures are in 'sinestesia'
    When I copy a file from "%/sinestesia/explosion1.png" to "explosion1.png"
    When I run `ssex --width 256 --height 256 explosion1.png`
    Then a file named "explosion1.rb" should exist
    Then the file "explosion1.rb" should match /explosion1-0-7.=>{:path=>"explosion1.png", :x=>1792, :y=>0, :w=>256, :h=>256}/
