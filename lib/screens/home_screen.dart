import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grade_app/components/home/subjects_list.dart';
import 'package:grade_app/components/home/welcome_bar.dart';
import 'package:grade_app/models/subjects.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:collection/collection.dart';
import 'dart:developer';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String name = "mate";
  final box = Hive.box<Subjects>('subjects');

  double generalWeightedMean() {
    double wavg = 0;

    // This filter all empty means so it doesn't pollute the final GPA
    var list = box.values
        .toList()
        .where((element) => element.calculateWeightedMean() != null);

    for (Subjects e in list) {
      wavg = wavg +
          ((e.calculateWeightedMean()! * e.coefficient) /
              list.map((e) => e.coefficient).sum);
    }

    return num.parse(wavg.toStringAsFixed(2)).toDouble();
  }

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
              child: const Divider(
                height: 1,
                color: Colors.grey,
                thickness: 1,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  ValueListenableBuilder(
                    valueListenable: box.listenable(),
                    builder: (context, Box value, child) => Text(
                      '${generalWeightedMean()}',
                      style: GoogleFonts.inter(fontSize: 40),
                    ),
                  ),
                  const Text('Your GPA')
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
            SubjectsList(),
          ],
        ),
      ),
    );
  }
}
