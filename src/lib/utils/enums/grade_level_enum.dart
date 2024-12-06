enum GradeLevel {
  none,
  kindergarten,
  grade1,
  grade2,
  grade3,
  grade4,
  grade5,
  grade6,
  grade7,
  grade8,
  grade9,
  grade10,
  grade11,
  grade12
}

extension GradeLevelExtension on GradeLevel {
  String get displayName {
    switch (this) {
      case GradeLevel.none:
        return 'None';
      case GradeLevel.kindergarten:
        return 'Kindergarten';
      case GradeLevel.grade1:
        return '1st Grade';
      case GradeLevel.grade2:
        return '2nd Grade';
      case GradeLevel.grade3:
        return '3rd Grade';
      case GradeLevel.grade4:
        return '4th Grade';
      case GradeLevel.grade5:
        return '5th Grade';
      case GradeLevel.grade6:
        return '6th Grade';
      case GradeLevel.grade7:
        return '7th Grade';
      case GradeLevel.grade8:
        return '8th Grade';
      case GradeLevel.grade9:
        return '9th Grade';
      case GradeLevel.grade10:
        return '10th Grade';
      case GradeLevel.grade11:
        return '11th Grade';
      case GradeLevel.grade12:
        return '12th Grade';
    }
  }

  int get numericValue {
    switch (this) {
      case GradeLevel.none:
        return -1;
      case GradeLevel.kindergarten:
        return 0;
      case GradeLevel.grade1:
        return 1;
      case GradeLevel.grade2:
        return 2;
      case GradeLevel.grade3:
        return 3;
      case GradeLevel.grade4:
        return 4;
      case GradeLevel.grade5:
        return 5;
      case GradeLevel.grade6:
        return 6;
      case GradeLevel.grade7:
        return 7;
      case GradeLevel.grade8:
        return 8;
      case GradeLevel.grade9:
        return 9;
      case GradeLevel.grade10:
        return 10;
      case GradeLevel.grade11:
        return 11;
      case GradeLevel.grade12:
        return 12;
    }
  }
}
