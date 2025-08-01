# DailyFit - Fitness Tracking Application

A Flutter-based fitness tracking application with Android support.

## Configuration Guide

### 1. Flutter Configuration

The main Flutter configuration is in `pubspec.yaml`:

```yaml
name: dailyfit
description: A fitness tracking application
version: 1.0.0+1

environment:
  sdk: '>=3.0.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.2
  sqflite: ^2.3.0
  path: ^1.8.3
  provider: ^6.1.1
  image_picker: ^1.0.7
```

### 2. Android Configuration

#### Build Configuration (`app/build.gradle.kts`)
- **Application ID**: `com.example.dailyfit`
- **Min SDK**: 21
- **Target SDK**: 34
- **Compile SDK**: 34

#### Permissions (AndroidManifest.xml)
- Internet access
- Camera access
- Storage access
- Network state

### 3. Environment Configuration

Create environment-specific files:

#### Development (`.env`)
```
FLUTTER_ENV=development
DEBUG_MODE=true
API_BASE_URL=http://localhost:3000
```

#### Production (`.env.production`)
```
FLUTTER_ENV=production
DEBUG_MODE=false
API_BASE_URL=https://api.dailyfit.com
```

### 4. Adding New Dependencies

#### Flutter Dependencies
Add to `pubspec.yaml`:
```yaml
dependencies:
  your_package: ^1.0.0
```

Then run:
```bash
flutter pub get
```

#### Android Dependencies
Add to `app/build.gradle.kts`:
```kotlin
dependencies {
    implementation("com.example:library:1.0.0")
}
```

### 5. Build Configurations

#### Debug Build
```bash
flutter build apk --debug
```

#### Release Build
```bash
flutter build apk --release
```

#### Profile Build
```bash
flutter build apk --profile
```

### 6. Code Quality Configuration

#### Analysis Options (`analysis_options.yaml`)
- Enforces Flutter linting rules
- Excludes generated files
- Configures analyzer settings

### 7. Version Management

#### Version Catalog (`gradle/libs.versions.toml`)
Centralized dependency version management:
```toml
[versions]
agp = "8.2.0"
kotlin = "1.9.0"
compose = "2024.01.00"
```

## Setup Instructions

1. **Install Flutter SDK**
2. **Install Android Studio**
3. **Configure Android SDK**
4. **Run setup scripts**:
   ```bash
   ./setup_flutter.bat
   ./setup_android_env.bat
   ```

## Development Workflow

1. **Start development server**:
   ```bash
   flutter run
   ```

2. **Run tests**:
   ```bash
   flutter test
   ```

3. **Build for release**:
   ```bash
   flutter build apk --release
   ```

## Configuration Files Summary

| File | Purpose |
|------|---------|
| `pubspec.yaml` | Flutter dependencies and project metadata |
| `app/build.gradle.kts` | Android app configuration |
| `gradle/libs.versions.toml` | Centralized version management |
| `AndroidManifest.xml` | Android permissions and app settings |
| `.env` | Environment variables |
| `analysis_options.yaml` | Code quality and linting rules |

## Troubleshooting

### Common Issues

1. **Gradle sync failed**: Check `gradle/libs.versions.toml` for version conflicts
2. **Build errors**: Verify Android SDK installation
3. **Permission errors**: Check `AndroidManifest.xml` permissions
4. **Dependency conflicts**: Update versions in `pubspec.yaml`

### Getting Help

- Check Flutter documentation: https://docs.flutter.dev
- Android Studio documentation: https://developer.android.com/studio
- Gradle documentation: https://gradle.org/docs