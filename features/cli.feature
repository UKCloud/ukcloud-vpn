
Feature: CLI
 Scenario: Run With No Args
   When I run `skyscape-vpn`
   Then the exit status should be 0

  Scenario: Print Version
   When I run `skyscape-vpn -v`
   Then the stdout should contain "0.0.1"
