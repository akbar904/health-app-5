import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import './dashboard_viewmodel.dart';
import '../../ui/widgets/student_progress_widget.dart';
import '../../ui/widgets/calendar_widget.dart';
import '../../ui/widgets/grade_chart_widget.dart';
import '../../ui/widgets/loading_indicator.dart';
import '../../ui/widgets/error_display.dart';

class StudentDashboardView extends StackedView<DashboardViewModel> {
  const StudentDashboardView({Key? key}) : super(key: key);

  @override
  Widget builder(BuildContext context, DashboardViewModel viewModel, Widget? child) {
    if (viewModel.isBusy) {
      return const LoadingIndicator();
    }

    if (viewModel.hasError) {
      return ErrorDisplay(error: viewModel.error.toString());
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Handle notifications
            },
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: viewModel.navigateToProfile,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWelcomeSection(viewModel),
            const SizedBox(height: 24),
            _buildQuickStats(viewModel),
            const SizedBox(height: 24),
            _buildUpcomingAssignments(viewModel),
            const SizedBox(height: 24),
            const StudentProgressWidget(),
            const SizedBox(height: 24),
            const GradeChartWidget(),
            const SizedBox(height: 24),
            const CalendarWidget(),
          ],
        ),
      ),
      drawer: _buildStudentDrawer(viewModel),
    );
  }

  Widget _buildWelcomeSection(DashboardViewModel viewModel) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome back, ${viewModel.currentUser?.name ?? "Student"}!',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Current Semester: ${viewModel.dashboardData['currentSemester'] ?? "Spring 2024"}',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickStats(DashboardViewModel viewModel) {
    final data = viewModel.dashboardData;
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      children: [
        _buildStatCard('Enrolled Courses', '${data['enrolledCourses'] ?? 0}'),
        _buildStatCard('Average Grade', '${data['averageGrade'] ?? 0}%'),
        _buildStatCard('Completed Assignments', '${data['completedAssignments'] ?? 0}'),
        _buildStatCard('Attendance Rate', '${data['attendanceRate'] ?? 0}%'),
      ],
    );
  }

  Widget _buildStatCard(String title, String value) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUpcomingAssignments(DashboardViewModel viewModel) {
    final assignments = viewModel.dashboardData['upcomingDeadlines'] ?? [];
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Upcoming Assignments',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: assignments.length,
            itemBuilder: (context, index) {
              final assignment = assignments[index];
              return ListTile(
                title: Text(assignment['title']),
                subtitle: Text('Due: ${assignment['dueDate']}'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  // Navigate to assignment details
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStudentDrawer(DashboardViewModel viewModel) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.blue),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 30),
                ),
                const SizedBox(height: 8),
                Text(
                  viewModel.currentUser?.name ?? "Student",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.book),
            title: const Text('My Courses'),
            onTap: viewModel.navigateToCourses,
          ),
          ListTile(
            leading: const Icon(Icons.assignment),
            title: const Text('Assignments'),
            onTap: viewModel.navigateToAssignments,
          ),
          ListTile(
            leading: const Icon(Icons.calendar_today),
            title: const Text('Schedule'),
            onTap: () {
              // Navigate to schedule
            },
          ),
          ListTile(
            leading: const Icon(Icons.grade),
            title: const Text('Grades'),
            onTap: () {
              // Navigate to grades
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: viewModel.logout,
          ),
        ],
      ),
    );
  }

  @override
  DashboardViewModel viewModelBuilder(BuildContext context) => DashboardViewModel();

  @override
  void onViewModelReady(DashboardViewModel viewModel) => viewModel.initialize();
}