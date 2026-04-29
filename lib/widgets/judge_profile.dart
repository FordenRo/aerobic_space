// import 'package:flutter/material.dart';

// class JudgeProfileData {
//   final String fio;
//   final double biasIndex;
//   final double accuracyScore;

//   JudgeProfileData({
//     required this.fio,
//     required this.biasIndex,
//     required this.accuracyScore,
//   });
// }

// double getAllowableDeviation(double score) {
//   if (score >= 8.0) return 0.3;
//   if (score >= 7.0) return 0.4;
//   if (score >= 6.0) return 0.5;
//   return 0.6;
// }

// String getAccuracyCategory(double deviation, double allowable) {
//   if (deviation == 0) return "В яблочко";
//   if (deviation <= allowable) return "Допустимое";
//   return "Серьезное";
// }

// void test() {}

// JudgeProfileData calculateJudgeMetrics(
//   String judgeId,
//   List<Assessment> assessments,
//   List<Performance> performances,
// ) {
//   final perfMap = {for (var p in performances) p.id: p};

//   final myAssessments = assessments
//       .where((a) => a.refereeId == judgeId)
//       .toList();

//   if (myAssessments.isEmpty) {
//     return JudgeProfileData(fio: "Unknown", biasIndex: 0, accuracyScore: 0);
//   }

//   int accurateCount = 0;
//   for (var assess in myAssessments) {
//     double deviation = (assess.score - assess.finalScore).abs();
//     double allowable = getAllowableDeviation(
//       assess.finalScore,
//     ); // Или assess.score, зависит от методологии, обычно от итоговой
//     if (deviation <= allowable) accurateCount++;
//   }
//   double accuracyPercent = (accurateCount / myAssessments.length) * 100;

//   double sumDeviationOwn = 0;
//   int countOwn = 0;
//   double sumDeviationOther = 0;
//   int countOther = 0;

//   for (var assess in myAssessments) {
//     final perf = perfMap[assess.performanceId];
//     if (perf == null) continue;

//     bool isOwn = false;

//     double dev = (assess.score - assess.finalScore).abs();

//     if (isOwn) {
//       sumDeviationOwn += dev;
//       countOwn++;
//     } else {
//       sumDeviationOther += dev;
//       countOther++;
//     }
//   }

//   double avgDevOther = countOther > 0 ? sumDeviationOther / countOther : 0;
//   double avgDevOwn = countOwn > 0 ? sumDeviationOwn / countOwn : 0;

//   double biasIndex = avgDevOther - avgDevOwn;

//   return JudgeProfileData(
//     fio: "Иванов И.И.",
//     biasIndex: biasIndex,
//     accuracyScore: accuracyPercent,
//   );
// }

// class JudgeProfileWidget extends StatelessWidget {
//   final JudgeProfileData data;
//   final VoidCallback? onBack;

//   const JudgeProfileWidget({super.key, required this.data, this.onBack});

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     return Container(
//       padding: const EdgeInsets.all(24),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: .circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withValues(alpha: .05),
//             blurRadius: 15,
//             offset: const Offset(0, 5),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: .start,
//         children: [
//           Row(
//             children: [
//               if (onBack != null)
//                 IconButton(
//                   icon: const Icon(Icons.arrow_back_ios_new),
//                   onPressed: onBack,
//                 ),
//               CircleAvatar(
//                 radius: 30,
//                 backgroundColor: theme.colorScheme.primaryContainer,
//                 child: Text(
//                   data.fio.isNotEmpty ? data.fio[0] : 'J',
//                   style: TextStyle(
//                     fontSize: 24,
//                     color: theme.colorScheme.onPrimaryContainer,
//                     fontWeight: .bold,
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 16),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: .start,
//                   children: [
//                     Text(
//                       data.fio,
//                       style: theme.textTheme.headlineSmall?.copyWith(
//                         fontWeight: .bold,
//                       ),
//                     ),
//                     Text(
//                       'Судья исполнения / Артистизма',
//                       style: theme.textTheme.bodyMedium?.copyWith(
//                         color: Colors.grey.shade600,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 32),
//           Row(
//             children: [
//               Expanded(
//                 child: _metricCard(
//                   context,
//                   title: 'Точность оценок',
//                   value: '${data.accuracyScore.toStringAsFixed(1)}%',
//                   subtitle: _getAccuracyLabel(data.accuracyScore),
//                   color: _getAccuracyColor(data.accuracyScore),
//                   icon: Icons.assignment_rounded,
//                 ),
//               ),
//               const SizedBox(width: 16),
//               Expanded(
//                 child: _metricCard(
//                   context,
//                   title: 'Индекс предвзятости',
//                   value:
//                       '${data.biasIndex.isNegative ? '' : '+'}${data.biasIndex.toStringAsFixed(2)}',
//                   subtitle: _getBiasLabel(data.biasIndex),
//                   color: _getBiasColor(data.biasIndex),
//                   icon: Icons.balance,
//                 ),
//               ),
//             ],
//           ),

//           const SizedBox(height: 32),

//           Divider(color: Colors.grey.shade200),

//           const SizedBox(height: 16),

//           Text(
//             'Детальная статистика',
//             style: theme.textTheme.titleLarge?.copyWith(
//               fontWeight: FontWeight.bold,
//             ),
//           ),

//           const SizedBox(height: 16),

//           Container(
//             height: 200,
//             decoration: BoxDecoration(
//               color: Colors.grey.shade50,
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Center(
//               child: Text(
//                 'График отклонений по выступлениям',
//                 style: TextStyle(color: Colors.grey.shade400),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _metricCard(
//     BuildContext context, {
//     required String title,
//     required String value,
//     required String subtitle,
//     required Color color,
//     required IconData icon,
//   }) {
//     var textTheme = Theme.of(context).textTheme;

//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: color.withValues(alpha: .1),
//         borderRadius: BorderRadius.circular(16),
//         border: .all(color: color.withValues(alpha: .3)),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Icon(icon, color: color, size: 24),
//               Text(
//                 value,
//                 style: textTheme.headlineMedium?.copyWith(
//                   fontWeight: FontWeight.bold,
//                   color: color,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 8),
//           Text(
//             title,
//             style: textTheme.titleSmall?.copyWith(
//               color: Colors.grey.shade700,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           const SizedBox(height: 4),
//           Text(
//             subtitle,
//             style: textTheme.bodySmall?.copyWith(
//               color: color,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Color _getAccuracyColor(double percent) {
//     if (percent >= 90) return Colors.green;
//     if (percent >= 70) return Colors.orange;
//     return Colors.red;
//   }

//   String _getAccuracyLabel(double percent) {
//     if (percent >= 90) return 'Высокая точность';
//     if (percent >= 70) return 'Средняя точность';
//     return 'Низкая точность';
//   }

//   Color _getBiasColor(double index) {
//     double absBias = index.abs();
//     if (absBias < 0.1) return Colors.green;
//     if (absBias < 0.5) return Colors.orange;
//     return Colors.red;
//   }

//   String _getBiasLabel(double index) {
//     if (index.abs() < 0.1) return 'Объективен';
//     if (index > 0.5) return 'Лоялен к "своим"';
//     if (index < -0.5) return 'Строг к "своим"';
//     return 'Нейтрален';
//   }
// }
