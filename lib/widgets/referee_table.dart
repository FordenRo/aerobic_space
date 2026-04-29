import 'package:aerobic_space/database.dart';
import 'package:aerobic_space/widgets/referee_profile.dart';
import 'package:aerobic_space/widgets/search_field.dart';
import 'package:aerobic_space/widgets/style_table.dart';
import 'package:flutter/material.dart';

class RefereesTable extends StatefulWidget {
  final List<Referee> referees;
  final Function(Referee)? onJudgeSelected;

  const RefereesTable({
    super.key,
    required this.referees,
    this.onJudgeSelected,
  });

  @override
  State<RefereesTable> createState() => _RefereesTableState();
}

class _RefereesTableState extends State<RefereesTable> {
  String searchQuery = '';

  List<Referee> get referees => searchQuery.isNotEmpty
      ? widget.referees
            .where(
              (referee) =>
                  referee.fio.toLowerCase().contains(searchQuery.toLowerCase()),
            )
            .toList()
      : widget.referees;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const .all(22),
    child: Column(
      crossAxisAlignment: .stretch,
      children: [
        SearchField(
          hint: 'Поиск судьи',
          onChanged: (e) => setState(() => searchQuery = e),
        ),

        Expanded(
          child: StyleTable(
            columns: const ['ФИО', 'Регион', 'Город'],
            rows: referees.map((e) => [e.fio, e.region, e.city]).toList(),
            onRowTap: (index) => showDialog(
              context: context,
              builder: (context) => Padding(
                padding: const .all(40),
                child: JudgeProfileWidget(
                  referee: referees[index],
                  assessments: [],
                  performances: [],
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
