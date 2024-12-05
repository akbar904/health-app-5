import 'package:flutter/material.dart';
import '../../models/user.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildMenuItem(
                  context,
                  icon: Icons.dashboard,
                  title: 'Dashboard',
                  route: '/dashboard',
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.school,
                  title: 'Courses',
                  route: '/courses',
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.assignment,
                  title: 'Assignments',
                  route: '/assignments',
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.quiz,
                  title: 'Quizzes',
                  route: '/quizzes',
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.calendar_today,
                  title: 'Calendar',
                  route: '/calendar',
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.library_books,
                  title: 'Resources',
                  route: '/resources',
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.message,
                  title: 'Messages',
                  route: '/messages',
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.analytics,
                  title: 'Analytics',
                  route: '/analytics',
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.settings,
                  title: 'Settings',
                  route: '/settings',
                ),
                const Divider(),
                _buildMenuItem(
                  context,
                  icon: Icons.help,
                  title: 'Help & Support',
                  route: '/support',
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.logout,
                  title: 'Logout',
                  onTap: () {
                    // Implement logout logic
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return UserAccountsDrawerHeader(
      currentAccountPicture: const CircleAvatar(
        backgroundColor: Colors.white,
        child: Icon(Icons.person),
      ),
      accountName: const Text('User Name'),
      accountEmail: const Text('user@example.com'),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    String? route,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap ??
          () {
            Navigator.pop(context);
            if (route != null) {
              Navigator.pushNamed(context, route);
            }
          },
    );
  }
}