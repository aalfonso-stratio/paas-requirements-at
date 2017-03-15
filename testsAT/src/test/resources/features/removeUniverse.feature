@rest
Feature: Removing paas universe

  Background: Universe functional tests
    Given I open a ssh connection to '${DCOS_CLI_HOST}' with user 'root' and password 'stratio'

  Scenario: Remove PaaS Online Universe & Reinstall
    Given I run 'dcos package repo remove PaaS' in the ssh connection with exit status '0'
    When I run 'dcos package repo list' in the ssh connection with exit status '0'
    Then the command output does not contain 'PaaS: http://iodo.stratio.com:8080/repo'

    Given I run 'dcos package repo add --index=0 PaaS http://iodo.stratio.com:8080/repo' in the ssh connection with exit status '0'
    When I run 'dcos package repo list' in the ssh connection with exit status '0'
    Then the command output contains 'PaaS: http://iodo.stratio.com:8080/repo'