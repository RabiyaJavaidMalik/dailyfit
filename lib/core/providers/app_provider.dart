import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constants.dart';

class AppProvider extends ChangeNotifier {
  // User data
  String? _userId;
  String? _userName;
  String? _userEmail;
  
  // App settings
  bool _isFirstLaunch = true;
  ThemeMode _themeMode = ThemeMode.system;
  String _language = 'en';
  
  // Fitness data
  int _dailySteps = 0;
  int _stepGoal = 10000;
  double _currentWeight = 0.0;
  double _targetWeight = 0.0;
  int _workoutsThisWeek = 0;
  int _weeklyWorkoutGoal = 3;
  
  // Getters
  String? get userId => _userId;
  String? get userName => _userName;
  String? get userEmail => _userEmail;
  bool get isFirstLaunch => _isFirstLaunch;
  ThemeMode get themeMode => _themeMode;
  String get language => _language;
  int get dailySteps => _dailySteps;
  int get stepGoal => _stepGoal;
  double get currentWeight => _currentWeight;
  double get targetWeight => _targetWeight;
  int get workoutsThisWeek => _workoutsThisWeek;
  int get weeklyWorkoutGoal => _weeklyWorkoutGoal;
  
  // Initialize app data
  Future<void> initialize() async {
    await _loadUserData();
    await _loadAppSettings();
    await _loadFitnessData();
  }
  
  // Load user data from SharedPreferences
  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    _userId = prefs.getString(AppConstants.keyUserId);
    _userName = prefs.getString(AppConstants.keyUserName);
    _userEmail = prefs.getString(AppConstants.keyUserEmail);
    notifyListeners();
  }
  
  // Load app settings from SharedPreferences
  Future<void> _loadAppSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _isFirstLaunch = prefs.getBool(AppConstants.keyIsFirstLaunch) ?? true;
    final themeModeIndex = prefs.getInt(AppConstants.keyThemeMode) ?? 0;
    _themeMode = ThemeMode.values[themeModeIndex];
    _language = prefs.getString(AppConstants.keyLanguage) ?? 'en';
    notifyListeners();
  }
  
  // Load fitness data from SharedPreferences
  Future<void> _loadFitnessData() async {
    final prefs = await SharedPreferences.getInstance();
    _dailySteps = prefs.getInt('daily_steps') ?? 0;
    _stepGoal = prefs.getInt('step_goal') ?? 10000;
    _currentWeight = prefs.getDouble('current_weight') ?? 0.0;
    _targetWeight = prefs.getDouble('target_weight') ?? 0.0;
    _workoutsThisWeek = prefs.getInt('workouts_this_week') ?? 0;
    _weeklyWorkoutGoal = prefs.getInt('weekly_workout_goal') ?? 3;
    notifyListeners();
  }
  
  // Update user data
  Future<void> updateUserData({
    String? userId,
    String? userName,
    String? userEmail,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    
    if (userId != null) {
      _userId = userId;
      await prefs.setString(AppConstants.keyUserId, userId);
    }
    
    if (userName != null) {
      _userName = userName;
      await prefs.setString(AppConstants.keyUserName, userName);
    }
    
    if (userEmail != null) {
      _userEmail = userEmail;
      await prefs.setString(AppConstants.keyUserEmail, userEmail);
    }
    
    notifyListeners();
  }
  
  // Update app settings
  Future<void> updateAppSettings({
    bool? isFirstLaunch,
    ThemeMode? themeMode,
    String? language,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    
    if (isFirstLaunch != null) {
      _isFirstLaunch = isFirstLaunch;
      await prefs.setBool(AppConstants.keyIsFirstLaunch, isFirstLaunch);
    }
    
    if (themeMode != null) {
      _themeMode = themeMode;
      await prefs.setInt(AppConstants.keyThemeMode, themeMode.index);
    }
    
    if (language != null) {
      _language = language;
      await prefs.setString(AppConstants.keyLanguage, language);
    }
    
    notifyListeners();
  }
  
  // Update fitness data
  Future<void> updateFitnessData({
    int? dailySteps,
    int? stepGoal,
    double? currentWeight,
    double? targetWeight,
    int? workoutsThisWeek,
    int? weeklyWorkoutGoal,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    
    if (dailySteps != null) {
      _dailySteps = dailySteps;
      await prefs.setInt('daily_steps', dailySteps);
    }
    
    if (stepGoal != null) {
      _stepGoal = stepGoal;
      await prefs.setInt('step_goal', stepGoal);
    }
    
    if (currentWeight != null) {
      _currentWeight = currentWeight;
      await prefs.setDouble('current_weight', currentWeight);
    }
    
    if (targetWeight != null) {
      _targetWeight = targetWeight;
      await prefs.setDouble('target_weight', targetWeight);
    }
    
    if (workoutsThisWeek != null) {
      _workoutsThisWeek = workoutsThisWeek;
      await prefs.setInt('workouts_this_week', workoutsThisWeek);
    }
    
    if (weeklyWorkoutGoal != null) {
      _weeklyWorkoutGoal = weeklyWorkoutGoal;
      await prefs.setInt('weekly_workout_goal', weeklyWorkoutGoal);
    }
    
    notifyListeners();
  }
  
  // Reset app data
  Future<void> resetAppData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    
    _userId = null;
    _userName = null;
    _userEmail = null;
    _isFirstLaunch = true;
    _themeMode = ThemeMode.system;
    _language = 'en';
    _dailySteps = 0;
    _stepGoal = 10000;
    _currentWeight = 0.0;
    _targetWeight = 0.0;
    _workoutsThisWeek = 0;
    _weeklyWorkoutGoal = 3;
    
    notifyListeners();
  }
}