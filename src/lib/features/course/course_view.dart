import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import './course_viewmodel.dart';
import '../../models/course.dart';
import '../../ui/widgets/loading_indicator.dart';
import '../../ui/widgets/error_display.dart';

class CourseView extends StackedView<CourseViewModel> {
  const CourseView({Key? key}) : super(key: key);

  @override
  Widget builder(BuildContext context, CourseViewModel viewModel, Widget? child) {
    if (viewModel.isBusy) {
      return const LoadingIndicator();
    }

    if (viewModel.hasError) {
      return ErrorDisplay(error: viewModel.error.toString());
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Courses'),
        actions: [
          if (viewModel.isTeacher)
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => _showCreateCourseDialog(context, viewModel),
            ),
        ],
      ),
      body: ListView.builder(
        itemCount: viewModel.courses.length,
        itemBuilder: (context, index) {
          final course = viewModel.courses[index];
          return CourseCard(
            course: course,
            onTap: () => viewModel.selectCourse(course),
            isTeacher: viewModel.isTeacher,
            onEdit: () => _showEditCourseDialog(context, viewModel, course),
            onDelete: () => viewModel.deleteCourse(course.id),
          );
        },
      ),
    );
  }

  @override
  CourseViewModel viewModelBuilder(BuildContext context) => CourseViewModel();

  @override
  void onViewModelReady(CourseViewModel viewModel) => viewModel.initialize();

  void _showCreateCourseDialog(BuildContext context, CourseViewModel viewModel) {
    // Implementation for create course dialog
  }

  void _showEditCourseDialog(
      BuildContext context, CourseViewModel viewModel, Course course) {
    // Implementation for edit course dialog
  }
}

class CourseCard extends StatelessWidget {
  final Course course;
  final VoidCallback onTap;
  final bool isTeacher;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const CourseCard({
    Key? key,
    required this.course,
    required this.onTap,
    required this.isTeacher,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(course.title),
        subtitle: Text(course.description),
        trailing: isTeacher
            ? Row(
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
              )
            : null,
        onTap: onTap,
      ),
    );
  }
}