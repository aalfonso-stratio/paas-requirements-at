@rest
Feature: Removing marathon-lb

  Background: marathon-lb functional tests
    Given I open a ssh connection to '${DCOS_CLI_HOST}' with user '${DCOS_CLI_USER}' and password '${DCOS_CLI_PASSWORD}'

  Scenario: Remove XD-Viewer marathon-lb
    Given I run 'dcos package uninstall --app-id=crossdata marathon-lb' in the ssh connection with exit status '0'
    Then the command output contains 'Uninstalled package [marathon-lb] version [1.5.0]'
    And the command output contains 'Marathon-lb DC/OS Service has been uninstalled and will no longer run.'
    And in less than '30' seconds, checking each '5' seconds, the command output 'dcos task | grep crossdata | wc -l' contains '0'

  Scenario: Remove Viewer marathon-lb
    Given I run 'dcos package uninstall --app-id=marathon-lb marathon-lb' in the ssh connection with exit status '0'
    Then the command output contains 'Uninstalled package [marathon-lb] version [1.5.0]'
    And the command output contains 'Marathon-lb DC/OS Service has been uninstalled and will no longer run.'
    And in less than '30' seconds, checking each '5' seconds, the command output 'dcos task | grep marathon-lb | wc -l' contains '0'
