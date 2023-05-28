import 'package:flutter/material.dart';
import 'package:grade_app/models/grades.dart';
import 'package:grade_app/models/subjects.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'screens/home_screen.dart';

void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(SubjectsAdapter());
  Hive.registerAdapter(GradesAdapter());

  await Hive.openBox<Subjects>("subjects");
  await Hive.openBox<Grades>("grades");

  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
