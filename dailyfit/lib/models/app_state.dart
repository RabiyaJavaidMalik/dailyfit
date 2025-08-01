import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppState extends ChangeNotifier {
  int _workoutCount = 0;
  int _caloriesBurned = 0;
  int _streakDays = 0;
  bool _isAutoUpdateEnabled = true;
  
  // Getters
  int get workoutCount => _workoutCount;
  int get caloriesBurned => _caloriesBurned;
  int get streakDays => _streakDays;
  bool get isAutoUpdateEnabled => _isAutoUpdateEnabled;
  
  AppState() {
    _loadData();
  }
  
  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    _workoutCount = prefs.getInt('workoutCount') ?? 0;
    _caloriesBurned = prefs.getInt('caloriesBurned') ?? 0;
    _streakDays = prefs.getInt('streakDays') ?? 0;
    _isAutoUpdateEnabled = prefs.getBool('isAutoUpdateEnabled') ?? true;
    notifyListeners();
  }
  
  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('workoutCount', _workoutCount);
    await prefs.setInt('caloriesBurned', _caloriesBurned);
    await prefs.setInt('streakDays', _streakDays);
    await prefs.setBool('isAutoUpdateEnabled', _isAutoUpdateEnabled);
  }
  
  void addWorkout() {
    _workoutCount++;
    _caloriesBurned += 150; // Average calories per workout
    _streakDays++;
    _saveData();
    notifyListeners();
  }
  
  void resetStreak() {
    _streakDays = 0;
    _saveData();
    notifyListeners();
  }
  
  void toggleAutoUpdate() {
    _isAutoUpdateEnabled = !_isAutoUpdateEnabled;
    _saveData();
    notifyListeners();
  }
  
  void resetProgress() {
    _workoutCount = 0;
    _caloriesBurned = 0;
    _streakDays = 0;
    _saveData();
    notifyListeners();
  }
}