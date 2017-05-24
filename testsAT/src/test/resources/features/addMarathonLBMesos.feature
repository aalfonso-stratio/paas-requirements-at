@rest
Feature: Adding marathon-lb Mesos

  Scenario: Add Mesos Marathon-lb
    Given I authenticate to DCOS cluster '${DCOS_IP}' using email '${DCOS_USER}', with user '${REMOTE_USER}' and password '${REMOTE_PASSWORD}'
    And I open a ssh connection to '${DCOS_CLI_HOST}' with user '${DCOS_CLI_USER}' and password '${DCOS_CLI_PASSWORD}'
    And I securely send requests to '${DCOS_IP}:443'
    When I send a 'POST' request to '/marathon/v2/apps' based on 'schemas/marathon-lb-mesos.json' as 'json' with:
      | $.id | UPDATE | /marathon-lb |
    Then the service response status must be '201'.
    And in less than '200' seconds, checking each '20' seconds, the command output 'dcos task | grep marathon-lb | grep R | wc -l' contains '1'
    And I wait '200' seconds
    When I send a 'GET' request to '/mesos/frameworks'
    Then the service response status must be '200'.
    And I save element '$' in environment variable 'coordinator'
    And 'coordinator' matches the following cases:
      | $.frameworks[?(@.name == "marathon")].tasks[?(@.name == "marathon-lb")].statuses[*].state           | contains   | TASK_RUNNING          |