@rest
Feature: Adding marathon-lb

  Background: marathon-lb functional tests
    Given I open a ssh connection to '${DCOS_CLI_HOST}' with user '${DCOS_CLI_USER}' and password '${DCOS_CLI_PASSWORD}'

  Scenario: Add XD-Viewer marathon-lb
    Given I outbound copy 'target/test-classes/schemas/marathon-lb-XD.json' through a ssh connection to '/dcos'
    When I run 'dcos marathon app add /dcos/marathon-lb-XD.json' in the ssh connection with exit status '0'
    Then the command output contains 'Created deployment'
    When I run 'dcos task | grep crossdata' in the ssh connection with exit status '0'
    Then in less than '300' seconds, checking each '20' seconds, the command output 'dcos task | grep crossdata | grep R | wc -l' contains '1'

  Scenario: Add Viewer marathon-lb
    Given I outbound copy 'target/test-classes/schemas/marathon-lb-Default.json' through a ssh connection to '/dcos'
    When I run 'dcos marathon app add /dcos/marathon-lb-Default.json' in the ssh connection with exit status '0'
    Then the command output contains 'Created deployment'
    When I run 'dcos task | grep marathon-lb' in the ssh connection with exit status '0'
    Then in less than '300' seconds, checking each '20' seconds, the command output 'dcos task | grep marathon-lb | grep R | wc -l' contains '1'