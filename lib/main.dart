import 'package:aerobic_space/database.dart';
import 'package:aerobic_space/pages/loading_page.dart';
import 'package:aerobic_space/widgets/judge_profile.dart';
import 'package:aerobic_space/widgets/judges_table.dart';
import 'package:aerobic_space/widgets/performance_detail.dart';
import 'package:aerobic_space/widgets/performances_table.dart';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool loaded = false;

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'AerobicSpace',

    theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
    home: loaded
        ? BasePage()
        : LoadingPage(
            future: Future.delayed(Duration(seconds: 1)),
            onFinish: () => setState(() => loaded = true),
          ),
  );
}

class BasePage extends StatefulWidget {
  const BasePage({super.key});

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: Text("AerobicSpace"),
      bottom: PreferredSize(
        preferredSize: .fromHeight(48),
        child: Container(color: Colors.white, child: createTabBar(context)),
      ),
    ),
    body: createTabView(),
    floatingActionButton: FloatingActionButton(
      onPressed: () {},
      tooltip: 'Increment',
      child: const Icon(Icons.add),
    ),
  );

  TabBarView createTabView() {
    return TabBarView(
      controller: _tabController,
      children: [
        JudgesTable(
          judges: List.generate(
            4,
            (i) => Referee(
              id: i,
              fio: "Ivan Ivanov",
              region: "RUSSIA",
              city: "Tyuomen",
            ),
          ),
        ),
        PerformancesTable(
          competitions: .generate(
            2,
            (i) => Performance(
              id: i,
              region: 'Region',
              city: "Tyomen",
              title: "Tests",
              ageCategory: '17-19',
              discipline: 'AW',
              country: 'RUSSIA',
            ),
          ),
        ),
        PerformanceDetail(
          performance: Performance(
            id: 1,
            region: 'Region',
            city: "Tyomen",
            title: "Tests",
            ageCategory: '17-19',
            discipline: 'AW',
            country: 'RUSSIA',
          ),
          referees: .generate(
            3,
            (e) =>
                Referee(id: e, fio: "I.i. asd", region: "Cit", city: "Tyomen"),
          ),
        ),
      ],
    );
  }

  TabBar createTabBar(BuildContext context) {
    return TabBar(
      controller: _tabController,
      indicatorColor: Theme.of(context).colorScheme.primary,
      tabs: const [
        Tab(text: 'Судьи'),
        Tab(text: 'Соревнования'),
        Tab(text: 'Detail'),
      ],
    );
  }
}

void main() => runApp(const MyApp());
