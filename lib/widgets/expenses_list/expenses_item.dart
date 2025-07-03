import 'package:expensify/modals/expense_modal.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExpensesItem extends StatelessWidget {
  const ExpensesItem(
    this.expense, {
    super.key,
    // required this.onDelete,
  });

  final ExpenseModal expense;
  // final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    // final isLong = expense.title.trim().split('').length > 30;
    // final theme = Theme.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                blurStyle: BlurStyle.normal,
                color: Colors.black.withOpacity(0.15),
                blurRadius: 7,
                offset: Offset(0, 4),
                spreadRadius: 1.0),
          ],
        ),
        child: Card(
          // shadowColor: Colors.grey.withOpacity(0.15),
          // margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
            child: Column(
              children: [
                // CircleAvatar(
                //   radius: 26,
                //   backgroundColor: isDark ? Colors.blue[800] : Colors.white,
                //   child: Icon(
                //     _getCategoryIcon(expense.category),
                //     color: theme.colorScheme.onPrimaryContainer,
                //   ),
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(
                        expense.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          // fontSize: isLong ? 14 : 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Flexible(
                      flex: 2,
                      child: Text(
                          _getCategoryName(
                            expense.category,
                          ),
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: isDark ? Colors.blue[700] : Colors.white,
                          )),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      ' \$ ${expense.amount.toStringAsFixed(2)}',
                      style: GoogleFonts.roboto(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      expense.formattedDate,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Converts Category enum to readable name
String _getCategoryName(Category category) {
  switch (category) {
    case Category.food:
      return 'Food';
    case Category.work:
      return 'Work';
    case Category.shopping:
      return 'Shopping';
    case Category.travel:
      return 'Travel';
  }
}

// Converts Category enum to icon
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

// child: Column(
//   children: [
//     Row(crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(expense.title,
//         style: GoogleFonts.youngSerif(
//           fontSize: 22,
//           color: Colors.white,
//         ),
//         ),
//         Spacer(),
//         Text(_getCategoryNames(expense.category),
//         style: GoogleFonts.inter(
//           color: Colors.black,
//           fontSize: 15
//         ),
//         ),
//       ],
//     ),
//     // SizedBox(height: 3,),
//
//     Row(
//       crossAxisAlignment: CrossAxisAlignment.end,
//       children: [
//         Text('\$ ${expense.amount.toStringAsFixed(2)}',
//           style: GoogleFonts.roboto(
//             color: Colors.white,
//           ),),
//         Spacer(),
//         Row(
//           children: [
//             Icon(categoryIcons[expense.category],
//             color: Colors.white,
//             ),
//             SizedBox(width: 5,),
//             Text(expense.formattedDate,
//               style: GoogleFonts.roboto(
//                 color: Colors.white,
//               ),
//             ),
//           ],
//         ),
//       ],
//     ),
//   ],
// ),
//

//  Expanded(
//                  //    flex: 1,
//                  //   child: Material(
//                  //     elevation: 3,
//                  //     borderRadius: BorderRadius.circular(12),
//                  //     color: Colors.redAccent,
//                  //     child: InkWell(
//                  //       onTap:() {
//                  //         showDialog(
//                  //             context: context,
//                  //             builder: (ctx) => AlertDialog(
//                  //               title: Text('Delete Expense !',
//                  //               style: GoogleFonts.poppins(
//                  //                 fontWeight: FontWeight.bold,
//                  //                 fontSize: 20,
//                  //                 color: Colors.red
//                  //               ),
//                  //                 textAlign: TextAlign.center,
//                  //               ),
//                  //               actions: [
//                  //                 TextButton(
//                  //                     onPressed: (){
//                  //                       Navigator.of(context).pop();
//                  //                     },
//                  //                     child: Text('Cancel')),
//                  //                 ElevatedButton(
//                  //                   style: ElevatedButton.styleFrom(
//                  //                     backgroundColor: Colors.redAccent,
//                  //                     foregroundColor: Colors.white,
//                  //                   ),
//                  //                     onPressed: (){
//                  //                     Navigator.of(context).pop();
//                  //                     onDelete();
//                  //                     },
//                  //                     child: Text('Delete')),
//                  //               ],
//                  //             ),
//                  //         );
//                  //       },
//                  //       borderRadius: BorderRadius.circular(12),
//                  //       child: const Padding(
//                  //         padding: EdgeInsets.all(8.0),
//                  //         child: Icon(
//                  //           Icons.delete,
//                  //           color: Colors.white,
//                  //           size: 24,
//                  //         ),
//                  //       ),
//                  //     ),
//                  //   ),
//                  // ),
