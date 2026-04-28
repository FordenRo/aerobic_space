import 'package:aerobic_space/database.dart';
import 'package:flutter/material.dart';

class JudgesTable extends StatefulWidget {
  final List<Referee> judges;
  final Function(Referee)? onJudgeSelected;

  const JudgesTable({super.key, required this.judges, this.onJudgeSelected});

  @override
  State<JudgesTable> createState() => _JudgesTableState();
}

class _JudgesTableState extends State<JudgesTable> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Фильтрация списка
  List<Referee> get _filteredJudges {
    if (_searchQuery.isEmpty) {
      return widget.judges;
    }
    final queryLower = _searchQuery.toLowerCase();
    return widget.judges.where((judge) {
      return judge.fio.toLowerCase().contains(queryLower);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- Блок поиска ---
        Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextField(
            controller: _searchController,
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
            decoration: InputDecoration(
              icon: Icon(Icons.search, color: Colors.grey.shade600),
              hintText: 'Поиск судьи по ФИО...',
              hintStyle: TextStyle(color: Colors.grey.shade500),
              border: InputBorder.none,
              suffixIcon: _searchQuery.isNotEmpty
                  ? IconButton(
                      icon: Icon(
                        Icons.clear,
                        size: 20,
                        color: Colors.grey.shade600,
                      ),
                      onPressed: () {
                        _searchController.clear();
                        setState(() {
                          _searchQuery = '';
                        });
                      },
                    )
                  : null,
              contentPadding: const EdgeInsets.symmetric(vertical: 14),
            ),
          ),
        ),

        // --- Таблица (используем логику из предыдущего ответа) ---
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                // Заголовок таблицы
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(flex: 1, child: _buildHeaderCell('ID', theme)),
                      Expanded(
                        flex: 3,
                        child: _buildHeaderCell('ФИО Судьи', theme),
                      ),
                      Expanded(
                        flex: 2,
                        child: _buildHeaderCell('Регион', theme),
                      ),
                      Expanded(
                        flex: 2,
                        child: _buildHeaderCell('Город', theme),
                      ),
                    ],
                  ),
                ),

                // Данные
                Expanded(
                  child: _filteredJudges.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.search_off,
                                size: 48,
                                color: Colors.grey.shade300,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Судьи не найдены',
                                style: TextStyle(color: Colors.grey.shade600),
                              ),
                            ],
                          ),
                        )
                      : ListView.separated(
                          itemCount: _filteredJudges.length,
                          separatorBuilder: (context, index) => Divider(
                            height: 1,
                            color: Colors.grey.shade200,
                            indent: 24,
                            endIndent: 24,
                          ),
                          itemBuilder: (context, index) {
                            final judge = _filteredJudges[index];
                            return MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: () =>
                                    widget.onJudgeSelected?.call(judge),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 16,
                                  ),
                                  color: Colors.transparent,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: _buildDataCell(
                                          judge.id.toString(),
                                          theme,
                                          isId: true,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: _buildDataCell(
                                          judge.fio,
                                          theme,
                                          isPrimary: true,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: _buildDataCell(
                                          judge.region,
                                          theme,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: _buildDataCell(
                                          judge.city,
                                          theme,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ),

        // Инфо о количестве найденных записей (опционально)
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            'Найдено судей: ${_filteredJudges.length}',
            style: theme.textTheme.bodySmall?.copyWith(
              color: Colors.grey.shade600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeaderCell(String text, ThemeData theme) {
    return Text(
      text.toUpperCase(),
      style: theme.textTheme.labelSmall?.copyWith(
        color: Colors.grey.shade600,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildDataCell(
    String text,
    ThemeData theme, {
    bool isPrimary = false,
    bool isId = false,
  }) {
    return Text(
      text,
      style: theme.textTheme.bodyMedium?.copyWith(
        color: isPrimary ? Colors.black87 : Colors.black54,
        fontWeight: isPrimary ? FontWeight.w600 : FontWeight.normal,
        fontSize: isId ? 12 : 14,
      ),
      overflow: TextOverflow.ellipsis,
    );
  }
}
