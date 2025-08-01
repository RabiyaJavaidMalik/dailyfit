import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'features/home/presentation/pages/home_page.dart';
import 'features/workout/presentation/pages/workout_page.dart';
import 'features/profile/presentation/pages/profile_page.dart';
import 'features/nutrition/presentation/pages/nutrition_page.dart';
import 'features/stats/presentation/pages/stats_page.dart';
import 'core/widgets/bottom_navigation.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const WorkoutPage(),
    const NutritionPage(),
    const StatsPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigation(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}