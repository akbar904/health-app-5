import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:gyde_app/features/dashboard/student/student_dashboard_viewmodel.dart';
import 'package:gyde_app/ui/common/app_colors.dart';
import 'package:gyde_app/ui/common/ui_helpers.dart';
import 'package:gyde_app/ui/widgets/loading_indicator.dart';

class StudentDashboardView extends StackedView<StudentDashboardViewModel> {
  const StudentDashboardView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    StudentDashboardViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Dashboard'),
        backgroundColor: kcPrimaryColor,
      ),
      body: viewModel.isBusy
          ? const Center(child: LoadingIndicator())
          : RefreshIndicator(
              onRefresh: () => viewModel.refreshDashboard('currentStudentId'),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildProgressOverview(viewModel),
                    verticalSpaceMedium,
                    _buildUpcomingAssignments(viewModel),
                    verticalSpaceMedium,
                    _buildEnrolledCourses(viewModel),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildProgressOverview(StudentDashboardViewModel viewModel) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Overall Progress',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            verticalSpaceMedium,
            LinearProgressIndicator(
              value: viewModel.overallProgress / 100,
              backgroundColor: Colors.grey[200],
              valueColor: const AlwaysStoppedAnimation<Color>(kcPrimaryColor),
            ),
            verticalSpaceSmall,
            Text(
              '${viewModel.overallProgress.toStringAsFixed(1)}% Complete',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUpcomingAssignments(StudentDashboardViewModel viewModel) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Upcoming Assignments',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            verticalSpaceMedium,
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: viewModel.upcomingAssignments.length,
              itemBuilder: (context, index) {
                final assignment = viewModel.upcomingAssignments[index];
                return ListTile(
                  title: Text(assignment.title),
                  subtitle: Text(
                    'Due: ${_formatDate(assignment.dueDate)}',
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // Navigate to assignment details
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEnrolledCourses(StudentDashboardViewModel viewModel) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'My Courses',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            verticalSpaceMedium,
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: viewModel.courses.length,
              itemBuilder: (context, index) {
                final course = viewModel.courses[index];
                return ListTile(
                  title: Text(course.title),
                  subtitle: Text(course.subject),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // Navigate to course details
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.month}/${date.day}/${date.year}';
  }

  @override
  StudentDashboardViewModel viewModelBuilder(BuildContext context) =>
      StudentDashboardViewModel();

  @override
  void onViewModelReady(StudentDashboardViewModel viewModel) =>
      viewModel.initialize('currentStudentId');
}
