import 'package:flutter/material.dart';
import 'package:grade_app/components/subject_card.dart';
import 'package:grade_app/controller/grades.dart';
import 'package:grade_app/controller/subjects.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(SubjectsAdapter());
  Hive.registerAdapter(GradesAdapter());

  await Hive.openBox<Subjects>("subjects");
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

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String name = "John";

  final Subjects maths = Subjects(
    name: "Maths",
    grades: <Grades>[
      Grades(grade: 18.0, coefficient: 1.0),
      Grades(grade: 14.0, coefficient: 2.0)
    ],
    coefficient: 1.0,
  );

  final box = Hive.box<Subjects>('subjects');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
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
                    onPressed: () => box.put(maths.name.toLowerCase(), maths),
                    icon: const Icon(Icons.settings),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 40),
              width: MediaQuery.of(context).size.width,
              height: 1,
              decoration: const BoxDecoration(color: Colors.grey),
            ),
            Expanded(
              child: ListView.separated(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 40,
                  ),
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: box.length,
                  itemBuilder: (context, index) {
                    final list = box.values.toList();
                    return SubjectCard(
                      subject: list[index],
                    );
                  }),
            ),
            Center(
              child: IconButton(
                icon: Icon(Icons.access_alarm),
                onPressed: () => box.clear(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
