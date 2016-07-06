@rest
Feature: Scalability testing

  Background: Resources should be increased when its manually re-scaled.
    Then I send requests to '${DCOS_CLUSTER}:${DCOS_CLUSTER_PORT}'

  Scenario:
    Given I send a 'POST' request to '/service/marathon/v2/apps' based on 'schemas/mesos-offers-api' as 'json'
    Then the service response status must be '201'.
    And I save element '$.id' in environment variable 'idDeploy'

    When I send a 'GET' request to '/service/marathon/v2/apps/${idDeploy}'
    Then the service response status must be '200'.
    And the service response status must be 'tasksRunning' and its response must contain the text '1'