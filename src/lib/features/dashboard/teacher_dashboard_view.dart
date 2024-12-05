import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../widgets/dashboard/progress_chart.dart';
import '../../widgets/common/custom_appbar.dart';
import '../../widgets/common/navigation_drawer.dart';
import 'dashboard_viewmodel.dart';

class TeacherDashboardView extends ViewModelWidget<DashboardViewModel> {
  const TeacherDashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, DashboardViewModel viewModel) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Teacher Dashboard',
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
                  _buildClassOverview(context, viewModel),
                  const SizedBox(height: 24),
                  _buildPendingTasks(context, viewModel),
                  const SizedBox(height: 24),
                  _buildStudentPerformance(context, viewModel),
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
              'Here\'s your teaching overview',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClassOverview(BuildContext context, DashboardViewModel viewModel) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Class Overview',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: [
                ProgressChart(
                  progress: viewModel.userStats['classAttendance']?.toDouble() ?? 0,
                  title: 'Class Attendance',
                  color: Colors.blue,
                ),
                ProgressChart(
                  progress:
                      viewModel.userStats['assignmentCompletion']?.toDouble() ?? 0,
                  title: 'Assignment Completion',
                  color: Colors.green,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPendingTasks(BuildContext context, DashboardViewModel viewModel) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pending Tasks',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: viewModel.pendingTasks.length,
              itemBuilder: (context, index) {
                final task = viewModel.pendingTasks[index];
                return ListTile(
                  leading: Icon(_getTaskIcon(task.type)),
                  title: Text(task.title),
                  subtitle: Text(task.dueDate),
                  trailing: IconButton(
                    icon: const Icon(Icons.arrow_forward),
                    onPressed: () => viewModel.handleTask(task.id),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStudentPerformance(
      BuildContext context, DashboardViewModel viewModel) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Student Performance',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: viewModel.studentPerformance.length,
                itemBuilder: (context, index) {
                  final performance = viewModel.studentPerformance[index];
                  return SizedBox(
                    width: 160,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage:
                                  NetworkImage(performance.studentAvatar),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              performance.studentName,
                              style: Theme.of(context).textTheme.titleSmall,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Grade: ${performance.grade}',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getTaskIcon(String type) {
    switch (type) {
      case 'grading':
        return Icons.grade;
      case 'planning':
        return Icons.event;
      case 'meeting':
        return Icons.people;
      default:
        return Icons.task;
    }
  }
}

