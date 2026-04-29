import 'package:flutter/material.dart';

class StyleTable extends StatefulWidget {
  final List<String> columns;
  final List<List<Comparable<Object>>> rows;
  final void Function(int index)? onRowTap;

  const StyleTable({
    super.key,
    required this.columns,
    required this.rows,
    this.onRowTap,
  });

  @override
  State<StyleTable> createState() => _StyleTableState();
}

class _StyleTableState extends State<StyleTable> {
  int sortIndex = 0;
  bool sortAscending = false;

  List<List<Comparable<Object>>> get rows {
    var list = List.of(widget.rows);
    list.sort(
      (a, b) => a[sortIndex].compareTo(b[sortIndex]) * (sortAscending ? 1 : -1),
    );
    return list;
  }

  @override
  Widget build(BuildContext context) => Card(
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: .circular(12)),
    child: SingleChildScrollView(
      scrollDirection: .vertical,
      child: DataTable(
        showCheckboxColumn: false,
        headingRowColor: .all(Colors.grey.shade100),
        sortColumnIndex: sortIndex,
        sortAscending: sortAscending,
        columns: widget.columns
            .map(
              (e) => DataColumn(
                label: Text(e),
                onSort: (index, ascending) => setState(() {
                  sortIndex = index;
                  sortAscending = ascending;
                }),
              ),
            )
            .toList(),
        rows: rows
            .map(
              (e) => DataRow(
                onSelectChanged: widget.onRowTap != null
                    ? (_) => widget.onRowTap!(rows.indexOf(e))
                    : null,
                cells: e.map((c) => DataCell(Text(c.toString()))).toList(),
              ),
            )
            .toList(),
      ),
    ),
  );
}
