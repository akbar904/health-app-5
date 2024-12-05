import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../widgets/common/custom_appbar.dart';
import 'profile_viewmodel.dart';

class ProfileView extends ViewModelWidget<ProfileViewModel> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ProfileViewModel viewModel) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Profile',
      ),
      body: viewModel.isBusy
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProfileHeader(context, viewModel),
                  const SizedBox(height: 24),
                  _buildProfileDetails(context, viewModel),
                  const SizedBox(height: 24),
                  _buildPreferencesSection(context, viewModel),
                ],
              ),
            ),
    );
  }

  Widget _buildProfileHeader(BuildContext context, ProfileViewModel viewModel) {
    return Center(
      child: Column(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(viewModel.getAvatarUrl()),
              ),
              if (viewModel.canEditProfile())
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: IconButton(
                    icon: const Icon(Icons.camera_alt),
                    onPressed: () => viewModel.updateProfileImage('imagePath'),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            viewModel.user?.name ?? '',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          Text(
            viewModel.user?.email ?? '',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }

  Widget _buildProfileDetails(BuildContext context, ProfileViewModel viewModel) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Profile Information',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            _buildInfoRow('Role', viewModel.user?.role.toString() ?? ''),
            _buildInfoRow('Grade Level', viewModel.profileStats['gradeLevel'] ?? ''),
            _buildInfoRow('Joined Date', viewModel.profileStats['joinedDate'] ?? ''),
          ],
        ),
      ),
    );
  }

  Widget _buildPreferencesSection(BuildContext context, ProfileViewModel viewModel) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Preferences',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            _buildPreferenceSwitch(
              'Email Notifications',
              viewModel.profileStats['emailNotifications'] ?? false,
              (value) => viewModel.updateNotificationPreferences(
                  {'emailNotifications': value}),
            ),
            _buildPreferenceSwitch(
              'Push Notifications',
              viewModel.profileStats['pushNotifications'] ?? false,
              (value) => viewModel.updateNotificationPreferences(
                  {'pushNotifications': value}),
            ),
            _buildPreferenceSwitch(
              'Profile Privacy',
              viewModel.profileStats['profilePrivacy'] ?? false,
              (value) =>
                  viewModel.updatePrivacySettings({'profilePrivacy': value}),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value),
        ],
      ),
    );
  }

  Widget _buildPreferenceSwitch(
      String label, bool value, Function(bool) onChanged) {
    return SwitchListTile(
      title: Text(label),
      value: value,
      onChanged: onChanged,
    );
  }
}

