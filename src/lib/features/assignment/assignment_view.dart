import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'assignment_viewmodel.dart';
import '../../models/assignment.dart';
import '../../widgets/loading_indicator.dart';
import '../../widgets/error_handler.dart';

class AssignmentView extends StatelessWidget {
  const AssignmentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AssignmentViewModel>.reactive(
      onViewModelReady: (model) => model.initialize(),
      viewModelBuilder: () => AssignmentViewModel(
        repository: AssignmentRepository(),
        userService: UserService(),
      ),
      builder: (context, model, child) {
        if (model.isBusy) {
          return const LoadingIndicator();
        }

        if (model.hasError) {
          return ErrorHandler(error: model.error);
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Assignments'),
            actions: [
              if (model.isTeacher)
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => _showCreateAssignmentDialog(context, model),
                ),
            ],
          ),
          body: ListView.builder(
            itemCount: model.assignments.length,
            itemBuilder: (context, index) {
              final assignment = model.assignments[index];
              return _buildAssignmentCard(context, assignment, model);
            },
          ),
        );
      },
    );
  }

  Widget _buildAssignmentCard(
    BuildContext context,
    Assignment assignment,
    AssignmentViewModel model,
  ) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(assignment.title),
        subtitle: Text(assignment.description),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (model.isTeacher) ...[
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () => _showEditAssignmentDialog(context, model, assignment),
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => _showDeleteConfirmation(context, model, assignment),
              ),
            ] else if (model.isStudent) ...[
              TextButton(
                onPressed: () => _showSubmissionDialog(context, model, assignment),
                child: const Text('Submit'),
              ),
            ],
          ],
        ),
        onTap: () => _showAssignmentDetails(context, assignment, model),
      ),
    );
  }

  Future<void> _showCreateAssignmentDialog(
    BuildContext context,
    AssignmentViewModel model,
  ) async {
    // Implementation for create assignment dialog
  }

  Future<void> _showEditAssignmentDialog(
    BuildContext context,
    AssignmentViewModel model,
    Assignment assignment,
  ) async {
    // Implementation for edit assignment dialog
  }

  Future<void> _showDeleteConfirmation(
    BuildContext context,
    AssignmentViewModel model,
    Assignment assignment,
  ) async {
    // Implementation for delete confirmation dialog
  }

  Future<void> _showSubmissionDialog(
    BuildContext context,
    AssignmentViewModel model,
    Assignment assignment,
  ) async {
    // Implementation for submission dialog
  }

  void _showAssignmentDetails(
    BuildContext context,
    Assignment assignment,
    AssignmentViewModel model,
  ) {
    // Implementation for assignment details view
  }
}