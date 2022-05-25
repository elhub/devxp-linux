# 2. Change to use collection

Date: 2022-05-18

## Status

Accepted

## Context

Currently, we use roles located locally in the playbook. Since we have many common installs together with the other
technical teams at Elhub, we should split out

## Decision

We will create a new collection for WSL with configurable roles that can be used by multiple teams at Elhub.

## Consequences

The devxp-linux playbook will need to be set up to use an external collection. This means that it will not be possible
to run it without first downloading requirements. However, this is considered acceptable, considering the benefits of
ensuring that the various teams use similar setups.

The playbooks of other teams will also need to be modified to use the central ansible collection.
