package com.stratio.paas.testsAT.specs;

import cucumber.api.java.en.Then;
import com.stratio.tests.utils.RemoteSSHConnection;
import com.stratio.tests.utils.ThreadProperty;

import static com.stratio.assertions.Assertions.assertThat;

public class FrameworksSpec extends BaseSpec {

    public FrameworksSpec(Common spec) {
        this.commonspec = spec;
    }

    /*
     * Check value stored in environment variable is higher than value provided
     *
     * @param envVar
     * @param value
     *
     */
    @Then("^value stored in '(.+?)' is higher than '(.+?)'$")
    public void valueHigher(String envVar, String value) throws Exception {
        assertThat(Integer.parseInt(envVar)).isGreaterThan(Integer.parseInt(value));
    }

    /*
     * Check value stored in environment variable is higher than value provided
     *
     * @param envVar
     * @param value
     *
     */
    @Then("^value stored in '(.+?)' is '(.+?)'$")
    public void valueMatches(String envVar, String value) throws Exception {
        assertThat(envVar).matches(value);
    }

    /*
     * Obtain Mesos Master and store it in environment variable
     *
     * @param clusterMaster
     * @param envVar
     *
     */
    @Then("^I obtain mesos master in cluster '(.+?)' and store it in environment variable '(.+?)'$")
    public void obtainMesosMaster(String clusterMaster, String envVar) throws Exception {
        commonspec.setRemoteSSHConnection(new RemoteSSHConnection("root", "stratio", clusterMaster, null));
        commonspec.getRemoteSSHConnection().runCommand("getent hosts leader.mesos | awk '{print $1}'");
        ThreadProperty.set(envVar, commonspec.getRemoteSSHConnection().getResult().trim());
    }

}
