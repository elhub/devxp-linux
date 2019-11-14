@echo off
:: Need to do an if-else in order to handle the idiotic handling of paths in Windows
:: i.e., %~dp0 sometimes returns the bin directory and sometimes the working directory.
if exist %~dp0/../checkstyle/checkstyle-8.16-all.jar (
    java -jar %~dp0/../checkstyle/checkstyle-8.16-all.jar %*
) else (
    java -jar %~dp0/../phabricator/elhubdev/checkstyle/checkstyle-8.16-all.jar %*
)
