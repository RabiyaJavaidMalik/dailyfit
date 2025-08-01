@echo off
echo ========================================
echo Connecting Phone and Setting Up DailyFit
echo ========================================
echo.

echo Step 1: Connecting to your phone...
echo.

:: Kill and restart ADB server
echo Restarting ADB server...
adb kill-server
adb start-server

:: Connect to phone
echo Connecting to 192.168.18.9:5555...
adb connect 192.168.18.9:5555

:: Check connection
echo.
echo Checking device connection...
adb devices

echo.
echo Step 2: Checking Flutter devices...
flutter devices

echo.
echo Step 3: Setting up Flutter environment...
echo.

:: Check if Flutter is installed
flutter --version >nul 2>&1
if %errorLevel% == 0 (
    echo ✓ Flutter is installed
) else (
    echo ✗ Flutter is not installed
    echo Please run setup_flutter.bat first
    pause
    exit /b 1
)

echo.
echo Step 4: Creating DailyFit project...
echo.

:: Create DailyFit project
if not exist "dailyfit" (
    echo Creating DailyFit Flutter project...
    flutter create dailyfit
    
    if %errorLevel% == 0 (
        echo ✓ DailyFit project created successfully
    ) else (
        echo ✗ Failed to create project
        pause
        exit /b 1
    )
) else (
    echo ✓ DailyFit project already exists
)

echo.
echo Step 5: Setting up project structure...
cd dailyfit

:: Create directories
if not exist "lib\models" mkdir lib\models
if not exist "lib\screens" mkdir lib\screens
if not exist "lib\widgets" mkdir lib\widgets
if not exist "lib\services" mkdir lib\services
if not exist "lib\utils" mkdir lib\utils
if not exist "assets\images" mkdir assets\images
if not exist "assets\icons" mkdir assets\icons

echo ✓ Project structure created

echo.
echo Step 6: Installing dependencies...
echo.

:: Update pubspec.yaml with dependencies
echo Updating pubspec.yaml...
powershell -Command "& {(Get-Content pubspec.yaml) -replace 'dependencies:', 'dependencies:' + [Environment]::NewLine + '  sqflite: ^2.3.0' + [Environment]::NewLine + '  path: ^1.8.3' + [Environment]::NewLine + '  provider: ^6.1.1' + [Environment]::NewLine + '  shared_preferences: ^2.2.2' + [Environment]::NewLine + '  flutter_local_notifications: ^16.3.2' + [Environment]::NewLine + '  fl_chart: ^0.66.2' + [Environment]::NewLine + '  intl: ^0.19.0' + [Environment]::NewLine + '  image_picker: ^1.0.7' | Set-Content pubspec.yaml}"

:: Get dependencies
flutter pub get

echo.
echo ========================================
echo Setup Complete!
echo ========================================
echo.
echo Your phone should be connected and DailyFit project is ready!
echo.
echo Next steps:
echo 1. Run: flutter run
echo 2. The app will install and run on your phone
echo 3. Press 'r' for hot reload, 'R' for hot restart
echo.
echo Project location: %CD%
echo.
pause 