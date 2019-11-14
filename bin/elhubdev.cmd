@echo off
IF "%1"=="upgrade" (
    if exist %~dp0/../bin/elhubdev.cmd (
        start /d "%~dp0/.." cmd /k "git pull & exit"
    ) else (
        start /d "cd %~dp0/../phabricator/elhubdev/" cmd /k git "pull & exit"
    )
) ELSE (
    echo Usage:
    echo upgrade: Upgrade the elhubdev repository from source
    echo help:    These help instructions
)
