import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'course_viewmodel.dart';
import '../../models/course.dart';
import '../../widgets/loading_indicator.dart';
import '../../widgets/error_handler.dart';
import '../../widgets/responsive_layout.dart';

class CourseView extends StatelessWidget {
  const CourseView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CourseViewModel>.reactive(
      viewModelBuilder: () => CourseViewModel(),
      onModelReady: (model) => model.initialize(),
      builder: (context, model, child) {
        if (model.isBusy) {
          return const LoadingIndicator();
        }

        if (model.hasError) {
          return ErrorHandler(error: model.error);
        }

        return ResponsiveLayout(
          mobileBody: _buildMobileLayout(context, model),
          tabletBody: _buildTabletLayout(context, model),
          desktopBody: _buildDesktopLayout(context, model),
        );
      },
    );
  }

  Widget _buildMobileLayout(BuildContext context, CourseViewModel model) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Courses'),
        actions: _buildAppBarActions(context, model),
      ),
      body: ListView.builder(
        itemCount: model.courses.length,
        itemBuilder: (context, index) {
          return _buildCourseCard(context, model.courses[index], model);
        },
      ),
      floatingActionButton: model.canCreateCourse
          ? FloatingActionButton(
              onPressed: () => _showCreateCourseDialog(context, model),
              child: const Icon(Icons.add),
            )
          : null,
    );
  }

  Widget _buildTabletLayout(BuildContext context, CourseViewModel model) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Courses'),
        actions: _buildAppBarActions(context, model),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3/2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: model.courses.length,
        itemBuilder: (context, index) {
          return _buildCourseCard(context, model.courses[index], model);
        },
      ),
      floatingActionButton: model.canCreateCourse
          ? FloatingActionButton(
              onPressed: () => _showCreateCourseDialog(context, model),
              child: const Icon(Icons.add),
            )
          : null,
    );
  }

  Widget _buildDesktopLayout(BuildContext context, CourseViewModel model) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Courses'),
        actions: _buildAppBarActions(context, model),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 3/2,
          crossAxisSpacing: 24,
          mainAxisSpacing: 24,
        ),
        itemCount: model.courses.length,
        itemBuilder: (context, index) {
          return _buildCourseCard(context, model.courses[index], model);
        },
      ),
      floatingActionButton: model.canCreateCourse
          ? FloatingActionButton(
              onPressed: () => _showCreateCourseDialog(context, model),
              child: const Icon(Icons.add),
            )
          : null,
    );
  }

  List<Widget> _buildAppBarActions(BuildContext context, CourseViewModel model) {
    return [
      IconButton(
        icon: const Icon(Icons.filter_list),
        onPressed: () => _showFilterDialog(context, model),
      ),
      IconButton(
        icon: const Icon(Icons.search),
        onPressed: () => _showSearchDialog(context, model),
      ),
    ];
  }

  Widget _buildCourseCard(BuildContext context, Course course, CourseViewModel model) {
    return Card(
      child: InkWell(
        onTap: () => model.navigateToCourseDetails(course.id),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                course.name,
                style: Theme.of(context).textTheme.titleLarge,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Text(
                course.description,
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Students: ${course.studentCount}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  if (model.canEditCourse)
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => _showEditCourseDialog(context, model, course),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCreateCourseDialog(BuildContext context, CourseViewModel model) {
    // Implementation for create course dialog
  }

  void _showEditCourseDialog(BuildContext context, CourseViewModel model, Course course) {
    // Implementation for edit course dialog
  }

  void _showFilterDialog(BuildContext context, CourseViewModel model) {
    // Implementation for filter dialog
  }

  void _showSearchDialog(BuildContext context, CourseViewModel model) {
    // Implementation for search dialog
  }
}