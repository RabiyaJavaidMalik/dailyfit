@echo off
echo ========================================
echo Android Environment Verification
echo ========================================
echo.

echo Checking environment variables...
echo.

:: Check JAVA_HOME from system environment
for /f "tokens=2*" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v JAVA_HOME 2^>nul') do set "SYSTEM_JAVA_HOME=%%b"
if defined SYSTEM_JAVA_HOME (
    echo ✓ JAVA_HOME is set in system: %SYSTEM_JAVA_HOME%
) else (
    echo ✗ JAVA_HOME is not set in system environment
)

echo.

:: Check ANDROID_HOME from system environment
for /f "tokens=2*" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v ANDROID_HOME 2^>nul') do set "SYSTEM_ANDROID_HOME=%%b"
if defined SYSTEM_ANDROID_HOME (
    echo ✓ ANDROID_HOME is set in system: %SYSTEM_ANDROID_HOME%
) else (
    echo ✗ ANDROID_HOME is not set in system environment
)

echo.

:: Check current session JAVA_HOME
echo Current session JAVA_HOME:
if defined JAVA_HOME (
    echo ✓ %JAVA_HOME%
) else (
    echo ✗ Not available in current session
)

echo.

:: Check current session ANDROID_HOME
echo Current session ANDROID_HOME:
if defined ANDROID_HOME (
    echo ✓ %ANDROID_HOME%
) else (
    echo ✗ Not available in current session
)

echo.

:: Check Java installation
echo Checking Java installation...
java -version >nul 2>&1
if %errorLevel% == 0 (
    echo ✓ Java is available
    java -version
) else (
    echo ✗ Java is not available in PATH
)

echo.

:: Check Java compiler
echo Checking Java compiler...
javac -version >nul 2>&1
if %errorLevel% == 0 (
    echo ✓ Java compiler is available
    javac -version
) else (
    echo ✗ Java compiler is not available in PATH
)

echo.

:: Check ADB (Android Debug Bridge)
echo Checking ADB...
adb version >nul 2>&1
if %errorLevel% == 0 (
    echo ✓ ADB is available
    adb version
) else (
    echo ✗ ADB is not available in PATH
    echo This is normal if Android Studio is not installed yet
)

echo.
echo ========================================
echo Verification Complete
echo ========================================
echo.

if defined SYSTEM_JAVA_HOME (
    if defined SYSTEM_ANDROID_HOME (
        echo ✓ Environment variables are set correctly in system
        echo.
        echo ⚠ NOTE: You need to restart Command Prompt/PowerShell
        echo    to access these variables in your current session
    ) else (
        echo ⚠ JAVA_HOME is set but ANDROID_HOME is not set
        echo This is normal if Android Studio is not installed yet
    )
) else (
    echo ✗ JAVA_HOME is not set - run setup_android_env.bat as administrator
)

echo.
echo Next steps:
echo 1. Restart Command Prompt/PowerShell to access new environment variables
echo 2. Install Android Studio if not already installed
echo 3. Open Android Studio and let it download SDK components
echo 4. Run this verification script again after restart
echo.
pause 