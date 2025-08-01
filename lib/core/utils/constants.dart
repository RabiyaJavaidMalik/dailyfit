import 'package:flutter/material.dart';

class AppConstants {
  // App Information
  static const String appName = 'DailyFit';
  static const String appVersion = '1.0.0';
  
  // Colors
  static const Color primaryColor = Color(0xFF2196F3);
  static const Color secondaryColor = Color(0xFF03DAC6);
  static const Color accentColor = Color(0xFFFF5722);
  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color surfaceColor = Color(0xFFFFFFFF);
  static const Color errorColor = Color(0xFFB00020);
  static const Color successColor = Color(0xFF4CAF50);
  static const Color warningColor = Color(0xFFFF9800);
  
  // Text Colors
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textHint = Color(0xFFBDBDBD);
  
  // Spacing
  static const double paddingXS = 4.0;
  static const double paddingS = 8.0;
  static const double paddingM = 16.0;
  static const double paddingL = 24.0;
  static const double paddingXL = 32.0;
  
  // Border Radius
  static const double radiusS = 4.0;
  static const double radiusM = 8.0;
  static const double radiusL = 12.0;
  static const double radiusXL = 16.0;
  
  // Font Sizes
  static const double fontSizeXS = 10.0;
  static const double fontSizeS = 12.0;
  static const double fontSizeM = 14.0;
  static const double fontSizeL = 16.0;
  static const double fontSizeXL = 18.0;
  static const double fontSizeXXL = 20.0;
  static const double fontSizeTitle = 24.0;
  static const double fontSizeHeadline = 28.0;
  
  // Animation Durations
  static const Duration animationFast = Duration(milliseconds: 200);
  static const Duration animationNormal = Duration(milliseconds: 300);
  static const Duration animationSlow = Duration(milliseconds: 500);
  
  // API Configuration
  static const String apiBaseUrl = 'https://api.dailyfit.com';
  static const int apiTimeout = 30000; // 30 seconds
  
  // Database Configuration
  static const String databaseName = 'dailyfit.db';
  static const int databaseVersion = 1;
  
  // SharedPreferences Keys
  static const String keyUserId = 'user_id';
  static const String keyUserName = 'user_name';
  static const String keyUserEmail = 'user_email';
  static const String keyIsFirstLaunch = 'is_first_launch';
  static const String keyThemeMode = 'theme_mode';
  static const String keyLanguage = 'language';
  
  // Notification IDs
  static const int notificationWorkoutReminder = 1;
  static const int notificationWaterReminder = 2;
  static const int notificationStepGoal = 3;
  
  // Workout Types
  static const List<String> workoutTypes = [
    'Cardio',
    'Strength',
    'Flexibility',
    'Balance',
    'Sports',
    'Yoga',
    'Pilates',
    'HIIT',
  ];
  
  // Exercise Categories
  static const List<String> exerciseCategories = [
    'Chest',
    'Back',
    'Shoulders',
    'Arms',
    'Legs',
    'Core',
    'Full Body',
    'Cardio',
  ];
  
  // Nutrition Categories
  static const List<String> nutritionCategories = [
    'Breakfast',
    'Lunch',
    'Dinner',
    'Snacks',
    'Supplements',
  ];
  
  // Goals
  static const List<String> fitnessGoals = [
    'Weight Loss',
    'Muscle Gain',
    'Endurance',
    'Flexibility',
    'Strength',
    'General Fitness',
  ];
}