import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:gyde_app/features/course/course_viewmodel.dart';
import 'package:gyde_app/ui/common/app_colors.dart';
import 'package:gyde_app/ui/common/ui_helpers.dart';

class CourseView extends StackedView<CourseViewModel> {
  final String courseId;

  const CourseView({Key? key, required this.courseId}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    CourseViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: Text(viewModel.course?.title ?? 'Course'),
        backgroundColor: kcPrimaryColor,
        actions: [
          if (viewModel.course != null)
            IconButton(
              icon: Icon(
                viewModel.isEditing ? Icons.check : Icons.edit,
              ),
              onPressed: viewModel.toggleEditing,
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
                  _buildCourseHeader(viewModel),
                  verticalSpaceMedium,
                  _buildResourceSection(viewModel),
                  verticalSpaceMedium,
                  _buildStudentSection(viewModel),
                  verticalSpaceMedium,
                  _buildAssignmentSection(viewModel),
                ],
              ),
            ),
    );
  }

  Widget _buildCourseHeader(CourseViewModel viewModel) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (viewModel.isEditing)
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Course Title',
                ),
                controller: TextEditingController(
                  text: viewModel.course?.title,
                ),
                onChanged: viewModel.updateTitle,
              )
            else
              Text(
                viewModel.course?.title ?? '',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            verticalSpaceMedium,
            if (viewModel.isEditing)
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Description',
                ),
                maxLines: 3,
                controller: TextEditingController(
                  text: viewModel.course?.description,
                ),
                onChanged: viewModel.updateDescription,
              )
            else
              Text(
                viewModel.course?.description ?? '',
                style: const TextStyle(fontSize: 16),
              ),
            verticalSpaceMedium,
            Row(
              children: [
                Icon(Icons.calendar_today, color: kcMediumGrey),
                horizontalSpaceSmall,
                Text(
                  '${_formatDate(viewModel.course?.startDate)} - ${_formatDate(viewModel.course?.endDate)}',
                  style: TextStyle(color: kcMediumGrey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResourceSection(CourseViewModel viewModel) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Resources',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (viewModel.isEditing)
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: viewModel.addResource,
                  ),
              ],
            ),
            verticalSpaceMedium,
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: viewModel.course?.resourceUrls.length ?? 0,
              itemBuilder: (context, index) {
                final resource = viewModel.course!.resourceUrls[index];
                return ListTile(
                  leading: const Icon(Icons.attachment),
                  title: Text(resource),
                  trailing: viewModel.isEditing
                      ? IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => viewModel.removeResource(resource),
                        )
                      : null,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStudentSection(CourseViewModel viewModel) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Enrolled Students',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (viewModel.isEditing)
                  IconButton(
                    icon: const Icon(Icons.person_add),
                    onPressed: viewModel.addStudent,
                  ),
              ],
            ),
            verticalSpaceMedium,
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: viewModel.course?.studentIds.length ?? 0,
              itemBuilder: (context, index) {
                final studentId = viewModel.course!.studentIds[index];
                return ListTile(
                  leading: const CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                  title: Text('Student $studentId'),
                  trailing: viewModel.isEditing
                      ? IconButton(
                          icon: const Icon(Icons.remove_circle),
                          onPressed: () => viewModel.removeStudent(studentId),
                        )
                      : null,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAssignmentSection(CourseViewModel viewModel) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Assignments',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: viewModel.createAssignment,
                  icon: const Icon(Icons.add),
                  label: const Text('Create Assignment'),
                ),
              ],
            ),
            verticalSpaceMedium,
            // Assignment list would go here
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    return '${date.month}/${date.day}/${date.year}';
  }

  @override
  CourseViewModel viewModelBuilder(BuildContext context) => CourseViewModel();

  @override
  void onViewModelReady(CourseViewModel viewModel) =>
      viewModel.initialize(courseId);
}
