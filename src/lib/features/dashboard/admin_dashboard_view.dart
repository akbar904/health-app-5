import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../widgets/dashboard/progress_chart.dart';
import 'dashboard_viewmodel.dart';

class AdminDashboardView extends ViewModelWidget<DashboardViewModel> {
  const AdminDashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, DashboardViewModel viewModel) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: viewModel.refreshDashboard,
          ),
        ],
      ),
      body: viewModel.isBusy
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildOverviewSection(context, viewModel),
                  const SizedBox(height: 24),
                  _buildStatisticsGrid(context, viewModel),
                  const SizedBox(height: 24),
                  _buildRecentActivities(context, viewModel),
                ],
              ),
            ),
    );
  }

  Widget _buildOverviewSection(BuildContext context, DashboardViewModel viewModel) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'System Overview',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildOverviewItem(
                  context,
                  'Total Users',
                  viewModel.userStats['totalUsers']?.toString() ?? '0',
                  Icons.people,
                ),
                _buildOverviewItem(
                  context,
                  'Active Courses',
                  viewModel.userStats['activeCourses']?.toString() ?? '0',
                  Icons.school,
                ),
                _buildOverviewItem(
                  context,
                  'System Health',
                  '${viewModel.userStats['systemHealth']?.toString() ?? '100'}%',
                  Icons.health_and_safety,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewItem(
      BuildContext context, String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 32, color: Theme.of(context).primaryColor),
        const SizedBox(height: 8),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
        Text(value, style: Theme.of(context).textTheme.titleLarge),
      ],
    );
  }

  Widget _buildStatisticsGrid(BuildContext context, DashboardViewModel viewModel) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      children: [
        ProgressChart(
          progress: viewModel.userStats['studentProgress']?.toDouble() ?? 0.0,
          title: 'Student Progress',
          color: Colors.blue,
        ),
        ProgressChart(
          progress: viewModel.userStats['teacherEngagement']?.toDouble() ?? 0.0,
          title: 'Teacher Engagement',
          color: Colors.green,
        ),
        ProgressChart(
          progress: viewModel.userStats['resourceUsage']?.toDouble() ?? 0.0,
          title: 'Resource Usage',
          color: Colors.orange,
        ),
        ProgressChart(
          progress: viewModel.userStats['systemPerformance']?.toDouble() ?? 0.0,
          title: 'System Performance',
          color: Colors.purple,
        ),
      ],
    );
  }

  Widget _buildRecentActivities(
      BuildContext context, DashboardViewModel viewModel) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recent Activities',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: viewModel.recentActivities.length,
              itemBuilder: (context, index) {
                final activity = viewModel.recentActivities[index];
                return ListTile(
                  leading: Icon(_getActivityIcon(activity['type'])),
                  title: Text(activity['description']),
                  subtitle: Text(activity['timestamp']),
                  trailing: IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () {
                      // Handle activity actions
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  IconData _getActivityIcon(String type) {
    switch (type) {
      case 'user':
        return Icons.person;
      case 'course':
        return Icons.school;
      case 'system':
        return Icons.settings;
      default:
        return Icons.info;
    }
  }
}