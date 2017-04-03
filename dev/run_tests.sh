#!/bin/bash
# Runs the Integration Tests

# Use Dokken
export KITCHEN_LOCAL_YAML='.kitchen.dokken.yml'

# Use Vagrant
export KITCHEN_LOCAL_YAML='.kitchen.yml'

# Run the Tests
#chef exec delivery local all
chef exec delivery local lint
chef exec delivery local syntax

# chef exec kitchen converge -c 6
# chef exec kitchen verify

# Kitchen-Dokken yields extremely high CPU utilization, do each suite one at a time
for TEST in default
do
  chef exec kitchen verify "${TEST}"
  chef exec kitchen destroy "${TEST}"
done
