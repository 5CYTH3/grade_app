import 'package:flutter/material.dart';
import 'package:grade_app/view/subject_screen.dart';

import 'package:grade_app/controller/subjects.dart';

class SubjectCard extends StatelessWidget {
  final Subjects subject;
  const SubjectCard({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => SubjectScreen(
            subjectKey: subject.name.toLowerCase(),
          ),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(subject.name),
            Text("${subject.calculateWeightedMean()}"),
          ],
        ),
      ),
    );
  }
}
