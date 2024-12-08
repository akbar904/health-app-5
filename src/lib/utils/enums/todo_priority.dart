enum TodoPriority { low, medium, high }

extension TodoPriorityExtension on TodoPriority {
  String get name {
    switch (this) {
      case TodoPriority.low:
        return 'Low';
      case TodoPriority.medium:
        return 'Medium';
      case TodoPriority.high:
        return 'High';
    }
  }

  String get emoji {
    switch (this) {
      case TodoPriority.low:
        return '🟢';
      case TodoPriority.medium:
        return '🟡';
      case TodoPriority.high:
        return '🔴';
    }
  }
}
