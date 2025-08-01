import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/app_state.dart';
import '../services/auto_update_service.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Consumer<AppState>(
        builder: (context, appState, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Header
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          child: const Icon(
                            Icons.person,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'DailyFit User',
                                style: Theme.of(context).textTheme.headlineSmall,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Fitness Enthusiast',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(
                                    Icons.local_fire_department,
                                    color: Colors.orange,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${appState.streakDays} day streak',
                                    style: Theme.of(context).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Statistics
                Text(
                  'Your Statistics',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        _buildStatRow('Total Workouts', appState.workoutCount.toString()),
                        const Divider(),
                        _buildStatRow('Calories Burned', '${appState.caloriesBurned}'),
                        const Divider(),
                        _buildStatRow('Current Streak', '${appState.streakDays} days'),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Settings
                Text(
                  'Settings',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                
                Card(
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.sync),
                        title: const Text('Auto-Update'),
                        subtitle: Text(
                          appState.isAutoUpdateEnabled 
                            ? 'Enabled - App will auto-update' 
                            : 'Disabled - Manual updates only',
                        ),
                        trailing: Switch(
                          value: appState.isAutoUpdateEnabled,
                          onChanged: (value) {
                            appState.toggleAutoUpdate();
                          },
                        ),
                      ),
                      const Divider(height: 1),
                      ListTile(
                        leading: const Icon(Icons.refresh),
                        title: const Text('Check for Updates'),
                        subtitle: const Text('Manually check for app updates'),
                        onTap: () {
                          AutoUpdateService().forceUpdate();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Checking for updates...')),
                          );
                        },
                      ),
                      const Divider(height: 1),
                      ListTile(
                        leading: const Icon(Icons.notifications),
                        title: const Text('Notifications'),
                        subtitle: const Text('Workout reminders and progress updates'),
                        trailing: Switch(
                          value: true,
                          onChanged: (value) {
                            // TODO: Implement notification settings
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Actions
                Text(
                  'Actions',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                
                Card(
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.refresh, color: Colors.orange),
                        title: const Text('Reset Progress'),
                        subtitle: const Text('Clear all workout data'),
                        onTap: () {
                          _showResetDialog(context, appState);
                        },
                      ),
                      const Divider(height: 1),
                      ListTile(
                        leading: const Icon(Icons.share, color: Colors.blue),
                        title: const Text('Share Progress'),
                        subtitle: const Text('Share your fitness journey'),
                        onTap: () {
                          _shareProgress(context, appState);
                        },
                      ),
                      const Divider(height: 1),
                      ListTile(
                        leading: const Icon(Icons.info, color: Colors.grey),
                        title: const Text('About DailyFit'),
                        subtitle: const Text('Version 1.0.0'),
                        onTap: () {
                          _showAboutDialog(context);
                        },
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Auto-Update Info
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
                              'Auto-Update Information',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'When enabled, DailyFit will automatically check for updates and reload the app when changes are detected. This ensures you always have the latest features and improvements.',
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
  
  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
  
  void _showResetDialog(BuildContext context, AppState appState) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset Progress'),
        content: const Text(
          'Are you sure you want to reset all your progress? This will clear your workout count, calories burned, and streak. This action cannot be undone.',
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
                const SnackBar(
                  content: Text('Progress has been reset!'),
                  backgroundColor: Colors.orange,
                ),
              );
            },
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }
  
  void _shareProgress(BuildContext context, AppState appState) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Shared: ${appState.workoutCount} workouts, ${appState.caloriesBurned} calories burned, ${appState.streakDays} day streak!',
        ),
        backgroundColor: Colors.green,
      ),
    );
  }
  
  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('About DailyFit'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('DailyFit v1.0.0'),
            SizedBox(height: 8),
            Text('A fitness tracking app with auto-update features.'),
            SizedBox(height: 8),
            Text('Features:'),
            Text('• Workout tracking'),
            Text('• Progress monitoring'),
            Text('• Auto-updates'),
            Text('• Streak counting'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}