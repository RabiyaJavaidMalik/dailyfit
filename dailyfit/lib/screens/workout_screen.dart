import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/app_state.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({super.key});

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  final List<Map<String, dynamic>> _exercises = [
    {
      'name': 'Push-ups',
      'sets': 3,
      'reps': 10,
      'icon': Icons.fitness_center,
      'color': Colors.red,
    },
    {
      'name': 'Squats',
      'sets': 3,
      'reps': 15,
      'icon': Icons.accessibility,
      'color': Colors.blue,
    },
    {
      'name': 'Plank',
      'sets': 3,
      'reps': 30,
      'icon': Icons.timer,
      'color': Colors.green,
      'unit': 'seconds',
    },
    {
      'name': 'Burpees',
      'sets': 3,
      'reps': 8,
      'icon': Icons.directions_run,
      'color': Colors.orange,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Consumer<AppState>(
        builder: (context, appState, child) {
          return Column(
            children: [
              // Workout Progress
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                color: Theme.of(context).colorScheme.primaryContainer,
                child: Column(
                  children: [
                    Text(
                      'Today\'s Progress',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildProgressItem(
                          'Workouts',
                          appState.workoutCount.toString(),
                          Icons.fitness_center,
                        ),
                        _buildProgressItem(
                          'Calories',
                          '${appState.caloriesBurned}',
                          Icons.local_fire_department,
                        ),
                        _buildProgressItem(
                          'Streak',
                          '${appState.streakDays} days',
                          Icons.local_fire_department,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              // Exercise List
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: _exercises.length,
                  itemBuilder: (context, index) {
                    final exercise = _exercises[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12.0),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: exercise['color'],
                          child: Icon(
                            exercise['icon'],
                            color: Colors.white,
                          ),
                        ),
                        title: Text(exercise['name']),
                        subtitle: Text(
                          '${exercise['sets']} sets × ${exercise['reps']} ${exercise['unit'] ?? 'reps'}',
                        ),
                        trailing: ElevatedButton(
                          onPressed: () {
                            _completeExercise(context, exercise, appState);
                          },
                          child: const Text('Complete'),
                        ),
                      ),
                    );
                  },
                ),
              ),
              
              // Complete Workout Button
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton.icon(
                  onPressed: () {
                    _completeWorkout(context, appState);
                  },
                  icon: const Icon(Icons.check),
                  label: const Text('Complete Workout'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16.0),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
  
  Widget _buildProgressItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 24),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
  
  void _completeExercise(BuildContext context, Map<String, dynamic> exercise, AppState appState) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Complete ${exercise['name']}'),
        content: Text(
          'Did you complete ${exercise['sets']} sets of ${exercise['reps']} ${exercise['unit'] ?? 'reps'}?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${exercise['name']} completed!'),
                  backgroundColor: exercise['color'],
                ),
              );
            },
            child: const Text('Complete'),
          ),
        ],
      ),
    );
  }
  
  void _completeWorkout(BuildContext context, AppState appState) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Complete Workout'),
        content: const Text(
          'Great job! This will log your workout and update your progress.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              appState.addWorkout();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Workout completed! Progress updated.'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Complete Workout'),
          ),
        ],
      ),
    );
  }
}