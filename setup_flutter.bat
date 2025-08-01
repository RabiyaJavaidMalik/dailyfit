@echo off
echo ========================================
echo Flutter SDK Setup
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
echo Downloading Flutter SDK...
echo.

:: Create Flutter directory
if not exist "C:\flutter" (
    mkdir "C:\flutter"
    echo Created Flutter directory
) else (
    echo Flutter directory already exists
)

:: Download Flutter SDK
echo Downloading Flutter SDK (this may take a few minutes)...
powershell -Command "& {Invoke-WebRequest -Uri 'https://storage.googleapis.com/flutter_infra_release/releases/stable/windows/flutter_windows_3.24.5-stable.zip' -OutFile 'flutter.zip'}"

if %errorLevel% == 0 (
    echo ✓ Flutter SDK downloaded successfully
) else (
    echo ✗ Failed to download Flutter SDK
    echo Please check your internet connection
    pause
    exit /b 1
)

:: Extract Flutter SDK
echo Extracting Flutter SDK...
powershell -Command "& {Expand-Archive -Path 'flutter.zip' -DestinationPath 'C:\' -Force}"

if %errorLevel% == 0 (
    echo ✓ Flutter SDK extracted successfully
) else (
    echo ✗ Failed to extract Flutter SDK
    pause
    exit /b 1
)

:: Clean up zip file
del flutter.zip

:: Add Flutter to PATH
echo Adding Flutter to PATH...
setx PATH "%PATH%;C:\flutter\bin" /M

if %errorLevel% == 0 (
    echo ✓ Flutter added to PATH
) else (
    echo ✗ Failed to add Flutter to PATH
)

echo.
echo ========================================
echo Flutter Setup Complete!
echo ========================================
echo.
echo Please restart your Command Prompt or PowerShell
echo to access Flutter commands.
echo.
echo Next steps:
echo 1. Restart Command Prompt
echo 2. Run: flutter doctor
echo 3. Install Android Studio Flutter plugin
echo 4. Run: flutter create dailyfit
echo.
pause 