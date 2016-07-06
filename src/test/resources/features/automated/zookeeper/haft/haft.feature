@rest
Feature: High Availability and Fault Tolerance testing

  Background: Setup PaaS REST client
    Given I send requests to '${DCOS_CLUSTER}:${DCOS_CLUSTER_PORT}'

  Scenario: Scheduler MUST register with a failover timeout
    Given I send a 'GET' request to '/frameworks'
    Then the service response status must be '200'.
    And I save element in position '0' in '$.completed_frameworks[?(@.name == "kafka")].failover_timeout' in environment variable 'failoverTimeout'
    And value stored in '!{failoverTimeout}' is higher than '0'
