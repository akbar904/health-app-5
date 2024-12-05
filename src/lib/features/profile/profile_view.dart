import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import './profile_viewmodel.dart';
import '../../ui/widgets/loading_indicator.dart';
import '../../ui/widgets/error_display.dart';

class ProfileView extends StackedView<ProfileViewModel> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget builder(BuildContext context, ProfileViewModel viewModel, Widget? child) {
    if (viewModel.isBusy) {
      return const LoadingIndicator();
    }

    if (viewModel.hasError) {
      return ErrorDisplay(error: viewModel.error.toString());
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: viewModel.canUpdateProfile ? viewModel.updateProfile : null,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileHeader(viewModel),
            const SizedBox(height: 24),
            _buildPersonalInfo(viewModel),
            const SizedBox(height: 24),
            _buildSecuritySection(viewModel),
            const SizedBox(height: 24),
            _buildPreferences(viewModel),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(ProfileViewModel viewModel) {
    return Center(
      child: Column(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: viewModel.user?.photoUrl != null
                    ? NetworkImage(viewModel.user!.photoUrl!)
                    : null,
                child: viewModel.user?.photoUrl == null
                    ? const Icon(Icons.person, size: 50)
                    : null,
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.blue,
                  child: IconButton(
                    icon: const Icon(Icons.camera_alt, size: 18, color: Colors.white),
                    onPressed: () {
                      // Handle profile picture update
                    },
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            viewModel.user?.name ?? '',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            viewModel.user?.role ?? '',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalInfo(ProfileViewModel viewModel) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Personal Information',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
              onChanged: viewModel.setNewName,
              controller: TextEditingController(text: viewModel.user?.name),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              onChanged: viewModel.setNewEmail,
              controller: TextEditingController(text: viewModel.user?.email),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSecuritySection(ProfileViewModel viewModel) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Security',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Current Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
              onChanged: viewModel.setCurrentPassword,
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: 'New Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
              onChanged: viewModel.setNewPassword,
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Confirm New Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
              onChanged: viewModel.setConfirmPassword,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: viewModel.canChangePassword ? viewModel.changePassword : null,
              child: const Text('Change Password'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreferences(ProfileViewModel viewModel) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Preferences',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Email Notifications'),
              value: true, // Replace with actual value from viewModel
              onChanged: (value) {
                // Handle email notifications toggle
              },
            ),
            SwitchListTile(
              title: const Text('Push Notifications'),
              value: true, // Replace with actual value from viewModel
              onChanged: (value) {
                // Handle push notifications toggle
              },
            ),
            SwitchListTile(
              title: const Text('Dark Mode'),
              value: false, // Replace with actual value from viewModel
              onChanged: (value) {
                // Handle dark mode toggle
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  ProfileViewModel viewModelBuilder(BuildContext context) => ProfileViewModel();

  @override
  void onViewModelReady(ProfileViewModel viewModel) => viewModel.initialize();
}