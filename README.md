# dev-tools

dev-tools contains and installs utility scripts and tools that should be used
when developing on the Elhub system. This includes the scripts and libraries
used with Phabricator.

## Getting Started

### Prerequisites

* Git
* PHP

The following instructions assumes a standard Windows 10 PC with WSL and Ubuntu
installed. Both Git and PHP should be installed by default if your PC is
installed with the Elhub window-dev-box setup. If you have another system,
you will need to set it up accordingly.

### Installing

Determine where you will install dev-tools. It should be a directory that is
accessible to Windows as well as Linux.

Clone the repository into the chosen path (assuming C:\Workspace\dev-tools is the chosen install directory):

    $ git clone https://phabricator.elhub.cloud/diffusion/DEVTOOLS/dev-tools.git /mnt/c/Workspace/dev-tools

Link the arc config to the default location for Linux.

     $ ln -s /mnt/c/Workspace/dev-tools/arcanist/config /etc/arcconfig

Set up the path to the scripts:

    export PATH="$PATH:/mnt/c/Workspace/dev-tools/lib/arcanist/bin:/mnt/c/Workspace/dev-tools/scripts"

Run the dev-tools script to install and build the tools:

    $ dev-tools install

You can then run dev-tools upgrade in future to update the repository and
the tools. Note that the first time, this will take quite a long time (due to
the full compilation). Set up the following paths in Windows, if you wish to
run arcanist from there (recommended).

    c:\Workspace\dev-tools\lib\arcanist\bin
    c:\Workspace\dev-tools\scripts

Set up a symbolic link in Windows to c:\ProgramData\Phabricator (from an
elevated command prompt):

    mklink /D c:\ProgramData\Phabricator c:\Workspace\dev-tools

To use adr, set up ADR_HOME:

    export ADR_HOME="/mnt/c/Workspace/dev-tools/lib/adr-j"

Do the same in Windows, if you wish to use it from the Windows command prompt.
You should also set up the EDITOR variable with your text editor of choice, if
you haven't already done so.

### Troubleshooting

Arcanist requires php.curl; ensure the following is set in your php.ini:

    extension=php_curl.dll

Do not clone from Windows. Doing so will likely give you issues with git
autocrlf option. Ensure you have configured core.autocrlf appropriately:

    $ git config --global core.autocrlf input

## Testing

You can verify that everything is set up correctly by running the checkstyle
and detekt scripts from the command line in both Linux and Windows cmd.

To verify that arcanist is set up correctly, run ''''arc help'''' in Linux
and Windows. To validate adr, run ''''adr help'''' in Linux and Windows.

## Deployment

See installation instructions. These utilities are always intended for
deployment on a Statnett Developer PC. Installation on under configurations
may or may not work.

## Usage

This repository contains a number of tools that are of use to developers.

### adr

This is a Java implementation of the adr script-based toold by Nat Pryce. It
allows for the simple creation and maintenance of light-weight architecture
decision records.

### arcanist

This contains arcanist configurations. This includes definitions for a number
of recommended arc aliases:

**cleanup**: Cleans up the directory. Be careful (in particular, don't use it
with terraform projects).

**log**: Displays git log nicely.

**patch-clean**: Cleans up arcpatch branches.

The arcanist script itself is cloned into lib/arcanist.

### lint

This contains the linting rules used at Elhub for Checkstyle and Detekt.

### scripts

This directory contains a number of utility scripts, including shell and
command scripts to run checkstyle and detekt.

**Checkstyle** can be used as a command line tool to check that your Java code
conforms with a given Java style. The script uses the jar built in the lib
directory and the checkstyle configuration style that conforms to the Elhub
Java style.

See the [checkstyle documentation](http://checkstyle.sourceforge.net/cmdline.html)
for more detailed information.

**Detekt** can be used as a command line tool to check that your Kotlin code
conforms with a given code style. The script uses the jar built in the lib
directory and uses the detekt configuration style that conforms to the Elhub
Kotlin style.

See the [detekt documentation](https://arturbosch.github.io/detekt/) for more
detailed information.

**make-release** can be used to create release branches according to the used conventions.
It ensures the following:
- the base branch for the release is always 'origin/master', so even if local
master is ahead/behind origin this will not affect the release branch.
- only allowed branch names are used for releases.

### templates

This directory contains templates for various development project artifacts.

## Meta

* [Development Handbook](https://confluence.elhub.org/display/DEV/Handbook)
