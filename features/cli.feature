
Feature: CLI
@announce
 Scenario: Run With No Args
   When I run `test`
   Then the exit status should be 0