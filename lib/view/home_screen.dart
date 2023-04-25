import 'package:flutter/material.dart';
import 'package:grade_app/components/home/subjects_list.dart';
import 'package:grade_app/components/home/welcome_bar.dart';
import 'package:grade_app/controller/subjects.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String name = "John";
  final box = Hive.box<Subjects>('subjects');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            WelcomeBar(
              name: name,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 40),
              width: MediaQuery.of(context).size.width,
              height: 1,
              decoration: const BoxDecoration(color: Colors.grey),
            ),
            SubjectsList(),
            Center(
              child: IconButton(
                icon: const Icon(Icons.access_alarm),
                onPressed: () => box.clear(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
