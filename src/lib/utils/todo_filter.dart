enum TodoFilter {
  all,
  active,
  completed;

  String get displayName {
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
