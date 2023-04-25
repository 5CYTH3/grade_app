import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:grade_app/controller/subjects.dart';

import '../subject_card.dart';

class SubjectsList extends StatelessWidget {
  SubjectsList({super.key});
  final box = Hive.box<Subjects>('subjects');

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
            separatorBuilder: (context, index) => const Divider(),
            itemCount: subjectsbox.length,
            itemBuilder: (context, index) {
              final list = subjectsbox.values.toList();
              return SubjectCard(
                subject: list[index],
              );
            }),
      ),
    );
  }
}
