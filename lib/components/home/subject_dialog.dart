import 'package:flutter/material.dart';
import 'package:grade_app/controller/grades.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:grade_app/controller/subjects.dart';

class SubjectDialog extends StatefulWidget {
  const SubjectDialog({super.key});

  @override
  State<SubjectDialog> createState() => _SubjectDialogState();
}

class _SubjectDialogState extends State<SubjectDialog> {
  final box = Hive.box<Subjects>('subjects');
  final gradeBox = Hive.box<Grades>('grades');

  final _formKey = GlobalKey<FormState>();

  Future<void> addNewSubject(String name, double coeff) {
    final Subjects subject = Subjects(
      name: name,
      coefficient: coeff,
      grades: HiveList(gradeBox),
    );
    return box.put(subject.name.toLowerCase(), subject);
  }

  final subjectNameController = TextEditingController();
  final coeffValueController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    subjectNameController.dispose();
    coeffValueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(10),
        height: 400,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: subjectNameController,
                autocorrect: false,
                validator: (val) =>
                    (val == null || val.isEmpty) ? 'Enter a valid name' : null,
              ),
              TextFormField(
                controller: coeffValueController,
                keyboardType: TextInputType.number,
                autocorrect: false,
                validator: (val) =>
                    (val == null || val.isEmpty) ? 'Enter a valid name' : null,
              ),
              MaterialButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    addNewSubject(
                      subjectNameController.text,
                      num.parse(coeffValueController.text.trim()).toDouble(),
                    );
                    Navigator.of(context).pop();
                  }
                },
                child: const Text("Submit"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
