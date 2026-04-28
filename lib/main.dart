import 'package:aerobic_space/database.dart';
import 'package:aerobic_space/widgets/judge_profile.dart';
import 'package:aerobic_space/widgets/judges_table.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'AerobicSpace',
    theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
    home: FutureBuilder(
      future: (() async {
        await Future.delayed(const Duration(seconds: 2));

        return 1;
      })(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // return BasePage();
          return JudgeProfileWidget(
            data: JudgeProfileData(fio: "ASd", biasIndex: 0, accuracyScore: 80),
          );
        }

        return const CircularProgressIndicator();
      },
    ),
  );
}

class BasePage extends StatelessWidget {
  const BasePage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: Text("AerobicSpace"),
    ),
    body: Center(
      child: JudgesTable(
        judges: List.generate(
          4,
          (x) => Referee(
            id: x,
            fio: "Ivan Ivanov",
            region: "RUSSIA",
            city: "Tyuomen",
          ),
        ),
      ),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () {},
      tooltip: 'Increment',
      child: const Icon(Icons.add),
    ),
  );
}

void main() => runApp(const MyApp());
