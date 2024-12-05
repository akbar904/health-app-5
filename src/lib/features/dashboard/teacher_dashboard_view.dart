import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import './dashboard_viewmodel.dart';
import '../../ui/widgets/loading_indicator.dart';
import '../../ui/widgets/error_display.dart';
import '../../ui/widgets/student_progress_widget.dart';
import '../../ui/widgets/grade_chart_widget.dart';

class TeacherDashboardView extends StackedView<DashboardViewModel> {
  const TeacherDashboardView({Key? key}) : super(key: key);

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
        title: const Text('Teacher Dashboard'),
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
      drawer: _buildTeacherDrawer(viewModel),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWelcomeSection(viewModel),
            const SizedBox(height: 24),
            _buildQuickStats(viewModel),
            const SizedBox(height: 24),
            _buildUpcomingClasses(viewModel),
            const SizedBox(height: 24),
            _buildRecentSubmissions(viewModel),
            const SizedBox(height: 24),
            const StudentProgressWidget(),
            const SizedBox(height: 24),
            const GradeChartWidget(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Create new assignment/announcement
        },
        child: const Icon(Icons.add),
      ),
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
              'Welcome back, ${viewModel.currentUser?.name ?? "Teacher"}!',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Current Term: ${viewModel.dashboardData['currentTerm'] ?? "Spring 2024"}',
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
        _buildStatCard('Total Students', '${data['totalStudents'] ?? 0}'),
        _buildStatCard('Active Courses', '${data['activeCourses'] ?? 0}'),
        _buildStatCard('Pending Assignments', '${data['pendingAssignments'] ?? 0}'),
        _buildStatCard(
          'Class Average',
          '${data['averageClassGrade']?.toStringAsFixed(1) ?? 0}%',
        ),
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

  Widget _buildUpcomingClasses(DashboardViewModel viewModel) {
    final classes = viewModel.dashboardData['upcomingClasses'] ?? [];
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Upcoming Classes',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: classes.length,
            itemBuilder: (context, index) {
              final classInfo = classes[index];
              return ListTile(
                title: Text(classInfo['title']),
                subtitle: Text('Time: ${classInfo['time']}'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  // Navigate to class details
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRecentSubmissions(DashboardViewModel viewModel) {
    final submissions = viewModel.dashboardData['recentSubmissions'] ?? [];
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Recent Submissions',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: submissions.length,
            itemBuilder: (context, index) {
              final submission = submissions[index];
              return ListTile(
                title: Text('Student ID: ${submission['studentId']}'),
                subtitle: Text('Status: ${submission['status']}'),
                trailing: IconButton(
                  icon: const Icon(Icons.grade),
                  onPressed: () {
                    // Grade submission
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTeacherDrawer(DashboardViewModel viewModel) {
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
                  viewModel.currentUser?.name ?? "Teacher",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.class_),
            title: const Text('My Classes'),
            onTap: () {
              // Navigate to classes
            },
          ),
          ListTile(
            leading: const Icon(Icons.assignment),
            title: const Text('Assignments'),
            onTap: () {
              // Navigate to assignments
            },
          ),
          ListTile(
            leading: const Icon(Icons.analytics),
            title: const Text('Analytics'),
            onTap: () {
              // Navigate to analytics
            },
          ),
          ListTile(
            leading: const Icon(Icons.message),
            title: const Text('Messages'),
            onTap: () {
              // Navigate to messages
            },
          ),
          ListTile(
            leading: const Icon(Icons.calendar_today),
            title: const Text('Schedule'),
            onTap: () {
              // Navigate to schedule
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              // Navigate to settings
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