import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/app_state.dart';
import '../services/auto_update_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DailyFit'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              AutoUpdateService().forceUpdate();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Checking for updates...')),
              );
            },
          ),
        ],
      ),
      body: Consumer<AppState>(
        builder: (context, appState, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Welcome Section
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome to DailyFit!',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Track your fitness journey and stay motivated.',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Stats Grid
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.5,
                  children: [
                    _buildStatCard(
                      context,
                      'Workouts',
                      appState.workoutCount.toString(),
                      Icons.fitness_center,
                      Colors.blue,
                    ),
                    _buildStatCard(
                      context,
                      'Calories',
                      '${appState.caloriesBurned}',
                      Icons.local_fire_department,
                      Colors.orange,
                    ),
                    _buildStatCard(
                      context,
                      'Streak',
                      '${appState.streakDays} days',
                      Icons.local_fire_department,
                      Colors.red,
                    ),
                    _buildStatCard(
                      context,
                      'Auto-Update',
                      appState.isAutoUpdateEnabled ? 'ON' : 'OFF',
                      Icons.sync,
                      appState.isAutoUpdateEnabled ? Colors.green : Colors.grey,
                    ),
                  ],
                ),
                
                const SizedBox(height: 24),
                
                // Quick Actions
                Text(
                  'Quick Actions',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          appState.addWorkout();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Workout logged!')),
                          );
                        },
                        icon: const Icon(Icons.add),
                        label: const Text('Log Workout'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          appState.toggleAutoUpdate();
                        },
                        icon: Icon(
                          appState.isAutoUpdateEnabled 
                            ? Icons.sync 
                            : Icons.sync_disabled,
                        ),
                        label: Text(
                          appState.isAutoUpdateEnabled 
                            ? 'Disable Auto-Update' 
                            : 'Enable Auto-Update',
                        ),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                // Reset Progress Button
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Reset Progress'),
                          content: const Text(
                            'Are you sure you want to reset all your progress? This cannot be undone.',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                appState.resetProgress();
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Progress reset!')),
                                );
                              },
                              child: const Text('Reset'),
                            ),
                          ],
                        ),
                      );
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Reset Progress'),
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Auto-Update Status
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.sync,
                              color: appState.isAutoUpdateEnabled 
                                ? Colors.green 
                                : Colors.grey,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Auto-Update Status',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          appState.isAutoUpdateEnabled
                            ? 'Auto-updates are enabled. Your app will automatically check for updates and reload when changes are detected.'
                            : 'Auto-updates are disabled. You can enable them in the quick actions above.',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
  
  Widget _buildStatCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: color),
            const SizedBox(height: 8),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}