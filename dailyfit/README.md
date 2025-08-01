# DailyFit - Auto-Update Fitness App

A Flutter fitness tracking app with automatic update features and hot reload capabilities.

## Features

### 🏃‍♂️ Fitness Tracking
- **Workout Logging**: Track your daily workouts and exercises
- **Progress Monitoring**: Monitor calories burned, workout count, and streaks
- **Exercise Library**: Pre-defined exercises with sets and reps
- **Statistics**: View your fitness progress over time

### 🔄 Auto-Update Features
- **Hot Reload**: Press 'r' to instantly reload code changes
- **Hot Restart**: Press 'R' to restart the app with new changes
- **Auto-Update Service**: Automatically checks for updates
- **Development Mode**: Enhanced auto-reload during development
- **Manual Update Check**: Force check for updates from the app

### 📱 Modern UI
- **Material Design 3**: Modern, beautiful interface
- **Responsive Design**: Works on all screen sizes
- **Navigation**: Bottom navigation with Home, Workout, and Profile screens
- **Real-time Updates**: UI updates automatically when data changes

## Quick Start

### Prerequisites
- Flutter SDK installed
- Android device connected via ADB
- Device IP: 192.168.18.9:5555

### Running the App

1. **Connect your device**:
   ```bash
   adb connect 192.168.18.9:5555
   ```

2. **Run with auto-update features**:
   ```bash
   ./run_with_auto_update.sh
   ```

3. **Or run from parent directory**:
   ```bash
   ./run_dailyfit_auto.sh
   ```

### Development Controls

When the app is running, you can use these controls:

- **'r'** - Hot reload (updates code changes instantly)
- **'R'** - Hot restart (full app restart)
- **'q'** - Quit the app

## App Structure

```
lib/
├── main.dart                 # App entry point with auto-update setup
├── models/
│   └── app_state.dart       # App state management
├── screens/
│   ├── home_screen.dart     # Main dashboard
│   ├── workout_screen.dart  # Exercise tracking
│   └── profile_screen.dart  # Settings and stats
├── services/
│   └── auto_update_service.dart  # Auto-update functionality
└── widgets/                 # Reusable UI components
```

## Auto-Update Features

### Development Mode
- **Hot Reload**: Automatically reloads when files change
- **Real-time Updates**: See changes instantly without rebuilding
- **State Preservation**: App state is maintained during reloads

### Production Mode
- **Update Checking**: Periodically checks for new versions
- **Automatic Updates**: Downloads and installs updates
- **Manual Updates**: Force check for updates from settings

### How It Works
1. **AutoUpdateService** manages update checking
2. **Development mode** uses Flutter's built-in hot reload
3. **Production mode** checks for updates every 30 minutes
4. **Manual updates** can be triggered from the app

## Features in Detail

### Home Screen
- **Welcome Section**: Personalized greeting
- **Statistics Grid**: Workouts, calories, streak, auto-update status
- **Quick Actions**: Log workout, toggle auto-update
- **Progress Reset**: Clear all data with confirmation

### Workout Screen
- **Exercise List**: Pre-defined exercises with sets and reps
- **Progress Tracking**: Real-time workout statistics
- **Exercise Completion**: Mark individual exercises as complete
- **Workout Completion**: Log entire workout session

### Profile Screen
- **User Profile**: Avatar and basic info
- **Statistics**: Detailed progress breakdown
- **Settings**: Auto-update toggle, notifications
- **Actions**: Reset progress, share progress, about info

## Dependencies

- **provider**: State management
- **shared_preferences**: Local data storage
- **http**: Network requests for updates
- **path_provider**: File system access
- **flutter_local_notifications**: Push notifications
- **fl_chart**: Data visualization
- **image_picker**: Photo selection
- **intl**: Date and time formatting

## Troubleshooting

### Auto-Update Not Working
1. Check if auto-update is enabled in Profile → Settings
2. Try manual update check from the refresh button
3. Ensure device has internet connection

### Hot Reload Issues
1. Make sure you're in development mode
2. Press 'r' for manual hot reload
3. Press 'R' for hot restart if needed

### Device Connection
1. Ensure device IP is correct (192.168.18.9:5555)
2. Run `adb devices` to verify connection
3. Restart ADB server if needed

## Future Enhancements

- [ ] Cloud sync for workout data
- [ ] Social features and sharing
- [ ] Advanced workout plans
- [ ] Nutrition tracking
- [ ] Wearable device integration
- [ ] Push notifications for workout reminders

## Version History

- **v1.0.0**: Initial release with auto-update features
  - Basic workout tracking
  - Auto-update service
  - Hot reload capabilities
  - Modern Material Design 3 UI
