@echo off
echo ========================================
echo Setting up Local Flutter PATH
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
echo Step 1: Setting up Flutter from local directory...
echo.

:: Get current directory and set Flutter path
set "CURRENT_DIR=%CD%"
set "FLUTTER_PATH=%CURRENT_DIR%\flutter\bin"

echo Flutter path: %FLUTTER_PATH%

:: Check if flutter.bat exists
if exist "%FLUTTER_PATH%\flutter.bat" (
    echo ✓ Found flutter.bat
) else (
    echo ✗ flutter.bat not found at %FLUTTER_PATH%
    echo Please check if Flutter is properly extracted
    pause
    exit /b 1
)

echo.
echo Step 2: Adding Flutter to PATH...
echo.

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
echo Step 3: Testing Flutter installation...
echo.

:: Test Flutter
echo Testing Flutter command...
"%FLUTTER_PATH%\flutter.bat" --version

if %errorLevel% == 0 (
    echo ✓ Flutter is working!
) else (
    echo ✗ Flutter test failed
    echo Please check the Flutter installation
    pause
    exit /b 1
)

echo.
echo Step 4: Running Flutter doctor...
echo.

:: Run flutter doctor
"%FLUTTER_PATH%\flutter.bat" doctor

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
echo 3. Run: quick_dailyfit_setup.bat
echo.
pause 