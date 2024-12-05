import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../admin/admin_viewmodel.dart';
import '../../ui/widgets/loading_indicator.dart';
import '../../ui/widgets/error_display.dart';

class SystemConfigView extends StackedView<AdminViewModel> {
  const SystemConfigView({Key? key}) : super(key: key);

  @override
  Widget builder(BuildContext context, AdminViewModel viewModel, Widget? child) {
    if (viewModel.isBusy) {
      return const LoadingIndicator();
    }

    if (viewModel.hasError) {
      return ErrorDisplay(error: viewModel.error.toString());
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('System Configuration'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildGeneralSettings(viewModel),
            const SizedBox(height: 24),
            _buildSecuritySettings(viewModel),
            const SizedBox(height: 24),
            _buildNotificationSettings(viewModel),
            const SizedBox(height: 24),
            _buildAccessibilitySettings(viewModel),
          ],
        ),
      ),
    );
  }

  Widget _buildGeneralSettings(AdminViewModel viewModel) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'General Settings',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Enable Public Registration'),
              value: viewModel.systemConfig['enablePublicRegistration'] ?? false,
              onChanged: (value) => viewModel.updateSystemConfig(
                'enablePublicRegistration',
                value,
              ),
            ),
            SwitchListTile(
              title: const Text('Allow Parent Accounts'),
              value: viewModel.systemConfig['allowParentAccounts'] ?? true,
              onChanged: (value) => viewModel.updateSystemConfig(
                'allowParentAccounts',
                value,
              ),
            ),
            SwitchListTile(
              title: const Text('Enable Course Sharing'),
              value: viewModel.systemConfig['enableCourseSharing'] ?? true,
              onChanged: (value) => viewModel.updateSystemConfig(
                'enableCourseSharing',
                value,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSecuritySettings(AdminViewModel viewModel) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Security Settings',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              title: const Text('Minimum Password Length'),
              trailing: DropdownButton<int>(
                value: viewModel.systemConfig['minPasswordLength'] ?? 8,
                items: [6, 8, 10, 12].map((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text(value.toString()),
                  );
                }).toList(),
                onChanged: (value) => viewModel.updateSystemConfig(
                  'minPasswordLength',
                  value,
                ),
              ),
            ),
            SwitchListTile(
              title: const Text('Require Email Verification'),
              value: viewModel.systemConfig['requireEmailVerification'] ?? true,
              onChanged: (value) => viewModel.updateSystemConfig(
                'requireEmailVerification',
                value,
              ),
            ),
            SwitchListTile(
              title: const Text('Two-Factor Authentication'),
              value: viewModel.systemConfig['twoFactorAuth'] ?? false,
              onChanged: (value) => viewModel.updateSystemConfig(
                'twoFactorAuth',
                value,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationSettings(AdminViewModel viewModel) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Notification Settings',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Email Notifications'),
              value: viewModel.systemConfig['emailNotifications'] ?? true,
              onChanged: (value) => viewModel.updateSystemConfig(
                'emailNotifications',
                value,
              ),
            ),
            SwitchListTile(
              title: const Text('Push Notifications'),
              value: viewModel.systemConfig['pushNotifications'] ?? true,
              onChanged: (value) => viewModel.updateSystemConfig(
                'pushNotifications',
                value,
              ),
            ),
            SwitchListTile(
              title: const Text('Assignment Reminders'),
              value: viewModel.systemConfig['assignmentReminders'] ?? true,
              onChanged: (value) => viewModel.updateSystemConfig(
                'assignmentReminders',
                value,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccessibilitySettings(AdminViewModel viewModel) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Accessibility Settings',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('High Contrast Mode'),
              value: viewModel.systemConfig['highContrastMode'] ?? false,
              onChanged: (value) => viewModel.updateSystemConfig(
                'highContrastMode',
                value,
              ),
            ),
            SwitchListTile(
              title: const Text('Screen Reader Support'),
              value: viewModel.systemConfig['screenReaderSupport'] ?? true,
              onChanged: (value) => viewModel.updateSystemConfig(
                'screenReaderSupport',
                value,
              ),
            ),
            ListTile(
              title: const Text('Default Font Size'),
              trailing: DropdownButton<double>(
                value: viewModel.systemConfig['defaultFontSize'] ?? 1.0,
                items: [0.8, 1.0, 1.2, 1.4].map((double value) {
                  return DropdownMenuItem<double>(
                    value: value,
                    child: Text('${(value * 100).toInt()}%'),
                  );
                }).toList(),
                onChanged: (value) => viewModel.updateSystemConfig(
                  'defaultFontSize',
                  value,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  AdminViewModel viewModelBuilder(BuildContext context) => AdminViewModel();

  @override
  void onViewModelReady(AdminViewModel viewModel) => viewModel.initialize();
}