import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:gyde_app/features/admin/analytics/analytics_viewmodel.dart';
import 'package:gyde_app/ui/common/app_colors.dart';
import 'package:gyde_app/ui/common/ui_helpers.dart';

class AnalyticsView extends StackedView<AnalyticsViewModel> {
  const AnalyticsView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    AnalyticsViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics Dashboard'),
        backgroundColor: kcPrimaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: viewModel.refreshData,
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
                  _buildOverviewCards(viewModel),
                  verticalSpaceMedium,
                  _buildPerformanceMetrics(viewModel),
                  verticalSpaceMedium,
                  _buildEngagementMetrics(viewModel),
                  verticalSpaceMedium,
                  _buildGradeLevelDistribution(viewModel),
                ],
              ),
            ),
    );
  }

  Widget _buildOverviewCards(AnalyticsViewModel viewModel) {
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      children: [
        _buildMetricCard(
          'Total Students',
          viewModel.totalStudents.toString(),
          Icons.school,
        ),
        _buildMetricCard(
          'Total Teachers',
          viewModel.totalTeachers.toString(),
          Icons.person,
        ),
        _buildMetricCard(
          'Active Courses',
          viewModel.activeCourses.toString(),
          Icons.book,
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
            Icon(icon, size: 40, color: kcPrimaryColor),
            verticalSpaceSmall,
            Text(
              title,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
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

  Widget _buildPerformanceMetrics(AnalyticsViewModel viewModel) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Performance Metrics',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            verticalSpaceMedium,
            _buildPerformanceChart(viewModel),
          ],
        ),
      ),
    );
  }

  Widget _buildEngagementMetrics(AnalyticsViewModel viewModel) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Engagement Metrics',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            verticalSpaceMedium,
            _buildEngagementChart(viewModel),
          ],
        ),
      ),
    );
  }

  Widget _buildGradeLevelDistribution(AnalyticsViewModel viewModel) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Grade Level Distribution',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            verticalSpaceMedium,
            _buildGradeDistributionChart(viewModel),
          ],
        ),
      ),
    );
  }

  Widget _buildPerformanceChart(AnalyticsViewModel viewModel) {
    // Placeholder for performance chart
    return Container(
      height: 200,
      color: Colors.grey[200],
      child: const Center(
        child: Text('Performance Chart'),
      ),
    );
  }

  Widget _buildEngagementChart(AnalyticsViewModel viewModel) {
    // Placeholder for engagement chart
    return Container(
      height: 200,
      color: Colors.grey[200],
      child: const Center(
        child: Text('Engagement Chart'),
      ),
    );
  }

  Widget _buildGradeDistributionChart(AnalyticsViewModel viewModel) {
    // Placeholder for grade distribution chart
    return Container(
      height: 200,
      color: Colors.grey[200],
      child: const Center(
        child: Text('Grade Distribution Chart'),
      ),
    );
  }

  @override
  AnalyticsViewModel viewModelBuilder(BuildContext context) =>
      AnalyticsViewModel();

  @override
  void onViewModelReady(AnalyticsViewModel viewModel) => viewModel.initialize();
}
