@echo off
echo ========================================
echo Restarting Command Prompt and Verifying
echo ========================================
echo.

echo This will open a new Command Prompt window with refreshed environment variables
echo and automatically run the verification script.
echo.

echo Press any key to continue...
pause >nul

:: Start a new command prompt with refreshed environment
start "Android Environment Verification" cmd /k "cd /d %CD% && verify_setup.bat" 