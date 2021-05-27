# Introduction

dev-tools is a module designed to simplify and streamline development work at Elhub A/S and ensure all developers
have relatively consistent development environments. It is an ansible playbook that installs application packages,
arcanist (the command-line client for Phabricator), various linters, helper scripts, and templates.

## Requirements Overview

**Main features**
* Simplify installation of arcanist
* Install linters required for arcanist lint
* Installs all packages required for development
* Install templates for setting up repositories

## Quality Goals

dev-tools should follow the
[Software Quality Goals](https://confluence.elhub.cloud/display/EW/Software+Quality+Goals) of Elhub. In addition,
it has the following quality goals.

| ID  | Quality | Motivation |
| --- | ------- | ---------- |
| SQ1 | Simple to install | The dev-tools module must be easy to install and update. |

## Architecture Constraints

dev-tools should follow the
[Software Architecture Principles](https://confluence.elhub.cloud/display/EW/Software+Architecture+Principles) of Elhub.
In addition, it should follow the following:

### Technical Constraints

| ID  | Constraint | Background/Motivation |
| --- | ---------- | --------------------- |
| TC1 | Implementation using ansible | See [ADR 0002](https://docs.elhub.cloud/sandbox/docs-build-configuration/adr/0002-use-ansible-for-deployment/). |

### Organizational Constraints

| ID  | Constraint | Background/Motivation |
| --- | ---------- | --------------------- |
| OC1 | Team       | Maintained by the @elhub/tools team. |

### Conventions

No special conventions.

## Stakeholders

The following lists the most important stakeholders for this module.

| Role/Name  | Goal/Boundaries |
| ---------- | --------------- |
| Developers | Developers who are the users of the dev-tools module. |
