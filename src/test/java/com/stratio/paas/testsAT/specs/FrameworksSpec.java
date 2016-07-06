package com.stratio.paas.testsAT.specs;

import cucumber.api.java.en.Then;

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

}
