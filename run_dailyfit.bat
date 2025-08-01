@echo off
echo ========================================
echo Running DailyFit on Your Phone
echo ========================================
echo.

:: Check if we're in the dailyfit directory
if not exist "pubspec.yaml" (
    echo Moving to dailyfit directory...
    cd dailyfit
)

:: Check if device is connected
echo Checking device connection...
adb devices | findstr "192.168.18.9" >nul
if %errorLevel% == 0 (
    echo ✓ Phone is connected
) else (
    echo ✗ Phone is not connected
    echo Trying to reconnect...
    adb connect 192.168.18.9:5555
    timeout /t 3 /nobreak >nul
)

:: Check Flutter devices
echo.
echo Checking Flutter devices...
flutter devices

echo.
echo Starting DailyFit app...
echo The app will install and run on your phone.
echo.
echo Hot reload: Press 'r' in terminal
echo Hot restart: Press 'R' in terminal
echo Stop app: Press 'q' in terminal
echo.

:: Run the app
flutter run

echo.
echo App stopped. You can run this script again to restart.
pause 