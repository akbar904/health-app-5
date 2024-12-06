import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:gyde_app/features/admin/curriculum/curriculum_viewmodel.dart';
import 'package:gyde_app/ui/common/app_colors.dart';
import 'package:gyde_app/ui/common/ui_helpers.dart';
import 'package:gyde_app/utils/enums/grade_level_enum.dart';

class CurriculumView extends StackedView<CurriculumViewModel> {
  const CurriculumView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    CurriculumViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Curriculum Management'),
        backgroundColor: kcPrimaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: viewModel.showAddCourseDialog,
          ),
        ],
      ),
      body: viewModel.isBusy
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFilters(viewModel),
                  verticalSpaceMedium,
                  _buildCourseList(viewModel),
                ],
              ),
            ),
    );
  }

  Widget _buildFilters(CurriculumViewModel viewModel) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Filters',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            verticalSpaceSmall,
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<GradeLevel>(
                    value: viewModel.selectedGradeLevel,
                    decoration: const InputDecoration(
                      labelText: 'Grade Level',
                    ),
                    items: GradeLevel.values
                        .map((grade) => DropdownMenuItem(
                              value: grade,
                              child: Text(grade.toString().split('.').last),
                            ))
                        .toList(),
                    onChanged: viewModel.setGradeLevel,
                  ),
                ),
                horizontalSpaceMedium,
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Search',
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: viewModel.setSearchQuery,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseList(CurriculumViewModel viewModel) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: viewModel.filteredCourses.length,
      itemBuilder: (context, index) {
        final course = viewModel.filteredCourses[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ExpansionTile(
            title: Text(course.title),
            subtitle: Text(
              '${course.subject} - ${course.gradeLevel.toString().split('.').last}',
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Description: ${course.description}'),
                    verticalSpaceSmall,
                    Text(
                      'Duration: ${_formatDate(course.startDate)} - ${_formatDate(course.endDate)}',
                    ),
                    verticalSpaceSmall,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => viewModel.editCourse(course),
                          child: const Text('Edit'),
                        ),
                        TextButton(
                          onPressed: () => viewModel.deleteCourse(course.id),
                          child: const Text(
                            'Delete',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _formatDate(DateTime date) {
    return '${date.month}/${date.day}/${date.year}';
  }

  @override
  CurriculumViewModel viewModelBuilder(BuildContext context) =>
      CurriculumViewModel();

  @override
  void onViewModelReady(CurriculumViewModel viewModel) =>
      viewModel.initialize();
}
