import 'package:hive/hive.dart';

part 'grades.g.dart';

@HiveType(typeId: 2)
class Grades extends HiveObject {
  @HiveField(0)
  double grade;

  @HiveField(1)
  double coefficient;

  Grades({required this.grade, required this.coefficient});
}
