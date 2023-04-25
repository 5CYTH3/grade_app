import 'package:flutter/material.dart';
import 'package:grade_app/controller/subjects.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../controller/grades.dart';

class GradeCard extends StatelessWidget {
  final String subjectKey;
  final Grades grade;
  GradeCard({super.key, required this.grade, required this.subjectKey});

  final box = Hive.box<Subjects>("subjects");

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: const Text("Do you want to delete this grade?"),
          actions: [
            MaterialButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("No"),
            ),
            MaterialButton(
              onPressed: () {
                grade.delete();
                box.get(subjectKey)?.save();
                Navigator.of(context).pop();
              },
              child: const Text("Yes"),
            )
          ],
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [Text("${grade.grade}/20"), Text("(${grade.coefficient})")],
        ),
      ),
    );
  }
}
