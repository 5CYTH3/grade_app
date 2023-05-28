import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grade_app/components/grade_card.dart';
import 'package:grade_app/components/grade_dialog.dart';
import 'package:grade_app/models/grades.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:grade_app/models/subjects.dart';

class SubjectScreen extends StatelessWidget {
  final String subjectKey;
  SubjectScreen({super.key, required this.subjectKey});

  final box = Hive.box<Subjects>('subjects');
  final gradeBox = Hive.box<Grades>('grades');

  // Need to implement animations
  // Need to implement deleting
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => showDialog(
          context: context,
          builder: (context) => GradeDialog(
            subjectKey: subjectKey,
          ),
        ),
      ),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              box.delete(subjectKey);
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.delete),
          )
        ],
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
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
                  ValueListenableBuilder(
                    valueListenable: box.listenable(),
                    builder: (context, Box value, child) => Text(
                      "${value.get(subjectKey)?.calculateWeightedMean()}",
                      style: GoogleFonts.inter(
                        fontSize: 40,
                      ),
                    ),
                  ),
                  Text(
                    "Your '${box.get(subjectKey)?.name.trim()}' average",
                    style: GoogleFonts.inter(fontSize: 20, color: Colors.grey),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 40),
              child: const Divider(
                height: 1,
                color: Colors.grey,
                thickness: 1,
              ),
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
