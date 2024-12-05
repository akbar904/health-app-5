import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import './dashboard_viewmodel.dart';
import '../../ui/widgets/loading_indicator.dart';
import '../../ui/widgets/error_display.dart';
import '../../ui/widgets/student_progress_widget.dart';
import '../../ui/widgets/grade_chart_widget.dart';

class AdminDashboardView extends StackedView<DashboardViewModel> {
  const AdminDashboardView({Key? key}) : super(key: key);

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
        title: const Text('Admin Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to system settings
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
            _buildOverviewCards(viewModel),
            const SizedBox(height: 24),
            _buildPerformanceMetrics(viewModel),
            const SizedBox(height: 24),
            _buildUserManagement(viewModel),
          ],
        ),
      ),
      drawer: _buildAdminDrawer(viewModel),
    );
  }

  Widget _buildOverviewCards(DashboardViewModel viewModel) {
    final data = viewModel.dashboardData;
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      children: [
        _buildStatCard('Total Students', data['totalStudents']?.toString() ?? '0'),
        _buildStatCard('Total Teachers', data['totalTeachers']?.toString() ?? '0'),
        _buildStatCard('Active Courses', data['activeCourses']?.toString() ?? '0'),
        _buildStatCard('Total Assignments', data['totalAssignments']?.toString() ?? '0'),
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
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
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

  Widget _buildPerformanceMetrics(DashboardViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Performance Metrics',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        const GradeChartWidget(),
        const SizedBox(height: 16),
        const StudentProgressWidget(),
      ],
    );
  }

  Widget _buildUserManagement(DashboardViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'User Management',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Card(
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 5, // Show last 5 user activities
            itemBuilder: (context, index) {
              return const ListTile(
                title: Text('User Activity'),
                subtitle: Text('Activity details'),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAdminDrawer(DashboardViewModel viewModel) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Admin Panel',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.school),
            title: const Text('Manage Courses'),
            onTap: viewModel.navigateToCourses,
          ),
          ListTile(
            leading: const Icon(Icons.assignment),
            title: const Text('Manage Assignments'),
            onTap: viewModel.navigateToAssignments,
          ),
          ListTile(
            leading: const Icon(Icons.analytics),
            title: const Text('Analytics'),
            onTap: viewModel.navigateToAnalytics,
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