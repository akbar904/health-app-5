import 'package:flutter/material.dart';
import 'package:gyde_app/ui/common/app_colors.dart';

class TodoStats extends StatelessWidget {
  final int totalTodos;
  final int completedTodos;

  const TodoStats({
    required this.totalTodos,
    required this.completedTodos,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: kcPrimaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStat('Total', totalTodos),
          _buildDivider(),
          _buildStat('Completed', completedTodos),
          _buildDivider(),
          _buildStat('Remaining', totalTodos - completedTodos),
        ],
      ),
    );
  }

  Widget _buildStat(String label, int value) {
    return Column(
      children: [
        Text(
          value.toString(),
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: kcPrimaryColor,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            color: kcMediumGrey,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 30,
      width: 1,
      color: kcLightGrey,
    );
  }
}
