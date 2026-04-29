import 'package:aerobic_space/database.dart';
import 'package:flutter/material.dart';

class PerformancesTable extends StatefulWidget {
  final List<Performance> competitions;
  final Function(Performance)? onCompetitionTap;

  const PerformancesTable({
    super.key,
    required this.competitions,
    this.onCompetitionTap,
  });

  @override
  State<PerformancesTable> createState() => _PerformancesTableState();
}

class _PerformancesTableState extends State<PerformancesTable> {
  final TextEditingController textController = TextEditingController();
  String searchQuery = '';

  bool isAscending = true;
  int sortColumn = 0;

  List<Performance> get fields {
    var list = widget.competitions.where((e) {
      return e.title.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    list.sort(
      (a, b) =>
          switch (sortColumn) {
            0 => a.title.compareTo(b.title),
            1 => a.country.compareTo(b.country),
            2 => a.city.compareTo(b.city),
            3 => a.region.compareTo(b.region),
            4 => a.ageCategory.compareTo(b.ageCategory),
            _ => 0,
          } *
          (isAscending ? 1 : -1),
    );
    return list;
  }

  void sort<T>(
    Comparable<T> Function(Performance c) getField,
    int columnIndex,
    bool ascending,
  ) {
    setState(() {
      sortColumn = columnIndex;
      isAscending = ascending;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Padding(
          padding: const .only(bottom: 16.0),
          child: TextField(
            controller: textController,
            onChanged: (v) => setState(() => searchQuery = v),
            decoration: InputDecoration(
              hintText: 'Поиск соревнования...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: searchQuery.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        textController.clear();
                        setState(() => searchQuery = '');
                      },
                    )
                  : null,
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: .circular(12),
                borderSide: .none,
              ),
              contentPadding: .symmetric(horizontal: 16, vertical: 14),
            ),
          ),
        ),

        Expanded(
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: .circular(12)),
            child: SingleChildScrollView(
              scrollDirection: .horizontal,
              child: DataTable(
                headingRowColor: .all(Colors.grey.shade100),
                dataRowMaxHeight: 60,
                sortColumnIndex: sortColumn,
                sortAscending: isAscending,
                columns: [
                  DataColumn(
                    label: const Text('Название'),
                    onSort: (i, asc) => sort((e) => e.title, i, asc),
                  ),
                  DataColumn(
                    label: const Text('Страна'),
                    onSort: (i, asc) => sort((c) => c.country, i, asc),
                  ),
                  DataColumn(
                    label: const Text('Город'),
                    onSort: (i, asc) => sort((c) => c.city, i, asc),
                  ),
                  DataColumn(
                    label: const Text('Регион'),
                    onSort: (i, asc) => sort((c) => c.region, i, asc),
                  ),
                  DataColumn(
                    label: const Text('Категория'),
                    onSort: (i, asc) => sort((c) => c.ageCategory, i, asc),
                  ),
                ],
                rows: fields.map((e) {
                  return DataRow(
                    onSelectChanged: widget.onCompetitionTap != null
                        ? (selected) {
                            if (selected == true) {
                              widget.onCompetitionTap!(e);
                            }
                          }
                        : null,
                    cells: [
                      DataCell(
                        Text(
                          e.title,
                          style: const TextStyle(fontWeight: .w500),
                        ),
                      ),
                      DataCell(
                        Container(
                          padding: const .symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: e.country == 'RUSSIA'
                                ? Colors.blue.shade50
                                : Colors.grey.shade100,
                            borderRadius: .circular(4),
                          ),
                          child: Text(
                            e.country,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: .bold,
                              color: e.country == 'RUSSIA'
                                  ? Colors.blue.shade700
                                  : Colors.grey.shade700,
                            ),
                          ),
                        ),
                      ),
                      DataCell(Text(e.city)),
                      DataCell(Text(e.region)),
                      DataCell(Text(e.ageCategory)),
                      // DataCell(Text(_formatDate(comp.date))),
                      // DataCell(
                      //   _buildAccuracyCell(comp.executionAccuracy, theme),
                      // ),
                      // DataCell(
                      //   _buildAccuracyCell(comp.artisticAccuracy, theme),
                      // ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ),

        // Инфо о количестве
        Padding(
          padding: const .only(top: 8.0),
          child: Align(
            alignment: .centerRight,
            child: Text(
              'Всего: ${fields.length}',
              style: theme.textTheme.bodySmall?.copyWith(
                color: Colors.grey.shade600,
              ),
            ),
          ),
        ),
      ],
    );
  }

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

  String formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}';
  }
}
