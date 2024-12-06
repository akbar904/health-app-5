import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:gyde_app/features/dashboard/teacher/teacher_dashboard_viewmodel.dart';
import 'package:gyde_app/ui/common/app_colors.dart';
import 'package:gyde_app/ui/common/ui_helpers.dart';
import 'package:gyde_app/ui/widgets/loading_indicator.dart';

class TeacherDashboardView extends StackedView<TeacherDashboardViewModel> {
  const TeacherDashboardView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    TeacherDashboardViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teacher Dashboard'),
        backgroundColor: kcPrimaryColor,
      ),
      body: viewModel.isBusy
          ? const Center(child: LoadingIndicator())
          : RefreshIndicator(
              onRefresh: () => viewModel.refreshDashboard('currentTeacherId'),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildOverviewCards(viewModel),
                    verticalSpaceMedium,
                    _buildUpcomingClasses(viewModel),
                    verticalSpaceMedium,
                    _buildAssignmentStatus(viewModel),
                    verticalSpaceMedium,
                    _buildStudentProgress(viewModel),
                  ],
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: viewModel.createNewAssignment,
        backgroundColor: kcPrimaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildOverviewCards(TeacherDashboardViewModel viewModel) {
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      children: [
        _buildMetricCard(
          'Total Students',
          viewModel.totalStudents.toString(),
          Icons.people,
        ),
        _buildMetricCard(
          'Active Courses',
          viewModel.totalCourses.toString(),
          Icons.book,
        ),
        _buildMetricCard(
          'Pending Assignments',
          viewModel.pendingAssignments.toString(),
          Icons.assignment,
        ),
      ],
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: kcPrimaryColor),
            verticalSpaceSmall,
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14),
            ),
            verticalSpaceTiny,
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUpcomingClasses(TeacherDashboardViewModel viewModel) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Upcoming Classes',
              style: TextStyle(
                fontSize: 18,
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
                  subtitle: Text('Grade ${course.gradeLevel.toString()}'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () => viewModel.navigateToCourse(course.id),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAssignmentStatus(TeacherDashboardViewModel viewModel) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Assignment Status',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            verticalSpaceMedium,
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: viewModel.assignments.length,
              itemBuilder: (context, index) {
                final assignment = viewModel.assignments[index];
                return ListTile(
                  title: Text(assignment.title),
                  subtitle: Text(
                    'Due: ${_formatDate(assignment.dueDate)}',
                  ),
                  trailing: Text(
                    assignment.isSubmitted ? 'Submitted' : 'Pending',
                    style: TextStyle(
                      color:
                          assignment.isSubmitted ? Colors.green : Colors.orange,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStudentProgress(TeacherDashboardViewModel viewModel) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Student Progress',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            verticalSpaceMedium,
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: viewModel.students.length,
              itemBuilder: (context, index) {
                final student = viewModel.students[index];
                return ListTile(
                  title: Text(student.name),
                  subtitle: LinearProgressIndicator(
                    value: 0.7, // Mock progress value
                    backgroundColor: Colors.grey[200],
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      kcPrimaryColor,
                    ),
                  ),
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
  TeacherDashboardViewModel viewModelBuilder(BuildContext context) =>
      TeacherDashboardViewModel();

  @override
  void onViewModelReady(TeacherDashboardViewModel viewModel) =>
      viewModel.initialize('currentTeacherId');
}
