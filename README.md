# devxp-linux

[<img src="https://img.shields.io/badge/repo-github-blue" alt="">](https://github.com/elhub/devxp-linux)
[<img src="https://img.shields.io/badge/issues-jira-orange" alt="">](https://jira.elhub.cloud/issues/?jql=project%20%3D%20%22Team%20Dev%22%20AND%20component%20%3D%20devxp-linux%20AND%20status%20!%3D%20Done)
[<img src="https://teamcity.elhub.cloud/app/rest/builds/buildType:(id:DevXp_DevXpLinux_PublishDocs)/statusIcon" alt="">](https://teamcity.elhub.cloud/project/DevXp_DevXpLinux?mode=builds#all-projects)
[<img src="https://sonar.elhub.cloud/api/project_badges/measure?project=no.elhub.devxp%3Adevxp-linux&metric=alert_status" alt="">](https://sonar.elhub.cloud/dashboard?id=no.elhub.devxp%3Adevxp-linux)
[<img src="https://sonar.elhub.cloud/api/project_badges/measure?project=no.elhub.devxp%3Adevxp-linux&metric=ncloc" alt="">](https://sonar.elhub.cloud/dashboard?id=no.elhub.devxp%3Adevxp-linux)
[<img src="https://sonar.elhub.cloud/api/project_badges/measure?project=no.elhub.devxp%3Adevxp-linux&metric=bugs" alt="">](https://sonar.elhub.cloud/dashboard?id=no.elhub.devxp%3Adevxp-linux)
[<img src="https://sonar.elhub.cloud/api/project_badges/measure?project=no.elhub.devxp%3Adevxp-linux&metric=vulnerabilities" alt="">](https://sonar.elhub.cloud/dashboard?id=no.elhub.devxp%3Adevxp-linux)

## Table of Contents

* [About](#about)
* [Getting Started](#getting-started)
  * [Prerequisites](#prerequisites)
  * [Installation](#installation)
* [Usage](#usage)
* [Testing](#testing)
* [Contributing](#contributing)
* [Owners](#owners)
* [License](#license)

## About

The devxp-linux script is used to bootstrap Ubuntu WSL on an Elhub developer PC. It ensures that all the required
tools, SDKs and scripts are installed and set up correctly. In addition, it is also used to upgrade an existing
developer PC setup; when rerun, the scripts will validate existing installations and upgrade tools and scripts as
appropriate.

## Getting Started

### Prerequisites

* Windows Subsystem for Linux (WSL)
* Ubuntu 20.04 installed in WSL
* Ansible

The following instructions assumes a standard Elhub Windows 10 developer PC with Windows Subsystem for
Linux version 2. You will need ansible to run this; to install Ansible in Ubuntu 20.04, you can download
and run the bootstrap script in this project:

```bash
./bootstrap.sh
```

### Installation

We assume that the bootstrap script mentioned above has been run. Determine where you will install devxp-linux (we
suggest ```$HOME/workspace/git```), and clone this repository in that location:

```bash
$ git clone git@github.com:elhub/devxp-linux.git
```

Run ansible-galaxy to pull down dependencies:

```bash
$ ansible-galaxy install -r requirements.yml --force
```

Then run ansible-playbook to install the devxp tools:

```bash
$ ansible-playbook site.yml --ask-become-pass
```

The process will prompt you for your (ubuntu wsl) sudo password.

You can (and should) re-run the script from time to time to update the scripts and tools.

You should also set up the EDITOR variable with your text editor of choice, if you haven't already done so.

## Usage

This project install a large number of tools, scripts, SDKs, and applications used for day-to-day development.

It installs the following programming languages/SDKs:
* Ansible
* Java
* Kotlin
* Node/Javascript
* Python

### adr

This is a Java implementation of the adr script-based toold by Nat Pryce. It allows for the simple creation and
maintenance of light-weight architecture decision records.

### arcanist

**Arcanist** is the command-line tool for [Phabricator](https://phabricator.elhub.cloud). It installs our
[arcanist extensions](https://github.com/elhub/devxo-arcanist) and sets up a global arcconfig file. The global
arcconfig contains a number of useful aliases:
* **cleanup**: Cleans up the directory. Be careful (in particular, don't use it with terraform projects).
* **init**: Use with parameters "none", "maven", or "gradle". This copies appropriate default files (arcconfig,
  gitignore, gitattributes, etc) for a project directory. This command can also be run using the arc-init script.
* **log**: Displays git log nicely.
* **patch-clean**: Cleans up arcpatch branches.
* **set-exe**: Use with filename. Sets it to be executable and updates the git index..
* **status**: When run in your workspace directory (i.e., the dir where you keep your repositories, will iterate
  through all available git repos and inform which repositories have modified or untracked files. This command can also
  be run using the arc-status script.

### Linters

This project installs a number of important linters, used by arcanist. These linters can also be used in a standalone
manner.

**Checkstyle** can be used as a command line tool to check that your Java code conforms with a given Java style.
Elhub's default checkstyle config is also installed. The script /usr/local/bin/checkstyle automatically uses our
default config.

See the [checkstyle documentation](https://checkstyle.org/) for more detailed information.

**Detekt** can be used as a command line tool to check that your Kotlin code conforms with a given code style. Elhub's
default kotlin config is also installed. The script in /usr/local/bin/detekt automatically uses our default config.

See the [detekt documentation](https://detekt.github.io/detekt/) for more detailed information.

It also install yamllint and ansible-lint.

### Git Utility Scripts

The project installs a number of git utility scripts on the dev box.

**git-clone-all** is a script that can be used to clone all development repositories from our git servers.

**git-mirror** is a simple script for mirroring repositories using ```git clone --mirror```.

**git-status-all** carries out a ```git status``` on all the repositories in a directory.

## Testing

The project runs basic sanity tests automatically (the validate role) after installation.

### With Docker

```
docker build .
```

## Contributing

Contributing, issues and feature requests are welcome. See the
[Contributing](https://github.com/elhub/devxp-linux/blob/main/CONTRIBUTING.md) file.

## Owners

This project is developed by [Elhub](https://elhub.no). For the specific development group responsible for this
code, see the [Codeowners](https://github.com/elhub/devxp-linux/blob/main/CODEOWNERS) file.

## License

This project is [MIT](https://github.com/elhub/devxp-linux/blob/main/LICENSE.md) licensed.
