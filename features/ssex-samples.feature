Feature: Get sample assets
  In order to kick the tyres quickly
  As a DragonRuby game developer
  I want to have a look at the built-in samples and assets

  Scenario: Find the path to embedded code samples
    Given the path to the samples directory
    When I successfully run `ssex --samples`
    Then the output should contain the path to the samples directory
