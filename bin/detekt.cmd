@echo off
:: Need to do an if-else in order to handle the idiotic handling of paths in Windows
:: i.e., %~dp0 sometimes returns the bin directory and sometimes the working directory.
if exist %~dp0/../detekt/detekt-cli-1.0.0-RC12-all.jar (
    java -jar %~dp0/../detekt/detekt-cli-1.0.0-RC12-all.jar %*
) else (
    java -jar %~dp0/../phabricator/elhubdev/detekt/detekt-cli-1.0.0-RC12-all.jar %*
)
