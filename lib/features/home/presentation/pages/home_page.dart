import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/providers/app_provider.dart';
import '../../../../core/utils/constants.dart';
import '../widgets/daily_summary_card.dart';
import '../widgets/quick_actions_card.dart';
import '../widgets/recent_workouts_card.dart';
import '../widgets/stats_overview_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            _buildAppBar(context),
            SliverPadding(
              padding: const EdgeInsets.all(AppConstants.paddingM),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  const DailySummaryCard(),
                  const SizedBox(height: AppConstants.paddingM),
                  const QuickActionsCard(),
                  const SizedBox(height: AppConstants.paddingM),
                  const StatsOverviewCard(),
                  const SizedBox(height: AppConstants.paddingM),
                  const RecentWorkoutsCard(),
                  const SizedBox(height: AppConstants.paddingL),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 120,
      floating: false,
      pinned: true,
      backgroundColor: AppConstants.primaryColor,
      flexibleSpace: FlexibleSpaceBar(
        title: Consumer<AppProvider>(
          builder: (context, appProvider, child) {
            final userName = appProvider.userName ?? 'User';
            return Text(
              'Hello, $userName!',
              style: const TextStyle(
                color: Colors.white,
                fontSize: AppConstants.fontSizeTitle,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppConstants.primaryColor,
                AppConstants.secondaryColor,
              ],
            ),
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_outlined, color: Colors.white),
          onPressed: () {
            // TODO: Navigate to notifications
          },
        ),
        IconButton(
          icon: const Icon(Icons.settings_outlined, color: Colors.white),
          onPressed: () {
            // TODO: Navigate to settings
          },
        ),
      ],
    );
  }
}