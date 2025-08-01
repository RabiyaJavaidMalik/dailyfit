# DailyFit – Personal Fitness & Wellness Tracker

DailyFit is a comprehensive Android application designed to help users develop and maintain a healthy lifestyle by tracking daily fitness activities, water intake, sleep patterns, and meals.

## 🎯 Project Goals

- Help users track their wellness activities (workout, meals, water, sleep)
- Offer an easy-to-use interface with reminders and visual progress
- Encourage consistent, healthy habits via streaks and history
- Provide a personalized dashboard and optional data visualization

## 🧩 Core Features

### 1. User Dashboard
- Daily summary of all tracked data
- Visual progress indicators (progress bars)
- Quick action buttons for logging activities

### 2. Workout Tracker
- Select workout type (Running, Yoga, Gym, Custom)
- Log duration (minutes), calories burned (optional), notes
- Show total duration of the day

### 3. Water Intake Tracker
- Tap to add a glass (250ml)
- Show progress (e.g., 4/8 glasses)
- Optional daily goal customization

### 4. Meal Logger
- Log breakfast, lunch, dinner, snack
- Input food name, quantity, and calories (optional)
- Add photo of the meal (optional)

### 5. Sleep Tracker
- Input sleep and wake-up times
- Auto-calculate sleep duration
- Visualize hours of sleep

### 6. History / Calendar View
- View past 7–30 days of logs
- Tap any date to view or edit entries
- Summary of sleep, workout, and water progress

### 7. Reminders & Notifications
- Drink water reminder every X hours
- Meal reminders at specific times
- Sleep reminder at night

### 8. Settings & Preferences
- Dark mode toggle
- Set daily goals (water, sleep hours, workout time)
- Notification control (enable/disable)

## 🛠️ Tech Stack

| Layer | Technology |
|-------|------------|
| Language | Kotlin |
| IDE | Android Studio |
| UI Design | XML + Material Design |
| Local Storage | Room Database / SharedPreferences |
| Notifications | WorkManager / AlarmManager |
| Charts | MPAndroidChart (Optional) |
| Backup (Optional) | Firebase Firestore & Storage |
| Image Capture | Camera API or Gallery picker |
| PDF Export | PdfDocument API (Optional) |

## 📁 App Architecture

- **MVVM (Model-View-ViewModel)**
- Repository pattern for data handling
- LiveData + ViewModel for reactive UI updates

## 🔁 User Flow

1. **Splash Screen** → Onboarding (first-time)
2. **Dashboard** → Add Workout / Meal / Water / Sleep
3. **Add Entries** → Save to local DB
4. **Daily Summary** → View entries + visual indicators
5. **History View** → Review logs
6. **Settings** → Update preferences
7. **Reminders** → Trigger notifications via WorkManager

## 🚀 Getting Started

### Prerequisites

- Android Studio Arctic Fox or later
- Android SDK 24+ (API level 24)
- Kotlin 1.8+

### Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/dailyfit.git
```

2. Open the project in Android Studio

3. Sync Gradle files and build the project

4. Run the app on an emulator or physical device

### Building the Project

```bash
# Clean and build
./gradlew clean build

# Run tests
./gradlew test

# Build debug APK
./gradlew assembleDebug
```

## 📱 Screenshots

*Screenshots will be added here*

## 🏗️ Project Structure

```
app/src/main/java/com/dailyfit/
├── app/
│   └── DailyFitApplication.kt
├── data/
│   ├── DailyFitDatabase.kt
│   ├── dao/
│   │   ├── UserDao.kt
│   │   ├── WorkoutDao.kt
│   │   ├── WaterIntakeDao.kt
│   │   ├── MealDao.kt
│   │   └── SleepDao.kt
│   ├── entity/
│   │   ├── User.kt
│   │   ├── Workout.kt
│   │   ├── WaterIntake.kt
│   │   ├── Meal.kt
│   │   └── Sleep.kt
│   └── repository/
│       ├── UserRepository.kt
│       ├── WorkoutRepository.kt
│       ├── WaterIntakeRepository.kt
│       ├── MealRepository.kt
│       └── SleepRepository.kt
├── ui/
│   ├── dashboard/
│   │   ├── DashboardFragment.kt
│   │   ├── WorkoutDialogFragment.kt
│   │   ├── MealDialogFragment.kt
│   │   ├── SleepDialogFragment.kt
│   │   └── viewmodel/
│   │       ├── DashboardViewModel.kt
│   │       └── DashboardViewModelFactory.kt
│   ├── history/
│   │   └── HistoryFragment.kt
│   ├── settings/
│   │   └── SettingsFragment.kt
│   ├── main/
│   │   └── MainActivity.kt
│   ├── onboarding/
│   │   ├── OnboardingActivity.kt
│   │   └── OnboardingAdapter.kt
│   └── splash/
│       └── SplashActivity.kt
└── utils/
    ├── DateUtils.kt
    ├── NotificationUtils.kt
    └── workers/
        ├── WaterReminderWorker.kt
        ├── MealReminderWorker.kt
        ├── SleepReminderWorker.kt
        └── WorkoutReminderWorker.kt
```

## 🎨 UI/UX Features

- **Material Design 3** components
- **Dark/Light theme** support
- **Responsive layout** for different screen sizes
- **Smooth animations** and transitions
- **Accessibility** features

## 📊 Data Management

- **Room Database** for local storage
- **LiveData** for reactive UI updates
- **Repository pattern** for data abstraction
- **WorkManager** for background tasks and notifications

## 🔔 Notifications

The app includes several types of notifications:

- **Water Reminders**: Periodic reminders to drink water
- **Meal Reminders**: Scheduled reminders for breakfast, lunch, dinner
- **Sleep Reminders**: Nightly reminders to log sleep
- **Workout Reminders**: Daily workout reminders

## 🧪 Testing

The project includes:

- **Unit tests** for ViewModels and Repositories
- **Integration tests** for database operations
- **UI tests** for critical user flows

## 📈 Future Enhancements

### Planned Features

- [ ] **Charts and Analytics**: Weekly/monthly trend visualization
- [ ] **Export Functionality**: PDF reports and data export
- [ ] **Gamification**: Badges, streaks, and achievements
- [ ] **Cloud Backup**: Firebase integration for data sync
- [ ] **Social Features**: Share progress with friends
- [ ] **Advanced Analytics**: Machine learning insights
- [ ] **Wearable Integration**: Smartwatch support

### Optional Advanced Features

- [ ] **Charts (MPAndroidChart)** for weekly trends
- [ ] **Export weekly summary** as PDF
- [ ] **Gamification** (badges, streaks)
- [ ] **Backup to Firebase**
- [ ] **Fingerprint/PIN lock** for app
- [ ] **Widget support** for quick access

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👥 Target Users

- **Fitness enthusiasts** looking to track their progress
- **Busy professionals** wanting to maintain healthy habits
- **Students and beginners** starting a wellness journey
- **Anyone** who wants to build healthy daily habits

## 🆘 Support

If you encounter any issues or have questions:

1. Check the [Issues](https://github.com/yourusername/dailyfit/issues) page
2. Create a new issue with detailed information
3. Contact the development team

## 🙏 Acknowledgments

- Material Design team for the design system
- Android Jetpack team for the architecture components
- Room database team for the persistence library
- WorkManager team for the background task scheduling

---

**DailyFit** - Your Personal Fitness & Wellness Tracker 💪