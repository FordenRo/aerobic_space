import 'package:aerobic_space/database.dart';
import 'package:flutter/material.dart';

class PerformanceDetail extends StatefulWidget {
  final Performance performance;
  final List<Referee> referees;

  const PerformanceDetail({
    super.key,
    required this.performance,
    required this.referees,
  });

  @override
  State<PerformanceDetail> createState() => _PerformanceDetailState();
}

class _PerformanceDetailState extends State<PerformanceDetail> {
  String? _selectedDiscipline;
  String? _selectedAge;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text(
          widget.performance.title,
          style: const TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          TextButton.icon(
            onPressed: () {
              setState(() {
                _selectedDiscipline = null;
                _selectedAge = null;
              });
            },
            icon: const Icon(Icons.filter_list_off, color: Colors.blue),
            label: const Text(
              'Показать всех',
              style: TextStyle(color: Colors.blue),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Padding(
        padding: .all(16.0),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Row(
              children: [
                Expanded(
                  child: _buildSummaryCard(
                    'Средняя оценка',
                    '8.45',
                    Icons.star,
                    Colors.amber,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildSummaryCard(
                    'Точность бригады',
                    '92%',
                    Icons.check_circle,
                    Colors.green,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildSummaryCard(
                    'Коэф. Девиации',
                    '0.12',
                    Icons.analytics,
                    Colors.blue,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            Text(
              'Фильтр категорий',
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: .bold),
            ),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: .horizontal,
              child: Row(
                children: [
                  // Фильтр по Дисциплинам
                  // ...widget.disciplines.map(
                  //   (d) => Padding(
                  //     padding: const .only(right: 8.0),
                  //     child: FilterChip(
                  //       label: Text(d),
                  //       selected: _selectedDiscipline == d,
                  //       onSelected: (val) => setState(
                  //         () => _selectedDiscipline = val ? d : null,
                  //       ),
                  //       backgroundColor: Colors.white,
                  //       selectedColor: Colors.blue.shade50,
                  //       checkmarkColor: Colors.blue,
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(width: 16),
                  // // Фильтр по Возрасту
                  // ...widget.ageCategories.map(
                  //   (a) => Padding(
                  //     padding: const .only(right: 8.0),
                  //     child: FilterChip(
                  //       label: Text(a),
                  //       selected: _selectedAge == a,
                  //       onSelected: (val) =>
                  //           setState(() => _selectedAge = val ? a : null),
                  //       backgroundColor: Colors.white,
                  //       selectedColor: Colors.purple.shade50,
                  //       checkmarkColor: Colors.purple,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // --- 3. Таблица судей ---
            Expanded(
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: .circular(12),
                  side: BorderSide(color: Colors.grey.shade200),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: .symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: .vertical(top: .circular(12)),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text(
                              'Судья',
                              style: TextStyle(
                                fontWeight: .bold,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              'Ср. Оценка',
                              style: TextStyle(
                                fontWeight: .bold,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              'Точность',
                              style: TextStyle(
                                fontWeight: .bold,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              'Девиация',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              'Предвзятость',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Список
                    // Expanded(
                    //   child: ListView.builder(
                    //     itemCount: _filteredJudges.length,
                    //     itemBuilder: (context, index) {
                    //       final judge = _filteredJudges[index];
                    //       return _buildJudgeRow(judge, theme);
                    //     },
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const .all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: .circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: .03), blurRadius: 5),
        ],
      ),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          Text(
            value,
            style: TextStyle(fontSize: 20, fontWeight: .bold, color: color),
          ),
        ],
      ),
    );
  }

  Widget _buildJudgeRow(Referee judge, ThemeData theme) => Container(
    padding: const .symmetric(horizontal: 16, vertical: 12),
    decoration: BoxDecoration(
      border: Border(bottom: BorderSide(color: Colors.grey.shade100)),
    ),
    child: Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(judge.fio, style: const TextStyle(fontWeight: .w500)),
        ),
        Expanded(
          flex: 2,
          child: Text('1.00'), // judge.avgScore.toStringAsFixed(2)
        ),
        Expanded(
          flex: 2,
          child: _buildAccuracyIndicator(0.8), // judge.accuracy
        ),
        Expanded(
          flex: 2,
          child: Text('0.6'), // judge.deviationCoeff.toStringAsFixed(2)
        ),
        Expanded(
          flex: 2,
          child: _buildBiasIndicator(0.6), // judge.biasIndex
        ),
      ],
    ),
  );

  Widget _buildAccuracyIndicator(double percent) {
    Color c = percent > 90
        ? Colors.green
        : (percent > 75 ? Colors.orange : Colors.red);
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: c, shape: .circle),
        ),
        const SizedBox(width: 6),
        Text('${percent.toInt()}%'),
      ],
    );
  }

  Widget _buildBiasIndicator(double bias) {
    // Если предвзятость близка к 0 - зеленый, иначе красный
    Color c = bias.abs() < 0.2 ? Colors.green : Colors.red;
    return Text(
      bias.toStringAsFixed(2),
      style: TextStyle(color: c, fontWeight: .bold),
    );
  }
}
