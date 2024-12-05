import 'package:flutter/material.dart';
import '../../models/quiz.dart';

class QuizWidget extends StatefulWidget {
  final Quiz quiz;
  final Function(Map<String, String>) onSubmit;

  const QuizWidget({
    Key? key,
    required this.quiz,
    required this.onSubmit,
  }) : super(key: key);

  @override
  State<QuizWidget> createState() => _QuizWidgetState();
}

class _QuizWidgetState extends State<QuizWidget> {
  final Map<String, String> _answers = {};
  bool _isSubmitted = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.quiz.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.quiz.description,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),
            ...widget.quiz.questions.map((question) => _buildQuestion(question)),
            const SizedBox(height: 24),
            if (!_isSubmitted)
              ElevatedButton(
                onPressed: _answers.length == widget.quiz.questions.length
                    ? _handleSubmit
                    : null,
                child: const Text('Submit Quiz'),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestion(Question question) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question.text,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          ...question.options.map((option) => _buildOption(question.id, option)),
          if (_isSubmitted && _answers[question.id] != null)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                _answers[question.id] == question.correctAnswer
                    ? 'Correct!'
                    : 'Incorrect. The correct answer is: ${question.correctAnswer}',
                style: TextStyle(
                  color: _answers[question.id] == question.correctAnswer
                      ? Colors.green
                      : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildOption(String questionId, String option) {
    return RadioListTile<String>(
      title: Text(option),
      value: option,
      groupValue: _answers[questionId],
      onChanged: _isSubmitted
          ? null
          : (value) {
              setState(() {
                if (value != null) {
                  _answers[questionId] = value;
                }
              });
            },
    );
  }

  void _handleSubmit() {
    setState(() {
      _isSubmitted = true;
    });
    widget.onSubmit(_answers);
  }
}