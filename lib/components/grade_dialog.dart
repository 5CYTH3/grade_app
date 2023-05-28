import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grade_app/models/grades.dart';

import 'package:hive_flutter/hive_flutter.dart';

import 'package:grade_app/models/subjects.dart';

class GradeDialog extends StatefulWidget {
  const GradeDialog({super.key, required this.subjectKey});
  final String subjectKey;

  @override
  State<GradeDialog> createState() => _GradeDialogState();
}

class _GradeDialogState extends State<GradeDialog> {
  final box = Hive.box<Subjects>('subjects');

  final gradeBox = Hive.box<Grades>('grades');

  final _formKey = GlobalKey<FormState>();

  void addNewGrade(double grade, double coeff) {
    final Grades gradePushed = Grades(
      grade: grade,
      coefficient: coeff,
    );
    gradeBox.add(gradePushed);
    box.get(widget.subjectKey)?.grades.add(gradePushed);
    box.get(widget.subjectKey)?.save();
  }

  final gradeController = TextEditingController();

  final coeffValueController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    gradeController.dispose();
    coeffValueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(20),
        height: 300,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                'Add a new grade',
                style: GoogleFonts.abel(fontSize: 30),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: gradeController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Grade',
                  border: OutlineInputBorder(),
                ),
                autocorrect: false,
                validator: (val) =>
                    (val == null || val.isEmpty) ? 'Enter a valid grade' : null,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: coeffValueController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Coefficient',
                  border: OutlineInputBorder(),
                ),
                autocorrect: false,
                validator: (val) => (val == null || val.isEmpty)
                    ? 'Enter a valid coefficient'
                    : null,
              ),
              TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    addNewGrade(
                      num.parse(gradeController.text).toDouble(),
                      num.parse(coeffValueController.text.trim()).toDouble(),
                    );
                    Navigator.of(context).pop();
                  }
                },
                style: ButtonStyle(
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
                child: const Text("Add"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
