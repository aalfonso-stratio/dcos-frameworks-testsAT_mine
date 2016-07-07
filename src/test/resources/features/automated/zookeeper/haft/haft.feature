@rest
Feature: High Availability and Fault Tolerance testing

  Background: Setup PaaS REST client
    Given I obtain mesos master in cluster '${DCOS_CLUSTER}' and store it in environment variable 'mesosMaster'
    And I send requests to '!{mesosMaster}:${MESOS_API_PORT}'

  Scenario: Spec 01 - Scheduler MUST register with a failover timeout
    Given I send a 'GET' request to '/frameworks'
    Then the service response status must be '200'.
    And I save element in position '0' in '$.frameworks[?(@.name == "kafka")].failover_timeout' in environment variable 'failoverTimeout'
    And value stored in '!{failoverTimeout}' is higher than '0'

  #Scenario: Spec 02 - Scheduler MUST persist their FrameworkID for failover
  #Scenario: Spec 03 - Scheduler MUST recover from process termination

  Scenario: Spec 04 - Scheduler MUST enable checkpointing
    Given I send a 'GET' request to '/frameworks'
    Then the service response status must be '200'.
    And I save element in position '0' in '$.frameworks[?(@.name == "kafka")].checkpoint' in environment variable 'checkpoint'
    And value stored in '!{checkpoint}' is 'true'

  #Scenario: Spec 15 - Scheduler MUST reconcile tasks during failover
  #Scenario: Spec 16 - Scheduler MUST use a reliable store for persistent state
  #Scenario: Spec 22 - Service MUST recover from lost executors and tasks
