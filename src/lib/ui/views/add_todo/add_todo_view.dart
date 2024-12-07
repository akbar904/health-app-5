import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:gyde_app/ui/views/add_todo/add_todo_viewmodel.dart';
import 'package:gyde_app/ui/common/ui_helpers.dart';
import 'package:gyde_app/ui/common/app_colors.dart';

class AddTodoView extends StackedView<AddTodoViewModel> {
  const AddTodoView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    AddTodoViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Todo'),
        backgroundColor: kcPrimaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: viewModel.titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            verticalSpaceMedium,
            TextField(
              controller: viewModel.descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            verticalSpaceLarge,
            ElevatedButton(
              onPressed: viewModel.isBusy ? null : viewModel.addTodo,
              style: ElevatedButton.styleFrom(
                backgroundColor: kcPrimaryColor,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: viewModel.isBusy
                  ? const CircularProgressIndicator()
                  : const Text('Add Todo'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  AddTodoViewModel viewModelBuilder(BuildContext context) => AddTodoViewModel();
}
