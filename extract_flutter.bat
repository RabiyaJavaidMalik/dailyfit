@echo off
echo ========================================
echo Extracting Flutter SDK
========================================
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
echo Step 1: Checking Flutter zip file...
echo.

:: Check if zip file exists
if exist "flutter_windows_3.32.8-stable.zip" (
    echo ✓ Found Flutter zip file
) else (
    echo ✗ Flutter zip file not found
    echo Please make sure flutter_windows_3.32.8-stable.zip is in this folder
    pause
    exit /b 1
)

echo.
echo Step 2: Extracting Flutter SDK...
echo.

:: Remove existing flutter folder if it exists
if exist "flutter" (
    echo Removing existing flutter folder...
    rmdir /s /q flutter
)

:: Extract Flutter
echo Extracting Flutter (this may take a few minutes)...
powershell -Command "& {Expand-Archive -Path 'flutter_windows_3.32.8-stable.zip' -DestinationPath '.' -Force}"

if %errorLevel% == 0 (
    echo ✓ Flutter extracted successfully
) else (
    echo ✗ Failed to extract Flutter
    pause
    exit /b 1
)

echo.
echo Step 3: Verifying Flutter installation...
echo.

:: Check if flutter.bat exists
if exist "flutter\bin\flutter.bat" (
    echo ✓ Flutter installation verified
) else (
    echo ✗ Flutter installation incomplete
    pause
    exit /b 1
)

echo.
echo Step 4: Setting up Flutter PATH...
echo.

:: Get current directory and set Flutter path
set "CURRENT_DIR=%CD%"
set "FLUTTER_PATH=%CURRENT_DIR%\flutter\bin"

echo Flutter path: %FLUTTER_PATH%

:: Add Flutter to PATH
setx PATH "%PATH%;%FLUTTER_PATH%" /M

if %errorLevel% == 0 (
    echo ✓ Flutter added to PATH
) else (
    echo ✗ Failed to add Flutter to PATH
    pause
    exit /b 1
)

echo.
echo Step 5: Testing Flutter installation...
echo.

:: Test Flutter
echo Testing Flutter command...
"%FLUTTER_PATH%\flutter.bat" --version

if %errorLevel% == 0 (
    echo ✓ Flutter is working!
) else (
    echo ✗ Flutter test failed
    pause
    exit /b 1
)

echo.
echo Step 6: Running Flutter doctor...
echo.

:: Run flutter doctor
"%FLUTTER_PATH%\flutter.bat" doctor

echo.
echo ========================================
echo Flutter Setup Complete!
========================================
echo.
echo Flutter has been extracted and set up successfully!
echo.
echo Next steps:
echo 1. Restart Command Prompt
echo 2. Run: flutter doctor
echo 3. Run: quick_dailyfit_setup.bat
echo.
pause 