import 'package:grade_app/components/home/subject_dialog.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:grade_app/controller/grades.dart';
import 'package:grade_app/controller/subjects.dart';

class WelcomeBar extends StatelessWidget {
  final String name;
  WelcomeBar({super.key, required this.name});
  final box = Hive.box<Subjects>('subjects');
  final gradeBox = Hive.box<Grades>('grades');

  Future<void> appendTestValuesToBox() {
    final Subjects maths = Subjects(
      name: "Maths",
      grades: HiveList(gradeBox),
      coefficient: 1.0,
    );
    return box.put(maths.name.toLowerCase(), maths);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      decoration: const BoxDecoration(),
      margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello, $name 👋',
                style: GoogleFonts.inter(fontSize: 20),
              ),
              Text(
                'What are your goals today?',
                style: GoogleFonts.inter(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: () => showDialog(
              context: context,
              builder: (context) => const SubjectDialog(),
            ),
            icon: const Icon(Icons.settings),
          )
        ],
      ),
    );
  }
}
