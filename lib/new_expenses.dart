import 'package:expensify/main.dart';
import 'package:expensify/modals/expense_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

class NewExpenses extends StatefulWidget {
  const NewExpenses({super.key, required this.onAddExpense});

  final void Function(ExpenseModal expense) onAddExpense;

  @override
  State<StatefulWidget> createState() => _NewExpenses();
}

class _NewExpenses extends State<NewExpenses> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  DateTime? _selectedDate;
  Category _selectedCategory = Category.travel;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final first = DateTime(now.year - 10, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: first,
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _saveExpenseItem() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          backgroundColor: Colors.black54,
          title: Center(
            child: Text(
              'Invalid Input !',
              style: GoogleFonts.robotoMono(
                color: CupertinoColors.systemRed,
              ),
            ),
          ),
          content: Text(
            'Please make sure your input value must not be empty.',
            style: GoogleFonts.robotoMono(
              color: Colors.white,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: Text(
                'Okay',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: CupertinoColors.systemRed,
                ),
              ),
            ),
          ],
        ),
      );
      return;
    }
    widget.onAddExpense(
      ExpenseModal(
          title: _titleController.text,
          amount: enteredAmount,
          date: _selectedDate!,
          category: _selectedCategory),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 70, 25, 0),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: InputDecoration(
              counterStyle: TextStyle(
                color: Colors.black,
              ),
              hintStyle: GoogleFonts.bitter(
                fontSize: 20,
                color: Colors.black87,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  width: 1.0,
                  color: Colors.black,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  width: 2.0,
                  color: Colors.black54,
                ),
              ),
              label: Text(
                'Title',
                style: GoogleFonts.bitter(
                  color: isDark ? Colors.black38 : Colors.black45,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(width: 1.0, color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Colors.black54,
                        width: 2.0,
                      ),
                    ),
                    prefixText: '\$ ',
                    label: Text(
                      'Amount',
                      style: GoogleFonts.bitter(
                        color: isDark ? Colors.black38 : Colors.black45,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 13),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      _selectedDate == null
                          ? 'No Selected Date'
                          : formatter.format(_selectedDate!),
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                      ),
                    ),
                    IconButton(
                      onPressed: _presentDatePicker,
                      icon: Icon(
                        Icons.calendar_month,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Container(
                height: 40,
                width: 100,
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color:
                      isDark ? Colors.black87 : kColorScheme.onPrimaryContainer,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButton(
                    style: TextStyle(
                      color: kColorScheme.onPrimaryContainer,
                    ),
                    isExpanded: true,
                    underline: SizedBox(),
                    iconEnabledColor: kColorScheme.onPrimary,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    dropdownColor: isDark
                        ? Colors.black87
                        : kColorScheme.onPrimaryContainer,
                    value: _selectedCategory,
                    items: Category.values.map((category) {
                      return DropdownMenuItem(
                        value: category,
                        child: Text(
                          category.name.toUpperCase(),
                          style: TextStyle(
                            color: category == _selectedCategory
                                ? Colors.white
                                : Colors.white,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (Category? value) {
                      if (value == null) {
                        return;
                      }
                      setState(() {
                        _selectedCategory = value;
                      });
                    }),
              ),
              Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isDark ? Colors.black87 : kColorScheme.onPrimaryContainer,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Cancel',
                ),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isDark ? Colors.black87 : kColorScheme.onPrimaryContainer,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: _saveExpenseItem,
                child: Text('Save'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
