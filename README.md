# dev-phabricator

dev-phabricator contains settings and utility scripts and tools for the Phabricator system at Elhub.

## Getting Started

### Prerequisites

* Git
* PHP

The following instructions assumes a standard Windows 10 PC with WSL and Ubuntu installed. Both Git and PHP should
be installed by default if your PC is installed with the Elhub window-dev-box setup. If you have other systems,
you will need to correct your setup accordingly.

### Install

We strongly recommend installing this script in C:\ProgramData\Phabricator. From Ubuntu:

    $ git clone https://phabricator.elhub.cloud/diffusion/DPHABRICATOR/dev-phabricator.git /mnt/c/ProgramData/Phabricator

Set up the paths to Phabricator:

    export PATH="$PATH:/mnt/c/ProgramData/Phabricator/lib/arcanist/bin:/mnt/c/ProgramData/Phabricator/scripts"       

Set up the same path in Windows, if you wish to run arcanist from there (recommended).

Then run the phabricator installer script:

    $ phabricator install

Link the arc config to the default location for Linux. 

     $ ln -s /mnt/c/ProgramData/Phabricator/arcanist/config /etc/arcconfig

You can verify that everything is set up correctly by running the checkstyle and detekt scripts from the
command line in both Ubuntu and Windows cmd.
 
### Troubleshooting

Arcanist requires php.curl; ensure the following is set in your php.ini:

    extension=php_curl.dll

Do not clone from Windows. Doing so will likely give you issues with git autocrlf option. If you find uch issues,
consider deleting the directory and setting:

    $ git config --global core.autocrlf false
    
Before cloning the repository. Once arcanist has been installed, you can re-enable core.autocrlf.

### Structure

#### arcanist

Configuration for arcanist. This includes definitions for a number of recommended arc aliases:

**cleanup**: Cleans up the directory. Be careful (in particular, don't use it with terraform projects).

**log**: Displays git log nicely.

**patch-clean**: Cleans up arcpatch branches. 

#### bin

Contains useful scripts and applications.

#### Checkstyle

Checkstyle be used as a command line tool to check that your Java code conforms with a given Java style. This
directory contains the latest jar, and the checkstyle configuration style that conforms to the Elhub Java style. 

See the [checkstyle documentation](http://checkstyle.sourceforge.net/cmdline.html) for more detailed information. 

#### Detekt

Detekt can be used as a command line tool to check that your Kotlin code conforms with a given Java style. This
directory contains the latest jar, and the kotlin configuration style that conforms to the Elhub Java style. 

See the [detekt documentation](https://arturbosch.github.io/detekt/) for more detailed information. 

#### extensions

This contains Elhub's arcanist extensions.

#### templates

This contains templates for various development project artifacts.

## Meta

[Elhub Tool Repository][confluence]

<!-- Markdown link & img dfn's -->
[confluence]: http://confluence.elhub.org/display/ELTOR

