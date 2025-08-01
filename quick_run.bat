@echo off
echo ========================================
echo Quick Run DailyFit
echo ========================================
echo.

:: Connect to phone quickly
echo Connecting to phone...
adb connect 192.168.18.9:5555

:: Go to dailyfit directory
if not exist "dailyfit" (
    echo ✗ DailyFit project not found
    echo Please run quick_dailyfit_setup.bat first
    pause
    exit /b 1
)

cd dailyfit

echo.
echo Starting DailyFit on your phone...
echo.
echo Hot reload: Press 'r'
echo Hot restart: Press 'R'  
echo Stop app: Press 'q'
echo.

flutter run

echo.
echo App stopped.
pause 