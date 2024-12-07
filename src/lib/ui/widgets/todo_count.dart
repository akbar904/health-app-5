import 'package:flutter/material.dart';
import 'package:gyde_app/ui/common/app_colors.dart';
import 'package:gyde_app/ui/views/home/todo_viewmodel.dart';
import 'package:stacked/stacked.dart';

class TodoCount extends ViewModelWidget<TodoViewModel> {
  const TodoCount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, TodoViewModel viewModel) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildCountCard(
            'Total',
            viewModel.totalTodos.toString(),
            kcTodoColor,
          ),
          _buildCountCard(
            'Active',
            viewModel.activeTodos.toString(),
            kcPrimaryColor,
          ),
          _buildCountCard(
            'Completed',
            viewModel.completedTodos.toString(),
            kcCompletedColor,
          ),
        ],
      ),
    );
  }

  Widget _buildCountCard(String label, String count, Color color) {
    return Card(
      elevation: 2,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: kcMediumGrey,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              count,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
