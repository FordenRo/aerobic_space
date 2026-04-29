import 'package:aerobic_space/database.dart';
import 'package:aerobic_space/widgets/referee_table.dart';
import 'package:aerobic_space/widgets/performances_table.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      leading: Padding(
        padding: const .symmetric(horizontal: 8),
        child: Image.asset('assets/logo.png'),
      ),
      leadingWidth: 50,
      titleSpacing: 0,
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: const Text('Aerobic.Space'),
      bottom: PreferredSize(
        preferredSize: const .fromHeight(48),
        child: Container(color: Colors.white, child: createTabBar(context)),
      ),
    ),
    body: createBody(),
  );

  TabBarView createBody() => TabBarView(
    controller: tabController,
    children: [
      RefereesTable(
        referees: List.generate(
          4,
          (i) => Referee(
            id: i,
            fio: 'Ivan Ivanov',
            region: 'RUSSIA',
            city: 'Tyuomen',
          ),
        ),
      ),
      PerformancesTable(
        performances: .generate(
          2,
          (i) => Performance(
            id: i,
            region: 'Region',
            city: 'Tyomen',
            title: 'Tests',
            ageCategory: '17-19',
            discipline: 'AW',
            country: 'RUSSIA',
          ),
        ),
      ),
      // PerformanceDetail(
      //   performance: Performance(
      //     id: 1,
      //     region: 'Region',
      //     city: 'Tyomen',
      //     title: 'Tests',
      //     ageCategory: '17-19',
      //     discipline: 'AW',
      //     country: 'RUSSIA',
      //   ),
      //   referees: .generate(
      //     3,
      //     (e) => Referee(id: e, fio: 'I.i. asd', region: 'Cit', city: 'Tyomen'),
      //   ),
      // ),
    ],
  );

  TabBar createTabBar(BuildContext context) => TabBar(
    controller: tabController,
    indicatorColor: Theme.of(context).colorScheme.primary,
    tabs: const [
      Tab(text: 'Судьи'),
      Tab(text: 'Соревнования'),
      // Tab(text: 'Detail'),
    ],
  );
}
