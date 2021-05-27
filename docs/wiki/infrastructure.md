# Infrastructure Overview

The dev-tools project is installed in WSL2 on your developer PC.

Scripts and binaries are generally installed in the default Linux locations (/usr/lib, etc.) as can be seen
in the ansible scripts. Arcanist files, templates, and any other user specific files which do not fit elsewhere
are placed in /home/<user>/.dev-tools. This location was previously configurable, but in order to ensure that
consistent development environments, that configurability has been removed.
