import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../widgets/loading_indicator.dart';
import '../../widgets/error_handler.dart';
import '../../widgets/responsive_layout.dart';
import 'profile_viewmodel.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
      viewModelBuilder: () => ProfileViewModel(),
      onModelReady: (model) => model.initialize(),
      builder: (context, model, child) {
        if (model.isBusy) {
          return const LoadingIndicator();
        }

        if (model.hasError) {
          return ErrorHandler(error: model.error);
        }

        return ResponsiveLayout(
          mobileBody: _buildMobileLayout(context, model),
          tabletBody: _buildTabletLayout(context, model),
          desktopBody: _buildDesktopLayout(context, model),
        );
      },
    );
  }

  Widget _buildMobileLayout(BuildContext context, ProfileViewModel model) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => model.editProfile(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileHeader(context, model),
            const SizedBox(height: 16),
            _buildPersonalInfo(context, model),
            const SizedBox(height: 16),
            _buildPreferences(context, model),
            if (model.isParent) ...[
              const SizedBox(height: 16),
              _buildLinkedAccounts(context, model),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTabletLayout(BuildContext context, ProfileViewModel model) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => model.editProfile(),
          ),
        ],
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildProfileHeader(context, model),
                  const SizedBox(height: 16),
                  _buildPersonalInfo(context, model),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildPreferences(context, model),
                  if (model.isParent) ...[
                    const SizedBox(height: 16),
                    _buildLinkedAccounts(context, model),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context, ProfileViewModel model) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => model.editProfile(),
          ),
        ],
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  _buildProfileHeader(context, model),
                  const SizedBox(height: 24),
                  _buildPersonalInfo(context, model),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  _buildPreferences(context, model),
                  if (model.isParent) ...[
                    const SizedBox(height: 24),
                    _buildLinkedAccounts(context, model),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context, ProfileViewModel model) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: model.user?.avatarUrl != null
                  ? NetworkImage(model.user!.avatarUrl!)
                  : null,
              child: model.user?.avatarUrl == null
                  ? Text(
                      model.user?.name.substring(0, 1).toUpperCase() ?? '',
                      style: Theme.of(context).textTheme.headlineMedium,
                    )
                  : null,
            ),
            const SizedBox(height: 16),
            Text(
              model.user?.name ?? '',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              model.user?.email ?? '',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            Text(
              model.user?.role.toString().split('.').last ?? '',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPersonalInfo(BuildContext context, ProfileViewModel model) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Personal Information',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            _buildInfoRow('Phone', model.user?.phone ?? 'Not set'),
            _buildInfoRow('Address', model.user?.address ?? 'Not set'),
            _buildInfoRow('Grade Level', model.user?.gradeLevel ?? 'Not set'),
            _buildInfoRow('Join Date', model.user?.joinDate.toString() ?? 'Not set'),
          ],
        ),
      ),
    );
  }

  Widget _buildPreferences(BuildContext context, ProfileViewModel model) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Preferences',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Email Notifications'),
              value: model.preferences.emailNotifications,
              onChanged: (value) => model.updatePreference('emailNotifications', value),
            ),
            SwitchListTile(
              title: const Text('Push Notifications'),
              value: model.preferences.pushNotifications,
              onChanged: (value) => model.updatePreference('pushNotifications', value),
            ),
            SwitchListTile(
              title: const Text('Dark Mode'),
              value: model.preferences.darkMode,
              onChanged: (value) => model.updatePreference('darkMode', value),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLinkedAccounts(BuildContext context, ProfileViewModel model) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Linked Student Accounts',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: model.linkedAccounts.length,
              itemBuilder: (context, index) {
                final account = model.linkedAccounts[index];
                return ListTile(
                  leading: CircleAvatar(
                    child: Text(account.name[0]),
                  ),
                  title: Text(account.name),
                  subtitle: Text(account.email),
                  trailing: IconButton(
                    icon: const Icon(Icons.remove_circle_outline),
                    onPressed: () => model.unlinkAccount(account.id),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => model.linkNewAccount(),
              icon: const Icon(Icons.add),
              label: const Text('Link New Account'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value),
        ],
      ),
    );
  }
}