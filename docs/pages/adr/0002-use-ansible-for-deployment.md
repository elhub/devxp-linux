# 2. Use Ansible for deployment

Date: 2020-11-10

## Status

Proposed

## Context

The current install approach for this repository is based on shell scripts and source files being downloaded and built
manually. This has proven error-prone and the deployment of the dev-tools itself is quite time-consuming, especially
the first time.

It is also very hard to make too fine changes to the developers environment, since any small deviation can easily crash
a shell script; testing for all eventualities is extremely difficult.

## Decision

We will:
* Use ansible to deploy dev-tools
* Use binaries built externally to the dev-tools project

## Consequences

This will:
* Ensure that the install becomes more robust (we gain the benefits of ansible: declarative code, ansible modules)
* Enable more detailed control of the developers tools and environments (ansible modules enable better and more precise
control of the changes implemented, since they carry out the important checks).
* Significantly speed up the time it takes for dev-tools to install/upgrade

It also means that we will need to have ansible installed before-hand. However, this can (and should) be added
to the windows-dev-box setup, as ansible is a standard dev tool at Elhub.
