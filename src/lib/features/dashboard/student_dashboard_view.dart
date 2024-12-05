import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../widgets/dashboard/progress_chart.dart';
import '../../widgets/common/custom_appbar.dart';
import '../../widgets/common/navigation_drawer.dart';
import '../dashboard/dashboard_viewmodel.dart';

class StudentDashboardView extends ViewModelWidget<DashboardViewModel> {
  const StudentDashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, DashboardViewModel viewModel) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Student Dashboard',
        showBackButton: false,
      ),
      drawer: const NavigationDrawer(),
      body: viewModel.isBusy
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildWelcomeSection(context, viewModel),
                  const SizedBox(height: 24),
                  _buildProgressSection(context, viewModel),
                  const SizedBox(height: 24),
                  _buildUpcomingAssignments(context, viewModel),
                  const SizedBox(height: 24),
                  _buildRecentActivities(context, viewModel),
                ],
              ),
            ),
    );
  }

  Widget _buildWelcomeSection(BuildContext context, DashboardViewModel viewModel) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome back, ${viewModel.currentUser?.name}!',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'Here\'s your learning progress',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressSection(BuildContext context, DashboardViewModel viewModel) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      children: [
        ProgressChart(
          progress: viewModel.userStats['overallProgress']?.toDouble() ?? 0,
          title: 'Overall Progress',
          color: Colors.blue,
        ),
        ProgressChart(
          progress: viewModel.userStats['attendanceRate']?.toDouble() ?? 0,
          title: 'Attendance Rate',
          color: Colors.green,
        ),
        ProgressChart(
          progress: viewModel.userStats['assignmentCompletion']?.toDouble() ?? 0,
          title: 'Assignments',
          color: Colors.orange,
        ),
        ProgressChart(
          progress: viewModel.userStats['quizPerformance']?.toDouble() ?? 0,
          title: 'Quiz Performance',
          color: Colors.purple,
        ),
      ],
    );
  }

  Widget _buildUpcomingAssignments(
      BuildContext context, DashboardViewModel viewModel) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Upcoming Assignments',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: viewModel.upcomingAssignments.length,
              itemBuilder: (context, index) {
                final assignment = viewModel.upcomingAssignments[index];
                return ListTile(
                  title: Text(assignment.title),
                  subtitle: Text(assignment.dueDate),
                  trailing: Text(assignment.course),
                  onTap: () => viewModel.navigateToAssignment(assignment.id),
                );
              },
            ),
          ],
        ),
      ),
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
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: viewModel.recentActivities.length,
              itemBuilder: (context, index) {
                final activity = viewModel.recentActivities[index];
                return ListTile(
                  leading: Icon(_getActivityIcon(activity.type)),
                  title: Text(activity.description),
                  subtitle: Text(activity.timestamp),
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
      case 'assignment':
        return Icons.assignment;
      case 'quiz':
        return Icons.quiz;
      case 'course':
        return Icons.school;
      default:
        return Icons.event_note;
    }
  }
}

