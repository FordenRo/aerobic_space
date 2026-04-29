import 'package:aerobic_space/database.dart';
import 'package:aerobic_space/widgets/performance_detail.dart';
import 'package:aerobic_space/widgets/search_field.dart';
import 'package:aerobic_space/widgets/style_table.dart';
import 'package:flutter/material.dart';

class PerformancesTable extends StatefulWidget {
  final List<Performance> performances;
  final Function(Performance)? onTap;

  const PerformancesTable({super.key, required this.performances, this.onTap});

  @override
  State<PerformancesTable> createState() => _PerformancesTableState();
}

class _PerformancesTableState extends State<PerformancesTable> {
  String searchQuery = '';

  List<Performance> get performances => searchQuery.isNotEmpty
      ? widget.performances
            .where(
              (performance) => performance.title.toLowerCase().contains(
                searchQuery.toLowerCase(),
              ),
            )
            .toList()
      : widget.performances;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const .all(22),
    child: Column(
      crossAxisAlignment: .stretch,
      children: [
        SearchField(
          hint: 'Поиск соревнования',
          onChanged: (e) => setState(() => searchQuery = e),
        ),

        Expanded(
          child: StyleTable(
            columns: const ['Название', 'Страна', 'Город', 'Регион', 'Возраст'],
            rows: performances
                .map(
                  (e) => [e.title, e.country, e.city, e.region, e.ageCategory],
                )
                .toList(),
            onRowTap: (index) => showDialog(
              context: context,
              builder: (context) => Padding(
                padding: const .all(40),
                child: PerformanceDetail(
                  performance: performances[index],
                  referees: [],
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );

  Widget accuracyCell(double percent, ThemeData theme) {
    final color = percent >= 90
        ? Colors.green
        : percent >= 75
        ? Colors.orange
        : Colors.red;

    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: .circle),
        ),
        const SizedBox(width: 8),
        Text('${percent.toStringAsFixed(1)}%'),
      ],
    );
  }
}
