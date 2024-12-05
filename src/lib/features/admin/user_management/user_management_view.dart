import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'user_management_viewmodel.dart';
import '../../../models/user.dart';

class UserManagementView extends ViewModelWidget<UserManagementViewModel> {
  const UserManagementView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, UserManagementViewModel viewModel) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Management'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddUserDialog(context, viewModel),
          ),
        ],
      ),
      body: viewModel.isBusy
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                _buildSearchBar(context, viewModel),
                _buildUserFilterChips(viewModel),
                Expanded(
                  child: _buildUserList(viewModel),
                ),
              ],
            ),
    );
  }

  Widget _buildSearchBar(BuildContext context, UserManagementViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        onChanged: viewModel.searchUsers,
        decoration: InputDecoration(
          hintText: 'Search users...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  Widget _buildUserFilterChips(UserManagementViewModel viewModel) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: UserRole.values.map((role) {
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Text(role.toString().split('.').last),
              selected: viewModel.selectedRoles.contains(role),
              onSelected: (selected) => viewModel.toggleRoleFilter(role),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildUserList(UserManagementViewModel viewModel) {
    return ListView.builder(
      itemCount: viewModel.filteredUsers.length,
      itemBuilder: (context, index) {
        final user = viewModel.filteredUsers[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            leading: CircleAvatar(
              child: Text(user.name[0].toUpperCase()),
            ),
            title: Text(user.name),
            subtitle: Text(user.email),
            trailing: PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: const Text('Edit'),
                  onTap: () => _showEditUserDialog(context, viewModel, user),
                ),
                PopupMenuItem(
                  child: const Text('Delete'),
                  onTap: () => _showDeleteConfirmation(context, viewModel, user),
                ),
                PopupMenuItem(
                  child: const Text('Reset Password'),
                  onTap: () => viewModel.resetUserPassword(user.id),
                ),
              ],
            ),
            onTap: () => _showUserDetails(context, viewModel, user),
          ),
        );
      },
    );
  }

  Future<void> _showAddUserDialog(
      BuildContext context, UserManagementViewModel viewModel) async {
    // Implementation for add user dialog
  }

  Future<void> _showEditUserDialog(
      BuildContext context, UserManagementViewModel viewModel, User user) async {
    // Implementation for edit user dialog
  }

  Future<void> _showDeleteConfirmation(
      BuildContext context, UserManagementViewModel viewModel, User user) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete User'),
        content: Text('Are you sure you want to delete ${user.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await viewModel.deleteUser(user.id);
    }
  }

  void _showUserDetails(
      BuildContext context, UserManagementViewModel viewModel, User user) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('User Details', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 16),
            Text('Name: ${user.name}'),
            Text('Email: ${user.email}'),
            Text('Role: ${user.role.toString().split('.').last}'),
            Text('Status: ${user.isActive ? 'Active' : 'Inactive'}'),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

