import 'package:equatable/equatable.dart';

class TodoModel extends Equatable {
  final String id;
  final String title;
  final bool isComplete;
  final DateTime createdAt;
  final DateTime? completedAt;

  const TodoModel({
    required this.id,
    required this.title,
    this.isComplete = false,
    required this.createdAt,
    this.completedAt,
  });

  TodoModel copyWith({
    String? id,
    String? title,
    bool? isComplete,
    DateTime? createdAt,
    DateTime? completedAt,
  }) {
    return TodoModel(
      id: id ?? this.id,
      title: title ?? this.title,
      isComplete: isComplete ?? this.isComplete,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  @override
  List<Object?> get props => [id, title, isComplete, createdAt, completedAt];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'isComplete': isComplete,
      'createdAt': createdAt.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
    };
  }

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'] as String,
      title: json['title'] as String,
      isComplete: json['isComplete'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      completedAt: json['completedAt'] != null
          ? DateTime.parse(json['completedAt'] as String)
          : null,
    );
  }

  static List<TodoModel> get mockTodos {
    return [
      TodoModel(
        id: '1',
        title: 'Buy groceries',
        isComplete: false,
        createdAt: DateTime.now(),
      ),
      TodoModel(
        id: '2',
        title: 'Complete Flutter project',
        isComplete: true,
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        completedAt: DateTime.now(),
      ),
      TodoModel(
        id: '3',
        title: 'Exercise',
        isComplete: false,
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
      ),
    ];
  }
}
