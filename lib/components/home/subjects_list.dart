import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:grade_app/models/subjects.dart';

import '../subject_card.dart';

class SubjectsList extends StatelessWidget {
  SubjectsList({super.key});
  final box = Hive.box<Subjects>('subjects');

  final Tween<Offset> _offset =
      Tween(begin: const Offset(1, 0), end: const Offset(0, 0));

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (context, Box<Subjects> subjectsbox, _) => ListView.separated(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 40,
          ),
          itemCount: subjectsbox.length,
          separatorBuilder: (context, index) => const SizedBox(
            height: 20,
          ),
          itemBuilder: (context, index) {
            final list = subjectsbox.values.toList();
            return SubjectCard(
              subject: list[index],
            );
          },
        ),
      ),
    );
  }
}
