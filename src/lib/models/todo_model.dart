import 'package:equatable/equatable.dart';

class TodoModel extends Equatable {
  final String id;
  final String title;
  final String description;
  final bool isCompleted;
  final DateTime createdAt;

  const TodoModel({
    required this.id,
    required this.title,
    required this.description,
    this.isCompleted = false,
    required this.createdAt,
  });

  TodoModel copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
    DateTime? createdAt,
  }) {
    return TodoModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [id, title, description, isCompleted, createdAt];
}
