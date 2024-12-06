import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:gyde_app/features/dashboard/admin/admin_dashboard_viewmodel.dart';
import 'package:gyde_app/ui/common/app_colors.dart';
import 'package:gyde_app/ui/common/ui_helpers.dart';
import 'package:gyde_app/ui/widgets/responsive_builder.dart';

class AdminDashboardView extends StackedView<AdminDashboardViewModel> {
  const AdminDashboardView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    AdminDashboardViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        backgroundColor: kcPrimaryColor,
      ),
      body: ResponsiveBuilder(
        mobile: (_) => _AdminDashboardMobileView(viewModel: viewModel),
        tablet: (_) => _AdminDashboardTabletView(viewModel: viewModel),
        desktop: (_) => _AdminDashboardDesktopView(viewModel: viewModel),
      ),
    );
  }

  @override
  AdminDashboardViewModel viewModelBuilder(BuildContext context) =>
      AdminDashboardViewModel();

  @override
  void onViewModelReady(AdminDashboardViewModel viewModel) =>
      viewModel.initialize();
}

class _AdminDashboardMobileView extends StatelessWidget {
  final AdminDashboardViewModel viewModel;

  const _AdminDashboardMobileView({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildOverviewCards(),
          verticalSpaceMedium,
          _buildRecentActivities(),
          verticalSpaceMedium,
          _buildQuickActions(),
        ],
      ),
    );
  }

  Widget _buildOverviewCards() {
    return Column(
      children: [
        _StatCard(
          title: 'Total Students',
          value: viewModel.totalStudents.toString(),
          icon: Icons.school,
        ),
        verticalSpaceSmall,
        _StatCard(
          title: 'Total Teachers',
          value: viewModel.totalTeachers.toString(),
          icon: Icons.person,
        ),
        verticalSpaceSmall,
        _StatCard(
          title: 'Active Courses',
          value: viewModel.activeCourses.toString(),
          icon: Icons.book,
        ),
      ],
    );
  }

  Widget _buildRecentActivities() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Recent Activities',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            verticalSpaceSmall,
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: viewModel.recentActivities.length,
              itemBuilder: (context, index) {
                final activity = viewModel.recentActivities[index];
                return ListTile(
                  title: Text(activity.title),
                  subtitle: Text(activity.description),
                  trailing: Text(activity.timeAgo),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Quick Actions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            verticalSpaceSmall,
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _ActionButton(
                  icon: Icons.person_add,
                  label: 'Add User',
                  onTap: viewModel.navigateToUserManagement,
                ),
                _ActionButton(
                  icon: Icons.assignment,
                  label: 'View Reports',
                  onTap: viewModel.navigateToAnalytics,
                ),
                _ActionButton(
                  icon: Icons.settings,
                  label: 'Settings',
                  onTap: viewModel.navigateToSettings,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AdminDashboardTabletView extends StatelessWidget {
  final AdminDashboardViewModel viewModel;

  const _AdminDashboardTabletView({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _StatCard(
                  title: 'Total Students',
                  value: viewModel.totalStudents.toString(),
                  icon: Icons.school,
                ),
              ),
              horizontalSpaceSmall,
              Expanded(
                child: _StatCard(
                  title: 'Total Teachers',
                  value: viewModel.totalTeachers.toString(),
                  icon: Icons.person,
                ),
              ),
              horizontalSpaceSmall,
              Expanded(
                child: _StatCard(
                  title: 'Active Courses',
                  value: viewModel.activeCourses.toString(),
                  icon: Icons.book,
                ),
              ),
            ],
          ),
          verticalSpaceMedium,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildRecentActivities()),
              horizontalSpaceSmall,
              Expanded(child: _buildQuickActions()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivities() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Recent Activities',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            verticalSpaceSmall,
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: viewModel.recentActivities.length,
              itemBuilder: (context, index) {
                final activity = viewModel.recentActivities[index];
                return ListTile(
                  title: Text(activity.title),
                  subtitle: Text(activity.description),
                  trailing: Text(activity.timeAgo),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Quick Actions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            verticalSpaceSmall,
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _ActionButton(
                  icon: Icons.person_add,
                  label: 'Add User',
                  onTap: viewModel.navigateToUserManagement,
                ),
                _ActionButton(
                  icon: Icons.assignment,
                  label: 'View Reports',
                  onTap: viewModel.navigateToAnalytics,
                ),
                _ActionButton(
                  icon: Icons.settings,
                  label: 'Settings',
                  onTap: viewModel.navigateToSettings,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AdminDashboardDesktopView extends StatelessWidget {
  final AdminDashboardViewModel viewModel;

  const _AdminDashboardDesktopView({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _StatCard(
                  title: 'Total Students',
                  value: viewModel.totalStudents.toString(),
                  icon: Icons.school,
                ),
              ),
              horizontalSpaceSmall,
              Expanded(
                child: _StatCard(
                  title: 'Total Teachers',
                  value: viewModel.totalTeachers.toString(),
                  icon: Icons.person,
                ),
              ),
              horizontalSpaceSmall,
              Expanded(
                child: _StatCard(
                  title: 'Active Courses',
                  value: viewModel.activeCourses.toString(),
                  icon: Icons.book,
                ),
              ),
            ],
          ),
          verticalSpaceMedium,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 2, child: _buildRecentActivities()),
              horizontalSpaceSmall,
              Expanded(child: _buildQuickActions()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivities() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Recent Activities',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            verticalSpaceSmall,
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: viewModel.recentActivities.length,
              itemBuilder: (context, index) {
                final activity = viewModel.recentActivities[index];
                return ListTile(
                  title: Text(activity.title),
                  subtitle: Text(activity.description),
                  trailing: Text(activity.timeAgo),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Quick Actions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            verticalSpaceSmall,
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _ActionButton(
                  icon: Icons.person_add,
                  label: 'Add User',
                  onTap: viewModel.navigateToUserManagement,
                ),
                _ActionButton(
                  icon: Icons.assignment,
                  label: 'View Reports',
                  onTap: viewModel.navigateToAnalytics,
                ),
                _ActionButton(
                  icon: Icons.settings,
                  label: 'Settings',
                  onTap: viewModel.navigateToSettings,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: kcPrimaryColor),
                horizontalSpaceSmall,
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            verticalSpaceSmall,
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
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: kcPrimaryColor,
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
    );
  }
}
