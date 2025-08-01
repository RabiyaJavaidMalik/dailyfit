@echo off
echo ========================================
echo Android Development Environment Setup
echo ========================================
echo.

:: Check if running as administrator
net session >nul 2>&1
if %errorLevel% == 0 (
    echo Running as Administrator - Good!
) else (
    echo ERROR: This script must be run as Administrator
    echo Right-click on this file and select "Run as administrator"
    pause
    exit /b 1
)

echo.
echo Setting up environment variables...

:: Set JAVA_HOME
echo Setting JAVA_HOME...
setx JAVA_HOME "C:\Program Files\Java\jdk-24" /M
if %errorLevel% == 0 (
    echo ✓ JAVA_HOME set successfully
) else (
    echo ✗ Failed to set JAVA_HOME
    echo Please check if JDK is installed at C:\Program Files\Java\jdk-24
)

:: Set ANDROID_HOME
echo Setting ANDROID_HOME...
setx ANDROID_HOME "C:\Users\%USERNAME%\AppData\Local\Android\Sdk" /M
if %errorLevel% == 0 (
    echo ✓ ANDROID_HOME set successfully
) else (
    echo ✗ Failed to set ANDROID_HOME
)

:: Update PATH with Java and Android tools
echo Updating PATH variable...
setx PATH "%PATH%;%JAVA_HOME%\bin;%ANDROID_HOME%\platform-tools;%ANDROID_HOME%\tools;%ANDROID_HOME%\tools\bin" /M
if %errorLevel% == 0 (
    echo ✓ PATH updated successfully
) else (
    echo ✗ Failed to update PATH
)

echo.
echo ========================================
echo Setup Complete!
echo ========================================
echo.
echo Please restart your Command Prompt or PowerShell
echo to apply the new environment variables.
echo.
echo To verify the setup, run these commands:
echo   java -version
echo   javac -version
echo   adb version
echo.
echo If you see "command not found" errors,
echo please restart your terminal and try again.
echo.
pause 