import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../utils/constants.dart';

class DatabaseService {
  static Database? _database;
  
  static Future<void> initialize() async {
    if (_database == null) {
      _database = await _initDatabase();
    }
  }
  
  static Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), AppConstants.databaseName);
    
    return await openDatabase(
      path,
      version: AppConstants.databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }
  
  static Future<void> _onCreate(Database db, int version) async {
    // Users table
    await db.execute('''
      CREATE TABLE users (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        email TEXT,
        created_at INTEGER NOT NULL,
        updated_at INTEGER NOT NULL
      )
    ''');
    
    // Workouts table
    await db.execute('''
      CREATE TABLE workouts (
        id TEXT PRIMARY KEY,
        user_id TEXT NOT NULL,
        name TEXT NOT NULL,
        type TEXT NOT NULL,
        duration INTEGER,
        calories_burned INTEGER,
        date INTEGER NOT NULL,
        created_at INTEGER NOT NULL,
        FOREIGN KEY (user_id) REFERENCES users (id)
      )
    ''');
    
    // Exercises table
    await db.execute('''
      CREATE TABLE exercises (
        id TEXT PRIMARY KEY,
        workout_id TEXT NOT NULL,
        name TEXT NOT NULL,
        category TEXT NOT NULL,
        sets INTEGER,
        reps INTEGER,
        weight REAL,
        duration INTEGER,
        rest_time INTEGER,
        order_index INTEGER NOT NULL,
        FOREIGN KEY (workout_id) REFERENCES workouts (id)
      )
    ''');
    
    // Nutrition table
    await db.execute('''
      CREATE TABLE nutrition (
        id TEXT PRIMARY KEY,
        user_id TEXT NOT NULL,
        name TEXT NOT NULL,
        category TEXT NOT NULL,
        calories INTEGER,
        protein REAL,
        carbs REAL,
        fat REAL,
        fiber REAL,
        date INTEGER NOT NULL,
        created_at INTEGER NOT NULL,
        FOREIGN KEY (user_id) REFERENCES users (id)
      )
    ''');
    
    // Fitness data table
    await db.execute('''
      CREATE TABLE fitness_data (
        id TEXT PRIMARY KEY,
        user_id TEXT NOT NULL,
        date INTEGER NOT NULL,
        steps INTEGER DEFAULT 0,
        weight REAL,
        body_fat REAL,
        muscle_mass REAL,
        water_intake REAL,
        sleep_hours REAL,
        created_at INTEGER NOT NULL,
        FOREIGN KEY (user_id) REFERENCES users (id)
      )
    ''');
    
    // Goals table
    await db.execute('''
      CREATE TABLE goals (
        id TEXT PRIMARY KEY,
        user_id TEXT NOT NULL,
        type TEXT NOT NULL,
        target_value REAL NOT NULL,
        current_value REAL DEFAULT 0,
        unit TEXT NOT NULL,
        deadline INTEGER,
        is_completed INTEGER DEFAULT 0,
        created_at INTEGER NOT NULL,
        FOREIGN KEY (user_id) REFERENCES users (id)
      )
    ''');
  }
  
  static Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Handle database upgrades here
    if (oldVersion < 2) {
      // Add new columns or tables for version 2
    }
  }
  
  static Database get database {
    if (_database == null) {
      throw Exception('Database not initialized. Call DatabaseService.initialize() first.');
    }
    return _database!;
  }
  
  // User operations
  static Future<void> insertUser(Map<String, dynamic> user) async {
    await database.insert('users', user, conflictAlgorithm: ConflictAlgorithm.replace);
  }
  
  static Future<Map<String, dynamic>?> getUser(String userId) async {
    List<Map<String, dynamic>> results = await database.query(
      'users',
      where: 'id = ?',
      whereArgs: [userId],
    );
    return results.isNotEmpty ? results.first : null;
  }
  
  static Future<void> updateUser(Map<String, dynamic> user) async {
    await database.update(
      'users',
      user,
      where: 'id = ?',
      whereArgs: [user['id']],
    );
  }
  
  // Workout operations
  static Future<void> insertWorkout(Map<String, dynamic> workout) async {
    await database.insert('workouts', workout);
  }
  
  static Future<List<Map<String, dynamic>>> getWorkouts(String userId) async {
    return await database.query(
      'workouts',
      where: 'user_id = ?',
      whereArgs: [userId],
      orderBy: 'date DESC',
    );
  }
  
  static Future<Map<String, dynamic>?> getWorkout(String workoutId) async {
    List<Map<String, dynamic>> results = await database.query(
      'workouts',
      where: 'id = ?',
      whereArgs: [workoutId],
    );
    return results.isNotEmpty ? results.first : null;
  }
  
  // Exercise operations
  static Future<void> insertExercise(Map<String, dynamic> exercise) async {
    await database.insert('exercises', exercise);
  }
  
  static Future<List<Map<String, dynamic>>> getExercises(String workoutId) async {
    return await database.query(
      'exercises',
      where: 'workout_id = ?',
      whereArgs: [workoutId],
      orderBy: 'order_index ASC',
    );
  }
  
  // Nutrition operations
  static Future<void> insertNutrition(Map<String, dynamic> nutrition) async {
    await database.insert('nutrition', nutrition);
  }
  
  static Future<List<Map<String, dynamic>>> getNutrition(String userId, {int? date}) async {
    String whereClause = 'user_id = ?';
    List<dynamic> whereArgs = [userId];
    
    if (date != null) {
      whereClause += ' AND date = ?';
      whereArgs.add(date);
    }
    
    return await database.query(
      'nutrition',
      where: whereClause,
      whereArgs: whereArgs,
      orderBy: 'date DESC',
    );
  }
  
  // Fitness data operations
  static Future<void> insertFitnessData(Map<String, dynamic> fitnessData) async {
    await database.insert('fitness_data', fitnessData, conflictAlgorithm: ConflictAlgorithm.replace);
  }
  
  static Future<Map<String, dynamic>?> getFitnessData(String userId, int date) async {
    List<Map<String, dynamic>> results = await database.query(
      'fitness_data',
      where: 'user_id = ? AND date = ?',
      whereArgs: [userId, date],
    );
    return results.isNotEmpty ? results.first : null;
  }
  
  // Goals operations
  static Future<void> insertGoal(Map<String, dynamic> goal) async {
    await database.insert('goals', goal);
  }
  
  static Future<List<Map<String, dynamic>>> getGoals(String userId) async {
    return await database.query(
      'goals',
      where: 'user_id = ?',
      whereArgs: [userId],
      orderBy: 'created_at DESC',
    );
  }
  
  static Future<void> updateGoal(Map<String, dynamic> goal) async {
    await database.update(
      'goals',
      goal,
      where: 'id = ?',
      whereArgs: [goal['id']],
    );
  }
  
  // Close database
  static Future<void> close() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }
}