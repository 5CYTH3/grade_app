import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grade_app/components/grade_card.dart';
import 'package:grade_app/components/grade_dialog.dart';
import 'package:grade_app/controller/grades.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:grade_app/controller/subjects.dart';

class SubjectScreen extends StatelessWidget {
  final String subjectKey;
  SubjectScreen({super.key, required this.subjectKey});

  final box = Hive.box<Subjects>('subjects');
  final gradeBox = Hive.box<Grades>('grades');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
          context: context,
          builder: (context) => GradeDialog(
            subjectKey: subjectKey,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 150,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "${box.get(subjectKey)?.calculateWeightedMean()}",
                    style: GoogleFonts.inter(
                      fontSize: 40,
                    ),
                  ),
                  Text(
                    "Votre moyenne en '${box.get(subjectKey)?.name.trim()}'",
                    style: GoogleFonts.inter(fontSize: 20, color: Colors.grey),
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: const Divider(),
            ),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: gradeBox.listenable(),
                builder: (context, Box gradebox, child) => ListView.builder(
                  padding: const EdgeInsets.all(40),
                  itemCount: box.get(subjectKey)!.grades.toList().length,
                  itemBuilder: (context, index) => GradeCard(
                    grade: box.get(subjectKey)!.grades.toList()[index],
                    subjectKey: subjectKey,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
