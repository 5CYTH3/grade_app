import 'package:hive/hive.dart';
import 'package:collection/collection.dart';

import 'grades.dart';

part 'subjects.g.dart';

@HiveType(typeId: 1)
class Subjects extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final HiveList<Grades> grades;

  @HiveField(2)
  final double coefficient;

  Subjects({
    required this.name,
    required this.grades,
    required this.coefficient,
  });

  double? calculateWeightedMean() {
    double wavg = 0;
    if (grades.isEmpty) return null;
    for (var e in grades) {
      wavg = wavg +
          ((e.grade * e.coefficient) / grades.map((e) => e.coefficient).sum);
    }
    return num.parse(wavg.toStringAsFixed(2)).toDouble();
  }
}
