import 'package:expensify/modals/expense_modal.dart';
import 'package:expensify/widgets/expenses_list/expenses_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

class ExpensesList extends StatefulWidget {
  const ExpensesList({
    super.key,
    required this.expenses,
    required this.onRemoveExpense,
  });

  final List<ExpenseModal> expenses;
  final void Function(ExpenseModal) onRemoveExpense;

  @override
  State<ExpensesList> createState() => _ExpensesListState();
}

class _ExpensesListState extends State<ExpensesList> {
  // int? _openedIndex;
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return ListView.builder(
      itemCount: widget.expenses.length,
      itemBuilder: (ctx, index) {
        // final isOpen = _openedIndex == index;

        return Slidable(
          key: ValueKey(widget.expenses[index]),
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            extentRatio: 0.3, // 30% width of the card
            children: [
              SizedBox(
                height: 80,
                width: 110,
                child: SlidableAction(
                  spacing: 4.6,
                  flex: 2,
                  onPressed: (_) => showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                            backgroundColor:
                                isDark ? Colors.grey[500] : Colors.white,
                            title: Text(
                              'Confirm to Delete !',
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(true);
                                },
                                child: Text(
                                  'Cancel',
                                  style: GoogleFonts.basic(
                                    fontSize: 14,
                                    color: isDark
                                        ? Colors.white
                                        : Colors.blueAccent,
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop(false);
                                  widget
                                      .onRemoveExpense(widget.expenses[index]);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.redAccent[200],
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                child: Text(
                                  'Delete',
                                  style: GoogleFonts.basic(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          )),
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ],
          ),

          child: ExpensesItem(widget.expenses[index]),
          // return Dismissible(
          //     key: ValueKey(expenses[index]),
          //     direction: DismissDirection.startToEnd,
          //     background: SizedBox(
          //       width: 200,
          //       child: Icon(Icons.delete,
          //       color: Colors.red,
          //       ),
          //     ),
          //   confirmDismiss: (direction) async {
          //     return await showDialog(
          //       context: context,
          //       builder: (ctx) => AlertDialog(
          //         title: Text('Confirm Delete !',
          //         style: GoogleFonts.robotoMono(
          //
          //         ),
          //         ),
          //         actions: [
          //           TextButton(onPressed: () =>
          //             Navigator.of(context).pop(),
          //             child: Text('Cancel')),
          //
          //           ElevatedButton(onPressed: () =>
          //             Navigator.of(context).pop(),
          //             child: Text('Delete'),),
          //         ],
          //       )
          //     );
          //   },
          //   onDismissed: (direction) {
          //       onRemoveExpense(expenses[index]);
          // },
          //   child: ExpensesItem(expenses[index]),
        );
      },
    );
  }
}
