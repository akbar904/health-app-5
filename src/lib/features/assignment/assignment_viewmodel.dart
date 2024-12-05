import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../models/assignment.dart';
import '../../services/api_service.dart';
import 'assignment_repository.dart';

class AssignmentViewModel extends BaseViewModel {
  final String? assignmentId;
  final AssignmentRepository _repository;
  final ApiService _apiService;

  Assignment? _assignment;
  Assignment? get assignment => _assignment;

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final dueDateController = TextEditingController();
  final pointsController = TextEditingController();

  DateTime? _selectedDueDate;

  AssignmentViewModel({
    this.assignmentId,
    required AssignmentRepository repository,
    required ApiService apiService,
  }) : _repository = repository,
       _apiService = apiService {
    _initialize();
  }

  Future<void> _initialize() async {
    if (assignmentId != null) {
      await loadAssignment();
    }
  }

  Future<void> loadAssignment() async {
    setBusy(true);
    try {
      _assignment = await _repository.getAssignmentById(assignmentId!);
      _populateControllers();
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  void _populateControllers() {
    if (_assignment != null) {
      titleController.text = _assignment!.title;
      descriptionController.text = _assignment!.description;
      dueDateController.text = _formatDate(_assignment!.dueDate);
      pointsController.text = _assignment!.maxPoints.toString();
      _selectedDueDate = _assignment!.dueDate;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  Future<void> selectDueDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDueDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null) {
      _selectedDueDate = picked;
      dueDateController.text = _formatDate(picked);
      notifyListeners();
    }
  }

  String? validateTitle(String? value) {
    if (value == null || value.isEmpty) {
      return 'Title is required';
    }
    return null;
  }

  String? validateDescription(String? value) {
    if (value == null || value.isEmpty) {
      return 'Description is required';
    }
    return null;
  }

  String? validatePoints(String? value) {
    if (value == null || value.isEmpty) {
      return 'Points are required';
    }
    if (int.tryParse(value) == null) {
      return 'Please enter a valid number';
    }
    return null;
  }

  Future<void> submitAssignment() async {
    if (!_validateAll()) return;

    setBusy(true);
    try {
      final assignment = Assignment(
        id: assignmentId ?? '',
        title: titleController.text,
        description: descriptionController.text,
        dueDate: _selectedDueDate!,
        maxPoints: int.parse(pointsController.text),
        courseId: _assignment?.courseId ?? '',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      if (assignmentId == null) {
        await _repository.createAssignment(assignment);
      } else {
        await _repository.updateAssignment(assignment);
      }

      // Navigate back or show success message
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  bool _validateAll() {
    if (validateTitle(titleController.text) != null) return false;
    if (validateDescription(descriptionController.text) != null) return false;
    if (_selectedDueDate == null) {
      setError('Please select a due date');
      return false;
    }
    if (validatePoints(pointsController.text) != null) return false;
    return true;
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    dueDateController.dispose();
    pointsController.dispose();
    super.dispose();
  }
}