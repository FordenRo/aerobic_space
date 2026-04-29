import 'package:flutter/material.dart';

class JudgeRegionHeatmap extends StatelessWidget {
  final List<String> judges;
  final List<String> regions;
  final Map<String, Map<String, double>>
  data; // [Judge][Region] = Value (e.g., Avg Score)

  const JudgeRegionHeatmap({
    super.key,
    required this.judges,
    required this.regions,
    required this.data,
  });

  // Функция для получения цвета в зависимости от значения (градиент)
  Color _getColor(double value, double min, double max) {
    // Нормализуем значение от 0 до 1
    double normalized = (value - min) / (max - min);
    if (normalized < 0) normalized = 0;
    if (normalized > 1) normalized = 1;

    return Color.lerp(Colors.blue.shade100, Colors.red.shade400, normalized)!;
  }

  @override
  Widget build(BuildContext context) {
    if (judges.isEmpty || regions.isEmpty) {
      return const Center(child: Text('Нет данных для тепловой карты'));
    }

    // Находим мин и макс для корректного масштабирования цветов
    double globalMin = double.infinity;
    double globalMax = double.negativeInfinity;

    for (var j in judges) {
      for (var r in regions) {
        double val = data[j]?[r] ?? 0;
        if (val < globalMin) globalMin = val;
        if (val > globalMax) globalMax = val;
      }
    }

    // Если все значения равны
    if (globalMin == globalMax) globalMax = globalMin + 1;

    return SingleChildScrollView(
      scrollDirection: .horizontal,
      child: Column(
        crossAxisAlignment: .start,
        children: [
          // Заголовки регионов (ось X)
          Padding(
            padding: .only(left: 100.0), // Отступ под имена судей
            child: Row(
              children: regions
                  .map(
                    (r) => SizedBox(
                      width: 60,
                      child: Text(
                        r.substring(0, r.length > 3 ? 3 : r.length),
                        textAlign: .center,
                        style: const TextStyle(fontSize: 10, fontWeight: .bold),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),

          // Строки судей
          ...judges.map((judge) {
            return Row(
              children: [
                // Имя судьи (ось Y)
                SizedBox(
                  width: 100,
                  child: Text(
                    judge,
                    overflow: .ellipsis,
                    style: const TextStyle(fontSize: 12, fontWeight: .w500),
                  ),
                ),
                // Ячейки
                ...regions.map((region) {
                  double value = data[judge]?[region] ?? 0;
                  return Container(
                    width: 60,
                    height: 40,
                    margin: .all(1),
                    decoration: BoxDecoration(
                      color: _getColor(value, globalMin, globalMax),
                      borderRadius: .circular(4),
                    ),
                    child: Center(
                      child: Text(
                        value.toStringAsFixed(1),
                        style: TextStyle(
                          fontSize: 10,
                          color: _getTextColor(
                            _getColor(value, globalMin, globalMax),
                          ),
                          fontWeight: .bold,
                        ),
                      ),
                    ),
                  );
                }),
              ],
            );
          }),
        ],
      ),
    );
  }

  // Определение цвета текста для контраста
  Color _getTextColor(Color bg) {
    // Простая эвристика: если фон темный (красный), текст белый, иначе черный
    return bg.computeLuminance() < 0.5 ? Colors.white : Colors.black87;
  }
}
