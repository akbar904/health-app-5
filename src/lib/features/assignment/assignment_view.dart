import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'assignment_viewmodel.dart';
import '../../widgets/custom_input.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/loading_indicator.dart';
import '../../widgets/error_display.dart';

class AssignmentView extends StackedView<AssignmentViewModel> {
  final String? assignmentId;
  
  const AssignmentView({Key? key, this.assignmentId}) : super(key: key);

  @override
  Widget builder(BuildContext context, AssignmentViewModel viewModel, Widget? child) {
    return Scaffold(
      appBar: AppBar(
        title: Text(assignmentId != null ? 'Assignment Details' : 'Create Assignment'),
      ),
      body: viewModel.isBusy
          ? const LoadingIndicator()
          : viewModel.hasError
              ? ErrorDisplay(error: viewModel.error.toString())
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomInput(
                        label: 'Title',
                        controller: viewModel.titleController,
                        validator: (value) => viewModel.validateTitle(value),
                      ),
                      const SizedBox(height: 16),
                      CustomInput(
                        label: 'Description',
                        controller: viewModel.descriptionController,
                        maxLines: 5,
                        validator: (value) => viewModel.validateDescription(value),
                      ),
                      const SizedBox(height: 16),
                      CustomInput(
                        label: 'Due Date',
                        readOnly: true,
                        onTap: () => viewModel.selectDueDate(context),
                        controller: viewModel.dueDateController,
                      ),
                      const SizedBox(height: 16),
                      CustomInput(
                        label: 'Maximum Points',
                        controller: viewModel.pointsController,
                        keyboardType: TextInputType.number,
                        validator: (value) => viewModel.validatePoints(value),
                      ),
                      const SizedBox(height: 24),
                      CustomButton(
                        title: assignmentId != null ? 'Update Assignment' : 'Create Assignment',
                        onPressed: viewModel.submitAssignment,
                        isLoading: viewModel.isBusy,
                      ),
                    ],
                  ),
                ),
    );
  }

  @override
  AssignmentViewModel viewModelBuilder(BuildContext context) => 
      AssignmentViewModel(assignmentId: assignmentId);
}