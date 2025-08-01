@echo off
echo ========================================
echo Fixing Phone Connection
========================================
echo.

echo Step 1: Checking ADB connection...
echo.

:: Check if ADB is working
C:\Users\Rabiya\AppData\Local\Android\Sdk\platform-tools\adb.exe devices

echo.
echo Step 2: Trying to connect to phone...
echo.

:: Try different connection methods
echo Trying WiFi connection...
C:\Users\Rabiya\AppData\Local\Android\Sdk\platform-tools\adb.exe connect 192.168.18.9:5555

echo.
echo Step 3: Checking devices again...
echo.

C:\Users\Rabiya\AppData\Local\Android\Sdk\platform-tools\adb.exe devices

echo.
echo Step 4: If no devices found, try these steps:
echo.
echo 1. Connect phone via USB cable
echo 2. Enable USB debugging in Developer options
echo 3. Accept any prompts on your phone
echo 4. Run this script again
echo.
echo Step 5: Installing APK if device found...
echo.

:: Try to install APK if device is connected
C:\Users\Rabiya\AppData\Local\Android\Sdk\platform-tools\adb.exe install dailyfit\build\app\outputs\flutter-apk\app-release.apk

echo.
echo ========================================
echo Connection Status
========================================
echo.

if %errorLevel% == 0 (
    echo ✓ APK installed successfully!
    echo DailyFit is now on your phone!
) else (
    echo ✗ Installation failed
    echo.
    echo Manual installation:
    echo 1. Copy APK from: dailyfit\build\app\outputs\flutter-apk\app-release.apk
    echo 2. Transfer to your phone
    echo 3. Install manually
)

echo.
pause 