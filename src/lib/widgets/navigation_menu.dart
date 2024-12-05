import 'package:flutter/material.dart';
import '../models/user.dart';

class NavigationMenu extends StatelessWidget {
  final UserRole userRole;
  final String? userName;
  final VoidCallback onProfileTap;
  final VoidCallback onLogoutTap;

  const NavigationMenu({
    Key? key,
    required this.userRole,
    this.userName,
    required this.onProfileTap,
    required this.onLogoutTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(userName ?? 'User'),
            accountEmail: Text(userRole.toString().split('.').last),
            currentAccountPicture: const CircleAvatar(
              child: Icon(Icons.person),
            ),
          ),
          ...getMenuItemsByRole(userRole),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: onProfileTap,
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Logout'),
            onTap: onLogoutTap,
          ),
        ],
      ),
    );
  }

  List<Widget> getMenuItemsByRole(UserRole role) {
    switch (role) {
      case UserRole.admin:
        return _buildAdminMenuItems();
      case UserRole.teacher:
        return _buildTeacherMenuItems();
      case UserRole.student:
        return _buildStudentMenuItems();
      case UserRole.parent:
        return _buildParentMenuItems();
      default:
        return [];
    }
  }

  List<Widget> _buildAdminMenuItems() {
    return [
      ListTile(
        leading: const Icon(Icons.dashboard),
        title: const Text('Dashboard'),
        onTap: () {},
      ),
      ListTile(
        leading: const Icon(Icons.people),
        title: const Text('User Management'),
        onTap: () {},
      ),
      ListTile(
        leading: const Icon(Icons.settings),
        title: const Text('System Configuration'),
        onTap: () {},
      ),
      ListTile(
        leading: const Icon(Icons.analytics),
        title: const Text('Analytics'),
        onTap: () {},
      ),
    ];
  }

  List<Widget> _buildTeacherMenuItems() {
    return [
      ListTile(
        leading: const Icon(Icons.dashboard),
        title: const Text('Dashboard'),
        onTap: () {},
      ),
      ListTile(
        leading: const Icon(Icons.class_),
        title: const Text('Courses'),
        onTap: () {},
      ),
      ListTile(
        leading: const Icon(Icons.assignment),
        title: const Text('Assignments'),
        onTap: () {},
      ),
      ListTile(
        leading: const Icon(Icons.grade),
        title: const Text('Grades'),
        onTap: () {},
      ),
    ];
  }

  List<Widget> _buildStudentMenuItems() {
    return [
      ListTile(
        leading: const Icon(Icons.dashboard),
        title: const Text('Dashboard'),
        onTap: () {},
      ),
      ListTile(
        leading: const Icon(Icons.class_),
        title: const Text('My Courses'),
        onTap: () {},
      ),
      ListTile(
        leading: const Icon(Icons.assignment),
        title: const Text('Assignments'),
        onTap: () {},
      ),
      ListTile(
        leading: const Icon(Icons.grade),
        title: const Text('My Grades'),
        onTap: () {},
      ),
    ];
  }

  List<Widget> _buildParentMenuItems() {
    return [
      ListTile(
        leading: const Icon(Icons.dashboard),
        title: const Text('Dashboard'),
        onTap: () {},
      ),
      ListTile(
        leading: const Icon(Icons.child_care),
        title: const Text('Children'),
        onTap: () {},
      ),
      ListTile(
        leading: const Icon(Icons.grade),
        title: const Text('Progress Reports'),
        onTap: () {},
      ),
    ];
  }
}