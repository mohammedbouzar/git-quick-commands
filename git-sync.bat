@echo off
setlocal EnableExtensions

:: ANSI color setup (works in modern Windows terminals)
for /F %%e in ('echo prompt $E^| cmd') do set "ESC=%%e"
set "C_GIT=%ESC%[93m"
set "C_VERB=%ESC%[96m"
set "C_ARG=%ESC%[92m"
set "C_TITLE=%ESC%[95m"
set "C_RST=%ESC%[0m"

:: Default stash message
set "STASH_MSG=smart-sync"

:: -----------------------
:: Parse arguments
:: -----------------------
:parse
if "%~1"=="" goto run

if "%~1"=="-h" goto help

if "%~1"=="-m" (
    set STASH_MSG=%~2
    shift
    shift
    goto parse
)

echo Unknown option: %~1
goto help

:: -----------------------
:: Help
:: -----------------------
:help
echo.
echo %C_TITLE%git-sync%C_RST%
echo.
echo Usage:
echo   %C_GIT%git-sync%C_RST% [%C_ARG%-m "message"%C_RST%]
echo   %C_GIT%git-sync%C_RST% %C_ARG%-h%C_RST%
echo.
echo Options:
echo   %C_ARG%-m%C_RST%   Stash message
echo   %C_ARG%-h%C_RST%   Show this help
echo.
exit /b 0

:: -----------------------
:: Main logic
:: -----------------------
:run

echo.
echo Staging all changes...
git add -A

echo.
echo Saving local changes...
git stash push -m "%STASH_MSG%"

echo Detecting default branch...
for /f %%i in ('git symbolic-ref --short refs/remotes/origin/HEAD') do set MAIN=%%i
set MAIN=%MAIN:origin/=%

@REM echo Checking out %MAIN%...
@REM git checkout %MAIN%

@REM echo Pulling latest changes from origin/%MAIN%...
@REM git pull origin %MAIN%

@REM echo Checking out previous branch...
@REM git checkout -

echo.
echo Pulling latest changes
git pull

@REM --no-ff for merge commit, --no-edit to skip the editor
echo.
echo Merging changes...
git merge --no-ff --no-edit origin/%MAIN%

echo.
echo Status after merge...
git status

echo.
echo Pushing changes...
git push

echo.
echo ====================================
echo.
echo Next steps for you (manual mode):
echo.
echo 1. Restore your stashed work:
echo    %C_GIT%git%C_RST% %C_VERB%stash%C_RST% %C_ARG%apply --index%C_RST%
echo.
echo 2. If there are conflicts, resolve them in your editor and then run:
echo    %C_GIT%git%C_RST% %C_VERB%add%C_RST% %C_ARG%.%C_RST%
echo    %C_GIT%git%C_RST% %C_VERB%commit%C_RST% %C_ARG%-m "COMMIT_MESSAGE"%C_RST%
echo    %C_GIT%git%C_RST% %C_VERB%push%C_RST%
echo.
echo 3. When everything looks good, remove the stash entry:
echo    %C_GIT%git%C_RST% %C_VERB%stash%C_RST% %C_ARG%drop%C_RST%


echo.
echo Everything done!
echo.