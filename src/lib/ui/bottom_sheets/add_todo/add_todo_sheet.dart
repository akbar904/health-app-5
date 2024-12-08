import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:gyde_app/ui/bottom_sheets/add_todo/add_todo_sheet_model.dart';
import 'package:gyde_app/ui/common/app_colors.dart';
import 'package:gyde_app/ui/common/text_themes.dart';
import 'package:gyde_app/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AddTodoSheet extends StackedView<AddTodoSheetModel> {
  final Function(SheetResponse)? completer;
  final SheetRequest request;

  const AddTodoSheet({
    super.key,
    required this.completer,
    required this.request,
  });

  @override
  Widget builder(
    BuildContext context,
    AddTodoSheetModel viewModel,
    Widget? child,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Add New Todo',
            style: headlineSmallStyle,
          ),
          verticalSpaceMedium,
          TextField(
            decoration: const InputDecoration(
              labelText: 'Title',
              border: OutlineInputBorder(),
            ),
            onChanged: viewModel.setTitle,
          ),
          verticalSpaceSmall,
          TextField(
            decoration: const InputDecoration(
              labelText: 'Description',
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
            onChanged: viewModel.setDescription,
          ),
          const Gap(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () =>
                    completer?.call(SheetResponse(confirmed: false)),
                child: const Text('Cancel'),
              ),
              const Gap(8),
              ElevatedButton(
                onPressed: viewModel.canSave ? viewModel.saveTodo : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: kcPrimaryColor,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Save'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  AddTodoSheetModel viewModelBuilder(BuildContext context) =>
      AddTodoSheetModel();
}
