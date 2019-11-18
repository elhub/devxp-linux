@echo off
:: Need to do an if-else in order to handle the idiotic handling of paths in Windows
:: i.e., %~dp0 sometimes returns the bin directory and sometimes the working directory.
if exist %~dp0/../lib/checkstyle.jar (
    java -jar %~dp0/../lib/checkstyle.jar -c=../checkstyle-config.xml %*
) else (
    java -jar c:/ProgramData/Phabricator/libchecks/checkstyle.jar -c=../checkstyle-config.xml %*
)
