# dev-phabricator

dev-phabricator contains settings and utility scripts and tools for the Phabricator system at Elhub.

## Getting Started

It is recommended that elhubdev is installed into the development workspace in the "phabricator" directory (which should
also contain arcanist and libphutil). Doing so allows arcanist to find elhubdev without having to specify an absolute
path.

    $ git clone http://your.username@stash.elhub.org/scm/tt/elhubdev.git

The bin of the new path should be added to the path environment variable; i.e., if elhubdev is installed at

    c:\elhub\phabricator\elhubdev

Then add the following to path: 

    c:\elhub\phabricator\elhubdev\bin

You can verify that the new path is set up correctly by running "checkstyle" from the command line. It will return an
error code, but should find the checkstyle command-line tool (and request an input file).
 
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

