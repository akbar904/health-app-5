class Quiz {
  final String id;
  final String title;
  final String description;
  final List<Question> questions;
  final String courseId;
  final DateTime dueDate;
  final int timeLimit;
  final bool isPublished;
  final Map<String, dynamic>? metadata;

  Quiz({
    required this.id,
    required this.title,
    required this.description,
    required this.questions,
    required this.courseId,
    required this.dueDate,
    required this.timeLimit,
    this.isPublished = false,
    this.metadata,
  });

  Quiz copyWith({
    String? id,
    String? title,
    String? description,
    List<Question>? questions,
    String? courseId,
    DateTime? dueDate,
    int? timeLimit,
    bool? isPublished,
    Map<String, dynamic>? metadata,
  }) {
    return Quiz(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      questions: questions ?? this.questions,
      courseId: courseId ?? this.courseId,
      dueDate: dueDate ?? this.dueDate,
      timeLimit: timeLimit ?? this.timeLimit,
      isPublished: isPublished ?? this.isPublished,
      metadata: metadata ?? this.metadata,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'questions': questions.map((q) => q.toJson()).toList(),
      'courseId': courseId,
      'dueDate': dueDate.toIso8601String(),
      'timeLimit': timeLimit,
      'isPublished': isPublished,
      'metadata': metadata,
    };
  }

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      questions: (json['questions'] as List)
          .map((q) => Question.fromJson(q))
          .toList(),
      courseId: json['courseId'] as String,
      dueDate: DateTime.parse(json['dueDate']),
      timeLimit: json['timeLimit'] as int,
      isPublished: json['isPublished'] as bool,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );
  }

  int get totalPoints => questions.fold(0, (sum, q) => sum + q.points);
  
  bool get isOverdue => DateTime.now().isAfter(dueDate);
  
  Duration get remainingTime => dueDate.difference(DateTime.now());
}

class Question {
  final String id;
  final String text;
  final List<String> options;
  final String correctAnswer;
  final int points;
  final String? explanation;
  final QuestionType type;

  Question({
    required this.id,
    required this.text,
    required this.options,
    required this.correctAnswer,
    required this.points,
    this.explanation,
    this.type = QuestionType.multipleChoice,
  });

  Question copyWith({
    String? id,
    String? text,
    List<String>? options,
    String? correctAnswer,
    int? points,
    String? explanation,
    QuestionType? type,
  }) {
    return Question(
      id: id ?? this.id,
      text: text ?? this.text,
      options: options ?? this.options,
      correctAnswer: correctAnswer ?? this.correctAnswer,
      points: points ?? this.points,
      explanation: explanation ?? this.explanation,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'options': options,
      'correctAnswer': correctAnswer,
      'points': points,
      'explanation': explanation,
      'type': type.toString(),
    };
  }

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'] as String,
      text: json['text'] as String,
      options: List<String>.from(json['options']),
      correctAnswer: json['correctAnswer'] as String,
      points: json['points'] as int,
      explanation: json['explanation'] as String?,
      type: QuestionType.values.firstWhere(
        (e) => e.toString() == json['type'],
        orElse: () => QuestionType.multipleChoice,
      ),
    );
  }

  bool checkAnswer(String answer) => answer == correctAnswer;
}

enum QuestionType {
  multipleChoice,
  trueFalse,
  shortAnswer,
  essay,
  matching,
}