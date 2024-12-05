import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../widgets/assignment/assignment_card.dart';
import '../../widgets/common/custom_appbar.dart';
import 'assignment_viewmodel.dart';
import '../../models/assignment.dart';

class AssignmentView extends ViewModelWidget<AssignmentViewModel> {
  const AssignmentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, AssignmentViewModel viewModel) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Assignments',
        actions: [
          if (viewModel.canCreateAssignment)
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => _showCreateAssignmentDialog(context, viewModel),
            ),
        ],
      ),
      body: viewModel.isBusy
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                _buildFilterSection(viewModel),
                Expanded(
                  child: _buildAssignmentList(viewModel),
                ),
              ],
            ),
      floatingActionButton: viewModel.canCreateAssignment
          ? FloatingActionButton(
              onPressed: () => _showCreateAssignmentDialog(context, viewModel),
              child: const Icon(Icons.add),
            )
          : null,
    );
  }

  Widget _buildFilterSection(AssignmentViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            onChanged: viewModel.searchAssignments,
            decoration: InputDecoration(
              hintText: 'Search assignments...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFilterChip('All', viewModel.selectedFilter == 'all', () {
                  viewModel.setFilter('all');
                }),
                _buildFilterChip('Pending', viewModel.selectedFilter == 'pending',
                    () {
                  viewModel.setFilter('pending');
                }),
                _buildFilterChip(
                    'Submitted', viewModel.selectedFilter == 'submitted', () {
                  viewModel.setFilter('submitted');
                }),
                _buildFilterChip('Graded', viewModel.selectedFilter == 'graded',
                    () {
                  viewModel.setFilter('graded');
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, bool selected, VoidCallback onSelected) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => onSelected(),
      ),
    );
  }

  Widget _buildAssignmentList(AssignmentViewModel viewModel) {
    if (viewModel.assignments.isEmpty) {
      return const Center(
        child: Text('No assignments found'),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: viewModel.assignments.length,
      itemBuilder: (context, index) {
        final assignment = viewModel.assignments[index];
        return AssignmentCard(
          assignment: assignment,
          onTap: () => _showAssignmentDetails(context, viewModel, assignment),
          onSubmit: viewModel.canSubmitAssignment(assignment)
              ? () => _showSubmissionDialog(context, viewModel, assignment)
              : null,
          onGrade: viewModel.canGradeAssignment(assignment)
              ? () => _showGradingDialog(context, viewModel, assignment)
              : null,
        );
      },
    );
  }

  Future<void> _showCreateAssignmentDialog(
      BuildContext context, AssignmentViewModel viewModel) async {
    // Implementation for create assignment dialog
  }

  Future<void> _showSubmissionDialog(BuildContext context,
      AssignmentViewModel viewModel, Assignment assignment) async {
    // Implementation for submission dialog
  }

  Future<void> _showGradingDialog(BuildContext context,
      AssignmentViewModel viewModel, Assignment assignment) async {
    // Implementation for grading dialog
  }

  void _showAssignmentDetails(
      BuildContext context, AssignmentViewModel viewModel, Assignment assignment) {
    // Implementation for assignment details view
  }
}