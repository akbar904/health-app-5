import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:gyde_app/features/admin/user_management/user_management_viewmodel.dart';
import 'package:gyde_app/ui/common/app_colors.dart';
import 'package:gyde_app/ui/common/ui_helpers.dart';
import 'package:gyde_app/utils/enums/role_enum.dart';
import 'package:gyde_app/models/user.dart';

class UserManagementView extends StackedView<UserManagementViewModel> {
  const UserManagementView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    UserManagementViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Management'),
        backgroundColor: kcPrimaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: viewModel.showAddUserDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          _buildFilters(viewModel),
          Expanded(
            child: viewModel.isBusy
                ? const Center(child: CircularProgressIndicator())
                : _buildUserList(viewModel),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters(UserManagementViewModel viewModel) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Search Users',
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: viewModel.setSearchQuery,
              ),
            ),
            horizontalSpaceMedium,
            DropdownButton<UserRole>(
              value: viewModel.selectedRole,
              hint: const Text('Filter by Role'),
              items: UserRole.values
                  .map((role) => DropdownMenuItem(
                        value: role,
                        child: Text(role.toString().split('.').last),
                      ))
                  .toList(),
              onChanged: viewModel.setSelectedRole,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserList(UserManagementViewModel viewModel) {
    return ListView.builder(
      itemCount: viewModel.filteredUsers.length,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemBuilder: (context, index) {
        final user = viewModel.filteredUsers[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ExpansionTile(
            leading: _buildUserAvatar(user),
            title: Text(user.name),
            subtitle: Text(user.email),
            trailing: Text(
              user.role.toString().split('.').last,
              style: TextStyle(
                color: _getRoleColor(user.role),
                fontWeight: FontWeight.bold,
              ),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildUserDetails(user),
                    verticalSpaceMedium,
                    _buildActionButtons(viewModel, user),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildUserAvatar(User user) {
    return CircleAvatar(
      backgroundColor: _getRoleColor(user.role).withOpacity(0.2),
      child: Text(
        user.name.substring(0, 1).toUpperCase(),
        style: TextStyle(
          color: _getRoleColor(user.role),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildUserDetails(User user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('ID: ${user.id}'),
        verticalSpaceSmall,
        Text('Grade Level: ${user.gradeLevel.toString().split('.').last}'),
        if (user.role == UserRole.student) ...[
          verticalSpaceSmall,
          Text('Parent Email: ${user.parentEmail ?? 'Not linked'}'),
        ],
      ],
    );
  }

  Widget _buildActionButtons(UserManagementViewModel viewModel, User user) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () => viewModel.updateUser(user),
          child: const Text('Edit'),
        ),
        TextButton(
          onPressed: () => viewModel.deleteUser(user.id),
          child: const Text(
            'Delete',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }

  Color _getRoleColor(UserRole role) {
    switch (role) {
      case UserRole.admin:
        return Colors.red;
      case UserRole.teacher:
        return Colors.blue;
      case UserRole.student:
        return Colors.green;
      case UserRole.parent:
        return Colors.orange;
    }
  }

  @override
  UserManagementViewModel viewModelBuilder(BuildContext context) =>
      UserManagementViewModel();

  @override
  void onViewModelReady(UserManagementViewModel viewModel) =>
      viewModel.initialize();
}
