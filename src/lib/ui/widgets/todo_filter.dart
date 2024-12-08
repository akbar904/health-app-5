import 'package:flutter/material.dart';
import 'package:gyde_app/ui/common/app_colors.dart';
import 'package:gyde_app/ui/common/text_themes.dart';

class TodoFilter extends StatelessWidget {
  final bool? selectedFilter;
  final ValueChanged<bool?> onFilterChanged;

  const TodoFilter({
    required this.selectedFilter,
    required this.onFilterChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FilterChip(
          label: const Text('All'),
          selected: selectedFilter == null,
          onSelected: (_) => onFilterChanged(null),
          labelStyle: labelMediumStyle.copyWith(
            color: selectedFilter == null ? Colors.white : kcMediumGrey,
          ),
          backgroundColor: Colors.transparent,
          selectedColor: kcPrimaryColor,
        ),
        const SizedBox(width: 8),
        FilterChip(
          label: const Text('Active'),
          selected: selectedFilter == false,
          onSelected: (_) => onFilterChanged(false),
          labelStyle: labelMediumStyle.copyWith(
            color: selectedFilter == false ? Colors.white : kcMediumGrey,
          ),
          backgroundColor: Colors.transparent,
          selectedColor: kcPrimaryColor,
        ),
        const SizedBox(width: 8),
        FilterChip(
          label: const Text('Completed'),
          selected: selectedFilter == true,
          onSelected: (_) => onFilterChanged(true),
          labelStyle: labelMediumStyle.copyWith(
            color: selectedFilter == true ? Colors.white : kcMediumGrey,
          ),
          backgroundColor: Colors.transparent,
          selectedColor: kcPrimaryColor,
        ),
      ],
    );
  }
}
