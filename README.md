# dev-phabricator

dev-phabricator contains settings and utility scripts and tools for the Phabricator system at Elhub.

## Getting Started

The following instructions assumes a standard Windows 10 PC with WSL and Ubuntu installed. If you have other systems,
you will need to correct your setup accordingly. 

We strongly recommend installing this script in C:\ProgramData\Phabricator. From Ubuntu:

    $ git clone https://phabricator.elhub.cloud/diffusion/DPHABRICATOR/dev-phabricator.git /mnt/c/ProgramData/Phabricator

Set up the paths to Phabricator:

    export PATH="$PATH:/mnt/c/ProgramData/Phabricator/arcanist/bin:/mnt/c/ProgramData/Phabricator/scripts"

Set up the same path in Windows, if you wish to run arcanist from there (recommended).

Then run the phabricator installer script:

    $ phabricator install

Once it is done, you can verYou can verify that everything is set up correctly by running the checkstyle and
detekt scripts from the command line.
 
### Prerequisites

**Git** is required to retrieve the EL-module and to run some of the scripts.

**Arcanist** is required to use the extensions. See the [Installing Arcanist](http://confluence.elhub.org/display/ELTOR/Installing+Arcanist)
guide.

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

#### extensions

This contains Elhub's arcanist extensions.

#### intellij

This contains code styles for IntelliJ. Use File > Settings > Editor > Code Styles and import the XML schema. 

#### templates

This contains templates for various development project artifacts.

## Meta

[Elhub Tool Repository][confluence]

<!-- Markdown link & img dfn's -->
[confluence]: http://confluence.elhub.org/display/ELTOR

