
Feature: CLI
  Scenario: Run With No Args
    When I run `ukcloud-vpn`
    Then the exit status should be 0

  Scenario: Print Version
    When I run `ukcloud-vpn version`
    Then the stdout should contain version

  Scenario: Apply Command Works
    When I run `ukcloud-vpn apply /tmp/somedummyfile`
    Then the stdout should contain "Configuration File Not Found At /tmp/somedummyfile"

