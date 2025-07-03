import 'package:expensify/modals/expense_modal.dart';
import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';

const startAlignment = Alignment.topCenter;
const endAlignment = Alignment.bottomCenter;

class ExpenseChart extends StatelessWidget {
  final Map<dynamic, double> data;

  const ExpenseChart(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    final maxAmount = data.values.fold(0.0, (a, b) => a > b ? a : b);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      height: 270,
      width: 390,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 2,
            offset: Offset(0, 3),
            spreadRadius: 1.0,
          )
        ],
        gradient: LinearGradient(
          colors: [
            Colors.blueGrey.withOpacity(0.3),
            Colors.blueAccent.withOpacity(0.7),
          ],
          begin: startAlignment,
          end: endAlignment,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: data.entries.map((entry) {
          final value = entry.value;
          final percent = maxAmount == 0 ? 0.0 : value / maxAmount;
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 180,
                width: 70,
                decoration: BoxDecoration(
                    borderRadius: isDark
                        ? BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10),
                          )
                        : BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10),
                          ),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: isDark
                          ? [Colors.black54, Colors.blue[800]!]
                          : [Colors.white60, Colors.blue[200]!],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: isDark
                            ? Colors.black12
                            : Colors.black.withOpacity(0.15),
                        offset: isDark ? Offset(0, 4) : Offset(0, 4),
                        blurRadius: 2,
                        spreadRadius: 1,
                      )
                    ]),
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        ),
                      ),
                    ),
                    TweenAnimationBuilder<double>(
                        duration: Duration(milliseconds: 800),
                        tween: Tween(begin: 0.0, end: percent),
                        builder: (context, value, child) {
                          return Align(
                            alignment: Alignment.bottomCenter,
                            child: ClipRRect(
                              child: SizedBox(
                                height: 120 * percent,
                                child: LiquidLinearProgressIndicator(
                                  value: 1.0,
                                  direction: Axis.vertical,
                                  backgroundColor: Colors.transparent,
                                  valueColor: AlwaysStoppedAnimation(
                                      _getCategoryColor(entry.key)),
                                ),
                              ),
                            ),
                          );
                        }),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Icon(
                _getCategoryIcon(entry.key),
                color: isDark ? Colors.black87 : Colors.blue[800],
                size: 24,
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Color _getCategoryColor(Category category) {
    switch (category) {
      case Category.food:
      case Category.work:
      case Category.travel:
      case Category.shopping:
        return Colors.blue.shade800;
    }
  }

  IconData _getCategoryIcon(Category category) {
    switch (category) {
      case Category.food:
        return Icons.restaurant;
      case Category.work:
        return Icons.work;
      case Category.shopping:
        return Icons.shopping_bag;
      case Category.travel:
        return Icons.flight;
    }
  }
}
// import 'modals/expense_modal.dart';
//
// // enum Category { food , work , travel , leisure}
//
// class ExpenseBarChart extends StatelessWidget{
//   final Map<dynamic, double> categoryTotals;
//   const ExpenseBarChart(this.categoryTotals,{super.key});
//
//   @override
//   Widget build(context) {
//     final maxTotal = categoryTotals.values.reduce( (a,b) => a > b ? a : b);
//     // final maxTotal = categoryTotals.values.fold(0.0, (prev, element) => element > prev ? element : prev);
//
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children:
//         categoryTotals.entries.map((entry){
//         final category = entry.key;
//         final total = entry.value;
//         final percent = maxTotal == 0 ? 0.0 : total / maxTotal;
//
//          return Column(
//            children: [
//              Container(
//                height: 150,
//                width: 50,
//                decoration: BoxDecoration(
//                  color: Colors.blue[800],
//                  borderRadius: BorderRadius.circular(5),
//                ),
//                child: FractionallySizedBox(
//                  alignment: Alignment.center,
//                    heightFactor: percent,
//                    child: Container(
//                      decoration: BoxDecoration(
//                       // color: _getCategoryColor(category),
//                        borderRadius: BorderRadius.vertical(
//                          bottom: Radius.circular(12),
//                        ),
//                      ),
//                    ),
//                  ),
//                ),
//              Icon(
//                _getCategoryIcon(category),
//              ),
//            ],
//          );
//         }).toList(),
//     );
//   }
// }
//
//
// // Color _getCategoryColor(Category category) {
// //   switch (category) {
// //     case Category.food:
// //       return Colors.redAccent;
// //     case Category.work:
// //       return Colors.blue;
// //     case Category.travel:
// //       return Colors.orange;
// //     case Category.leisure: // ✅ FIX
// //       return Colors.purple;
// //     default:
// //       return Colors.grey;
// //   }
// // }
//
// IconData _getCategoryIcon(Category category) {
//   switch (category) {
//     case Category.food:
//       return Icons.restaurant;
//     case Category.work:
//       return Icons.work;
//     case Category.travel:
//       return Icons.flight;
//     case Category.leisure: // ✅ FIX
//       return Icons.movie;
//     default:
//       return Icons.category;
//   }
// }
