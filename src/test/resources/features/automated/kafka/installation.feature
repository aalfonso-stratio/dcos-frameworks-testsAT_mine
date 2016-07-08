@rest
Feature: Installing / uninstalling testing with KAFKA

  Background: Setup PaaS REST client
  #    Given I send requests to '${DCOS_CLUSTER}:${DCOS_CLUSTER_PORT}'
  Given I open remote ssh connection to host '${DCOS_CLI_HOST}' with user 'root' and password 'stratio'


  Scenario: Stratio Spec x6. A service CAN be installed from the CLI
    When I execute command 'dcos package install ${SERVICE}' in remote ssh connection
    Then I wait '120' seconds
    When I execute command 'dcos service' in remote ssh connection
    Then the command output contains '${SERVICE}'
    When I execute command 'dcos marathon task list' in remote ssh connection
    Then the command output contains '/${SERVICE}'


  Scenario: Stratio Spec x7. A service CAN be uninstalled from the CLI
    Given I execute command 'dcos package uninstall ${SERVICE}' in remote ssh connection
    When I execute command 'dcos marathon app show ${SERVICE}' in remote ssh connection
#    Then the command output contains ' '
    #TODO implemet not contain method

    And I open remote ssh connection to host '${DCOS_CLUSTER}' with user 'root' and password 'stratio'
    When I execute command 'docker run mesosphere/janitor /janitor.py -r ${SERVICE}-role -p ${SERVICE}-principal -z ${SERVICE}' in remote ssh connection
    Then the command output contains 'Cleanup completed successfully.'
    #TODO check volumes state after running the cleanup container.

  Scenario: Stratio Spec x8. A service CAN be reinstalled from the CLI
    #TODO review the behaviour of Janitor. Kafka & Cassandra needs to run it before trying the reinstallation.
    When I execute command 'dcos package install ${SERVICE}' in remote ssh connection
    Then I wait '120' seconds
    When I execute command 'dcos service' in remote ssh connection
    Then the command output contains '${SERVICE}'
    When I execute command 'dcos marathon task list' in remote ssh connection
    Then the command output contains '/${SERVICE}'

    Given I execute command 'dcos package uninstall ${SERVICE}' in remote ssh connection
    When I execute command 'dcos marathon app show ${SERVICE}' in remote ssh connection
#    Then the command output contains ' '

    When I execute command 'dcos package install ${SERVICE}' in remote ssh connection
    Then I wait '120' seconds
    When I execute command 'dcos service' in remote ssh connection
    Then the command output contains '${SERVICE}'
    When I execute command 'dcos marathon task list' in remote ssh connection
    Then the command output contains '/${SERVICE}'


#  Scenario: Stratio Spec x9. A service MUST remove its data after it is uninstalled.
#    When I send a 'GET' request to '/service/marathon/v2/tasks'
#    Then I save element '$.tasks.[?(@.appId == "/${SERVICE}")]' in environment variable 'idService'
