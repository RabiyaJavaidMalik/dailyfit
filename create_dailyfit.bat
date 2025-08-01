@echo off
echo ========================================
echo Creating DailyFit Project
echo ========================================
echo.

:: Check if Flutter is installed
flutter --version >nul 2>&1
if %errorLevel% == 0 (
    echo ✓ Flutter is available
) else (
    echo ✗ Flutter is not installed
    echo Please run setup_flutter.bat first
    pause
    exit /b 1
)

echo.
echo Creating DailyFit Flutter project...
flutter create dailyfit

if %errorLevel% == 0 (
    echo ✓ DailyFit project created successfully
) else (
    echo ✗ Failed to create project
    pause
    exit /b 1
)

echo.
echo Setting up project structure...
cd dailyfit

:: Create directories
mkdir lib\models
mkdir lib\screens
mkdir lib\widgets
mkdir lib\services
mkdir lib\utils
mkdir assets\images
mkdir assets\icons

echo ✓ Project structure created

echo.
echo ========================================
echo DailyFit Project Ready!
echo ========================================
echo.
echo Project created at: %CD%
echo.
echo Next steps:
echo 1. Open Android Studio
echo 2. Install Flutter plugin (if not already installed)
echo 3. Open the dailyfit project
echo 4. Run the app: flutter run
echo.
echo Project structure:
echo ├── lib/
echo │   ├── models/     (data models)
echo │   ├── screens/    (UI screens)
echo │   ├── widgets/    (reusable widgets)
echo │   ├── services/   (business logic)
echo │   └── utils/      (helper functions)
echo └── assets/
echo     ├── images/     (app images)
echo     └── icons/      (app icons)
echo.
pause 