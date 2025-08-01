@echo off
echo ========================================
echo Environment Status Check
========================================
echo.

echo Checking Flutter installation...
echo.

:: Check if flutter.bat exists locally
if exist "flutter\bin\flutter.bat" (
    echo ✓ Flutter found locally
    echo Testing local Flutter...
    flutter\bin\flutter.bat --version
) else (
    echo ✗ Flutter not found locally
)

echo.
echo Checking global Flutter...
echo.

:: Check if flutter is available globally
flutter --version >nul 2>&1
if %errorLevel% == 0 (
    echo ✓ Flutter is available globally
    flutter --version
) else (
    echo ✗ Flutter not available globally
    echo You may need to restart Command Prompt or add to PATH
)

echo.
echo Checking Android environment...
echo.

:: Check ADB
adb version >nul 2>&1
if %errorLevel% == 0 (
    echo ✓ ADB is available
    adb version
) else (
    echo ✗ ADB not available
)

echo.
echo Checking device connection...
echo.

:: Check if phone is connected
adb devices

echo.
echo ========================================
echo Environment Summary
========================================
echo.

if exist "flutter\bin\flutter.bat" (
    echo ✓ Flutter SDK: Available locally
) else (
    echo ✗ Flutter SDK: Not found
)

flutter --version >nul 2>&1
if %errorLevel% == 0 (
    echo ✓ Flutter PATH: Working
) else (
    echo ✗ Flutter PATH: Not working
)

adb version >nul 2>&1
if %errorLevel% == 0 (
    echo ✓ Android tools: Available
) else (
    echo ✗ Android tools: Not available
)

echo.
echo Next steps:
echo 1. If Flutter PATH not working: Restart Command Prompt
echo 2. If device not connected: Run adb connect 192.168.18.9:5555
echo 3. If everything OK: Run quick_dailyfit_setup.bat
echo.
pause 