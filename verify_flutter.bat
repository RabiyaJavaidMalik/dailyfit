@echo off
echo ========================================
echo Flutter Environment Verification
echo ========================================
echo.

echo Checking Flutter installation...
flutter --version >nul 2>&1
if %errorLevel% == 0 (
    echo ✓ Flutter is installed
    flutter --version
) else (
    echo ✗ Flutter is not installed or not in PATH
    echo Please run setup_flutter.bat as administrator
    pause
    exit /b 1
)

echo.
echo Running flutter doctor...
flutter doctor

echo.
echo ========================================
echo Flutter Setup Status
echo ========================================
echo.

:: Check if Flutter doctor shows any issues
flutter doctor --android-licenses >nul 2>&1
if %errorLevel% == 0 (
    echo ✓ Android licenses accepted
) else (
    echo ⚠ Android licenses may need to be accepted
    echo Run: flutter doctor --android-licenses
)

echo.
echo Next steps:
echo 1. Install Android Studio Flutter plugin
echo 2. Accept Android licenses: flutter doctor --android-licenses
echo 3. Create DailyFit project: flutter create dailyfit
echo 4. Open project in Android Studio
echo.
pause 