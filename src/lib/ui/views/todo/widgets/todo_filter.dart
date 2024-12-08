import 'package:flutter/material.dart';
import 'package:gyde_app/ui/common/app_colors.dart';
import 'package:gyde_app/utils/enums/todo_filter.dart';

class TodoFilter extends StatelessWidget {
  final TodoFilter selectedFilter;
  final Function(TodoFilter) onFilterSelected;

  const TodoFilter({
    required this.selectedFilter,
    required this.onFilterSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: TodoFilter.values.map((filter) {
          final isSelected = filter == selectedFilter;
          return InkWell(
            onTap: () => onFilterSelected(filter),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: isSelected ? kcPrimaryColor : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? kcPrimaryColor : kcMediumGrey,
                ),
              ),
              child: Text(
                filter.name,
                style: TextStyle(
                  color: isSelected ? Colors.white : kcMediumGrey,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
