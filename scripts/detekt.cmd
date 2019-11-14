@echo off
:: Need to do an if-else in order to handle the idiotic handling of paths in Windows
:: i.e., %~dp0 sometimes returns the bin directory and sometimes the working directory.
if exist %~dp0/../detekt/detekt.jar (
    java -jar %~dp0/../detekt/detekt.jar %*
) else (
    java -jar c:/ProgramData/Phabricator/detekt/detekt.jar %*
)
