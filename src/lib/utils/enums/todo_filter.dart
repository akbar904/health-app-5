enum TodoFilter {
  all,
  active,
  completed,
}

extension TodoFilterExtension on TodoFilter {
  String get name {
    switch (this) {
      case TodoFilter.all:
        return 'All';
      case TodoFilter.active:
        return 'Active';
      case TodoFilter.completed:
        return 'Completed';
    }
  }
}
