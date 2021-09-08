# dev-tools-linux

[<img src="https://img.shields.io/badge/repo-github-blue" alt="">](https://github.com/elhub/dev-tools-linux)
[<img src="https://img.shields.io/badge/issues-jira-orange" alt="">](https://jira.elhub.cloud/issues/?jql=project%20%3D%20%22Team%20Dev%22%20AND%20component%20%3D%20dev-tools-linux%20AND%20status%20!%3D%20Done)
[<img src="https://teamcity.elhub.cloud/app/rest/builds/buildType:(id:Tools_DevToolsLinux_PublishDocs)/statusIcon" alt="">](https://teamcity.elhub.cloud/buildConfiguration/Tools_DevToolsLinux_PublishDocs)
[<img src="https://sonar.elhub.cloud/api/project_badges/measure?project=no.elhub.tools%3Adev-tools-linux&metric=alert_status" alt="">](https://sonar.elhub.cloud/dashboard?id=no.elhub.tools%3Adev-tools-linux)
[<img src="https://sonar.elhub.cloud/api/project_badges/measure?project=no.elhub.tools%3Adev-tools-linux&metric=ncloc" alt="">](https://sonar.elhub.cloud/dashboard?id=no.elhub.tools%3Adev-tools-linux)
[<img src="https://sonar.elhub.cloud/api/project_badges/measure?project=no.elhub.tools%3Adev-tools-linux&metric=bugs" alt="">](https://sonar.elhub.cloud/dashboard?id=no.elhub.tools%3Adev-tools-linux)
[<img src="https://sonar.elhub.cloud/api/project_badges/measure?project=no.elhub.tools%3Adev-tools-linux&metric=vulnerabilities" alt="">](https://sonar.elhub.cloud/dashboard?id=no.elhub.tools%3Adev-tools-linux)
[<img src="https://sonar.elhub.cloud/api/project_badges/measure?project=no.elhub.test%3Adev-tools-linux&metric=coverage" alt="">](https://sonar.elhub.cloud/dashboard?id=no.elhub.test%3Adev-tools-linux)


## Table of Contents

* [About](#about)
* [Getting Started](#getting-started)
  * [Prerequisites](#prerequisites)
  * [Installation](#installation)
* [Usage](#usage)
* [Testing](#testing)
* [Roadmap](#roadmap)
* [Contributing](#contributing)
* [Owners](#owners)
* [License](#license)


## About

The dev-tools project installs development scripts and applications used by Elhub development team.
In particular, this includes the code and extensions for Phabricator.


## Getting Started

### Prerequisites

* Windows Subsystem for Linux (WSL)
* Ubuntu 20.04
* Ansible

The following instructions assumes a standard Elhub Windows 10 developer PC with Windows Subsystem for
Linux version 2. You will need ansible to run this; to install Ansible in Ubuntu 20.04, you can download
and run the bootstrap script in this project:

    $ ./bootstrap.sh

### Installation

Determine where you will install dev-tools. If you want to use dev-tools in Windows, it should be a
directory accessible to Windows as well as Linux (i.e., in /mnt/c).

Then run the ansible-pull:

    $ ansible-pull -U https://github.com/elhub/dev-tools.git --purge -K install.yml

The process will prompt you for your sudo password.

You can (and should) re-run the script from time to time to update the scripts and tools.

You should also set up the EDITOR variable with your text editor of choice, if you haven't already done so.

#### Troubleshooting

Arcanist requires php.curl; ensure the following is set in your php.ini:

    extension=php_curl.dll


## Usage

This project install a large number of tools, scripts, and applications used for day-to-day development.

### adr

This is a Java implementation of the adr script-based toold by Nat Pryce. It allows for the simple creation and maintenance of light-weight architecture
decision records.

### arcanist

**Arcanist** is the command-line tool for [Phabricator](https://phabricator.elhub.cloud). It installs our
[arcanist extensions](https://github.com/elhub/dev-tools-arcanist) and sets up a global arcconfig file. The global arcconfig contains a number of useful
aliases:

**cleanup**: Cleans up the directory. Be careful (in particular, don't use it with terraform projects).

**init**: Use with parameters "none", "maven", or "gradle". This copies appropriate default files (arcconfig, gitignore, gitattributes, etc) for a project
directory. This command can also be run using the arc-init script.

**log**: Displays git log nicely.

**patch-clean**: Cleans up arcpatch branches.

**set-exe**: Use with filename. Sets it to be executable and updates the git index..

**status**: When run in your workspace directory (i.e., the dir where you keep your repositories, will iterate through all available git repos and inform
which repositories have modified or untracked files. This command can also be run using the arc-status script.

### Linters

This project installs a number of important linters, used by arcanist. These linters can also be used in a standalone manner.

**Checkstyle** can be used as a command line tool to check that your Java code conforms with a given Java style. Elhub's default checkstyle config is also
installed. The script /usr/local/bin/checkstyle automatically uses our default config.

See the [checkstyle documentation](https://checkstyle.org/) for more detailed information.

**Detekt** can be used as a command line tool to check that your Kotlin code conforms with a given code style. Elhub's default kotlin config is also
installed. The script in /usr/local/bin/detekt automatically uses our default config.

See the [detekt documentation](https://detekt.github.io/detekt/) for more detailed information.

### Other scripts

**make-release** can be used to create release branches according to the used conventions.
It ensures the following:
- the base branch for the release is always 'origin/master', so even if local master is ahead/behind origin this will not affect the release branch.
- only allowed branch names are used for releases.

**copy-git-hooks** can be used as a "glue" to copy/refresh all available git-hooks from dev-tools into another repository.
This can be combined with an `init` make target that should be a part of the target repo. See also D456 for sample usage.

**git-mirror** is a simple script for mirroring repositories using git clone --mirror.

### git-hooks

We install some git hooks in /usr/local/etc/git-hooks. More detailed installation/usage details are available in each script.

See also `copy-git-hooks`.

**pre-push** prevents direct pushes to master. It does work with `arc land` though, which is what everyone should be using for landing diff changes.


## Testing

The project runs tests automatically (the test_install role) after install.

## Roadmap

See the [open issues](https://jira.elhub.cloud/issues/?jql=project%20%3D%20TD%20AND%20component%20%3D%20dev-tools%20AND%20resolution%20%3D%20Unresolved) for a list of proposed features (and known issues).

## Contributing

Contributing, issues and feature requests are welcome. See the
[Contributing](https://github.com/elhub/dev-tools/blob/main/CONTRIBUTING.md) file.

## Owners

This project is developed by [Elhub](https://elhub.no). For the specific development group responsible for this
code, see the [Codeowners](https://github.com/elhub/dev-tools/blob/main/CODEOWNERS) file.

## License

This project is [MIT](https://github.com/elhub/dev-tools/blob/main/LICENSE.md) licensed.
