# Technical Overview

## Context

[<img src="../../assets/media/context.jpg" width="300">](../../assets/media/context.jpg)

### Developer

Developers should regularly pull and run the dev-tools playbook from the git repository.

## Code

The playbook is run from install.yml. The code itself is split into four ansible roles.

### arcanist_core

This role is responsible for installing arcanist in WSL, including templates and arcanist support scripts.

### arcanist_linters

This role handles downloading the linters required by the development environment, as well as installing
the lint extensions.

### install_utils

This role installs various utility scripts and applications.

### test_install

This role carries out a basic smoke test in the WSL shell, in order to verify that the most critical scripts and
applications are working as intended.

## Runtime View

Not applicable.
