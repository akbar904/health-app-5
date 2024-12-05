import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../widgets/course/course_card.dart';
import 'course_viewmodel.dart';
import '../../models/course.dart';

class CourseView extends ViewModelWidget<CourseViewModel> {
  const CourseView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, CourseViewModel viewModel) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Courses'),
        actions: [
          if (viewModel.canCreateCourse)
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => _showCreateCourseDialog(context, viewModel),
            ),
        ],
      ),
      body: viewModel.isBusy
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                _buildSearchBar(context, viewModel),
                Expanded(
                  child: _buildCourseList(viewModel),
                ),
              ],
            ),
    );
  }

  Widget _buildSearchBar(BuildContext context, CourseViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        onChanged: viewModel.searchCourses,
        decoration: InputDecoration(
          hintText: 'Search courses...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  Widget _buildCourseList(CourseViewModel viewModel) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: viewModel.courses.length,
      itemBuilder: (context, index) {
        final course = viewModel.courses[index];
        return CourseCard(
          course: course,
          onTap: () => _showCourseDetails(context, viewModel, course),
          onEdit: viewModel.canEditCourse(course)
              ? () => _showEditCourseDialog(context, viewModel, course)
              : null,
          onDelete: viewModel.canDeleteCourse(course)
              ? () => _showDeleteConfirmation(context, viewModel, course)
              : null,
        );
      },
    );
  }

  Future<void> _showCreateCourseDialog(
      BuildContext context, CourseViewModel viewModel) async {
    // Implementation for create course dialog
  }

  Future<void> _showEditCourseDialog(
      BuildContext context, CourseViewModel viewModel, Course course) async {
    // Implementation for edit course dialog
  }

  Future<void> _showDeleteConfirmation(
      BuildContext context, CourseViewModel viewModel, Course course) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Course'),
        content: Text('Are you sure you want to delete ${course.name}?'),
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

    if (confirmed == true) {
      await viewModel.deleteCourse(course.id);
    }
  }

  void _showCourseDetails(
      BuildContext context, CourseViewModel viewModel, Course course) {
    // Implementation for course details view
  }
}

