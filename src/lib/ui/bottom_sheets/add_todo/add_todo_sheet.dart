import 'package:flutter/material.dart';
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
    required this.completer,
    required this.request,
    Key? key,
  }) : super(key: key);

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
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Add New Todo',
            style: headlineSmallStyle,
          ),
          verticalSpaceMedium,
          TextField(
            controller: viewModel.titleController,
            decoration: const InputDecoration(
              labelText: 'Title',
              hintText: 'Enter todo title',
              border: OutlineInputBorder(),
            ),
          ),
          verticalSpaceSmall,
          TextField(
            controller: viewModel.descriptionController,
            decoration: const InputDecoration(
              labelText: 'Description',
              hintText: 'Enter todo description',
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
          ),
          verticalSpaceMedium,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () =>
                    completer?.call(SheetResponse(confirmed: false)),
                child: Text(
                  'Cancel',
                  style: buttonStyle.copyWith(color: kcMediumGrey),
                ),
              ),
              horizontalSpaceSmall,
              ElevatedButton(
                onPressed: () {
                  if (viewModel.canSubmit) {
                    completer?.call(
                      SheetResponse(
                        confirmed: true,
                        data: {
                          'title': viewModel.titleController.text,
                          'description': viewModel.descriptionController.text,
                        },
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kcPrimaryColor,
                ),
                child: Text(
                  'Add Todo',
                  style: buttonStyle.copyWith(color: Colors.white),
                ),
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
