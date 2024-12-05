import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'course_viewmodel.dart';
import '../../widgets/custom_input.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/loading_indicator.dart';
import '../../widgets/error_display.dart';
import '../../models/course.dart';

class CourseView extends StackedView<CourseViewModel> {
  final String? courseId;

  const CourseView({Key? key, this.courseId}) : super(key: key);

  @override
  Widget builder(BuildContext context, CourseViewModel viewModel, Widget? child) {
    return Scaffold(
      appBar: AppBar(
        title: Text(courseId != null ? 'Course Details' : 'Create Course'),
        actions: [
          if (courseId != null)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _showDeleteConfirmation(context, viewModel),
            ),
        ],
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
                        label: 'Course Title',
                        controller: viewModel.titleController,
                        validator: (value) => viewModel.validateTitle(value),
                      ),
                      const SizedBox(height: 16),
                      CustomInput(
                        label: 'Description',
                        controller: viewModel.descriptionController,
                        maxLines: 3,
                        validator: (value) => viewModel.validateDescription(value),
                      ),
                      const SizedBox(height: 16),
                      CustomInput(
                        label: 'Grade Level',
                        controller: viewModel.gradeController,
                        keyboardType: TextInputType.number,
                        validator: (value) => viewModel.validateGrade(value),
                      ),
                      const SizedBox(height: 24),
                      if (viewModel.course != null)
                        _buildCourseStats(viewModel.course!),
                      const SizedBox(height: 24),
                      CustomButton(
                        title: courseId != null ? 'Update Course' : 'Create Course',
                        onPressed: viewModel.saveCourse,
                        isLoading: viewModel.isBusy,
                      ),
                    ],
                  ),
                ),
    );
  }

  Widget _buildCourseStats(Course course) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Course Statistics',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Created: ${course.createdAt.toString().split(' ')[0]}'),
            Text('Last Updated: ${course.updatedAt.toString().split(' ')[0]}'),
            Text('Total Students: ${course.enrolledStudents?.length ?? 0}'),
            Text('Total Assignments: ${course.assignments?.length ?? 0}'),
          ],
        ),
      ),
    );
  }

  Future<void> _showDeleteConfirmation(
      BuildContext context, CourseViewModel viewModel) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Course'),
        content: const Text(
            'Are you sure you want to delete this course? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true && courseId != null) {
      await viewModel.deleteCourse(courseId!);
      if (context.mounted) {
        Navigator.pop(context);
      }
    }
  }

  @override
  CourseViewModel viewModelBuilder(BuildContext context) => CourseViewModel(
        courseId: courseId,
      );
}