import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:gyde_app/features/assignment/assignment_viewmodel.dart';
import 'package:gyde_app/ui/common/app_colors.dart';
import 'package:gyde_app/ui/common/ui_helpers.dart';

class AssignmentView extends StackedView<AssignmentViewModel> {
  final String assignmentId;

  const AssignmentView({Key? key, required this.assignmentId})
      : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    AssignmentViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: Text(viewModel.assignment?.title ?? 'Assignment'),
        backgroundColor: kcPrimaryColor,
      ),
      body: viewModel.isBusy
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    viewModel.assignment?.title ?? '',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  verticalSpaceMedium,
                  Text(
                    'Due Date: ${viewModel.formattedDueDate}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: kcMediumGrey,
                    ),
                  ),
                  verticalSpaceMedium,
                  Text(
                    viewModel.assignment?.description ?? '',
                    style: const TextStyle(fontSize: 16),
                  ),
                  verticalSpaceLarge,
                  if (!viewModel.isSubmitted)
                    ElevatedButton(
                      onPressed: viewModel.submitAssignment,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kcPrimaryColor,
                        minimumSize: const Size.fromHeight(50),
                      ),
                      child: const Text('Submit Assignment'),
                    ),
                  if (viewModel.isSubmitted)
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.check_circle,
                            color: Colors.green,
                          ),
                          horizontalSpaceSmall,
                          const Text(
                            'Assignment Submitted',
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (viewModel.grade != null) ...[
                    verticalSpaceMedium,
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: kcPrimaryColor),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Grade',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          verticalSpaceSmall,
                          Text(
                            'Score: ${viewModel.grade?.score}',
                            style: const TextStyle(fontSize: 16),
                          ),
                          verticalSpaceSmall,
                          Text(
                            'Feedback: ${viewModel.grade?.feedback}',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
    );
  }

  @override
  AssignmentViewModel viewModelBuilder(BuildContext context) =>
      AssignmentViewModel(assignmentId: assignmentId);

  @override
  void onViewModelReady(AssignmentViewModel viewModel) =>
      viewModel.initialize();
}
