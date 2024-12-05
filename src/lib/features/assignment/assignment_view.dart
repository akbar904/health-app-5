import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import './assignment_viewmodel.dart';
import '../../models/assignment.dart';
import '../../ui/widgets/loading_indicator.dart';
import '../../ui/widgets/error_display.dart';

class AssignmentView extends StackedView<AssignmentViewModel> {
  const AssignmentView({Key? key}) : super(key: key);

  @override
  Widget builder(BuildContext context, AssignmentViewModel viewModel, Widget? child) {
    if (viewModel.isBusy) {
      return const LoadingIndicator();
    }

    if (viewModel.hasError) {
      return ErrorDisplay(error: viewModel.error.toString());
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Assignments'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showCreateAssignmentDialog(context, viewModel),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: viewModel.assignments.length,
        itemBuilder: (context, index) {
          final assignment = viewModel.assignments[index];
          return AssignmentCard(
            assignment: assignment,
            onTap: () => viewModel.setCurrentAssignment(assignment),
            onDelete: () => viewModel.deleteAssignment(assignment.id),
            onEdit: () => _showEditAssignmentDialog(context, viewModel, assignment),
          );
        },
      ),
    );
  }

  @override
  AssignmentViewModel viewModelBuilder(BuildContext context) => AssignmentViewModel();

  @override
  void onViewModelReady(AssignmentViewModel viewModel) => viewModel.initialize();

  void _showCreateAssignmentDialog(BuildContext context, AssignmentViewModel viewModel) {
    // Implementation for create assignment dialog
  }

  void _showEditAssignmentDialog(
      BuildContext context, AssignmentViewModel viewModel, Assignment assignment) {
    // Implementation for edit assignment dialog
  }
}

class AssignmentCard extends StatelessWidget {
  final Assignment assignment;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const AssignmentCard({
    Key? key,
    required this.assignment,
    required this.onTap,
    required this.onDelete,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(assignment.title),
        subtitle: Text(assignment.description),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: onEdit,
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: onDelete,
            ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}