@echo off
echo ========================================
echo Setting up Flutter PATH
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
echo Step 1: Finding Flutter installation...
echo.

:: Check common Flutter locations
if exist "C:\flutter\bin\flutter.bat" (
    echo ✓ Found Flutter at C:\flutter
    set "FLUTTER_PATH=C:\flutter\bin"
) else if exist "C:\src\flutter\bin\flutter.bat" (
    echo ✓ Found Flutter at C:\src\flutter
    set "FLUTTER_PATH=C:\src\flutter\bin"
) else if exist "%USERPROFILE%\flutter\bin\flutter.bat" (
    echo ✓ Found Flutter at %USERPROFILE%\flutter
    set "FLUTTER_PATH=%USERPROFILE%\flutter\bin"
) else (
    echo ✗ Flutter not found in common locations
    echo.
    echo Please tell me where you downloaded Flutter:
    echo - C:\flutter
    echo - C:\src\flutter  
    echo - %USERPROFILE%\flutter
    echo - Or another location?
    echo.
    set /p FLUTTER_LOCATION="Enter Flutter path (e.g., C:\flutter): "
    set "FLUTTER_PATH=%FLUTTER_LOCATION%\bin"
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