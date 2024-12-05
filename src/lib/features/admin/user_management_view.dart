import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../admin/admin_viewmodel.dart';
import '../../models/user.dart';
import '../../ui/widgets/loading_indicator.dart';
import '../../ui/widgets/error_display.dart';

class UserManagementView extends StackedView<AdminViewModel> {
  const UserManagementView({Key? key}) : super(key: key);

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
        title: const Text('User Management'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddUserDialog(context, viewModel),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Search users...',
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: viewModel.searchUsers,
                  ),
                ),
                const SizedBox(width: 16),
                DropdownButton<String>(
                  value: viewModel.selectedUserRole,
                  items: const [
                    DropdownMenuItem(value: 'all', child: Text('All Roles')),
                    DropdownMenuItem(value: 'student', child: Text('Students')),
                    DropdownMenuItem(value: 'teacher', child: Text('Teachers')),
                    DropdownMenuItem(value: 'parent', child: Text('Parents')),
                    DropdownMenuItem(value: 'admin', child: Text('Admins')),
                  ],
                  onChanged: viewModel.filterByRole,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: viewModel.filteredUsers.length,
              itemBuilder: (context, index) {
                final user = viewModel.filteredUsers[index];
                return UserListTile(
                  user: user,
                  onEdit: () => _showEditUserDialog(context, viewModel, user),
                  onDelete: () => _showDeleteConfirmation(context, viewModel, user),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showAddUserDialog(BuildContext context, AdminViewModel viewModel) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add User'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Email'),
                onChanged: viewModel.setNewUserEmail,
              ),
              const SizedBox(height: 16),
              DropdownButton<String>(
                value: viewModel.newUserRole,
                items: const [
                  DropdownMenuItem(value: 'student', child: Text('Student')),
                  DropdownMenuItem(value: 'teacher', child: Text('Teacher')),
                  DropdownMenuItem(value: 'parent', child: Text('Parent')),
                  DropdownMenuItem(value: 'admin', child: Text('Admin')),
                ],
                onChanged: viewModel.setNewUserRole,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              viewModel.addUser();
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _showEditUserDialog(BuildContext context, AdminViewModel viewModel, User user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit User'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Email: ${user.email}'),
              const SizedBox(height: 16),
              DropdownButton<String>(
                value: user.role,
                items: const [
                  DropdownMenuItem(value: 'student', child: Text('Student')),
                  DropdownMenuItem(value: 'teacher', child: Text('Teacher')),
                  DropdownMenuItem(value: 'parent', child: Text('Parent')),
                  DropdownMenuItem(value: 'admin', child: Text('Admin')),
                ],
                onChanged: (value) => viewModel.updateUserRole(user.id, value!),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              viewModel.updateUser(user);
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, AdminViewModel viewModel, User user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete User'),
        content: Text('Are you sure you want to delete ${user.email}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              viewModel.deleteUser(user.id);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  AdminViewModel viewModelBuilder(BuildContext context) => AdminViewModel();

  @override
  void onViewModelReady(AdminViewModel viewModel) => viewModel.initialize();
}

class UserListTile extends StatelessWidget {
  final User user;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const UserListTile({
    Key? key,
    required this.user,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(user.email[0].toUpperCase()),
      ),
      title: Text(user.email),
      subtitle: Text('Role: ${user.role}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: onEdit,
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}