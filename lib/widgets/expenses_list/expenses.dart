import 'dart:convert';

import 'package:expensify/expense_barchart.dart';
import 'package:expensify/main.dart';
import 'package:expensify/modals/expense_modal.dart' hide Category;
import 'package:expensify/new_expenses.dart';
import 'package:expensify/widgets/expenses_list/expenses_list.dart';
import 'package:expensify/widgets/expenses_list/styled_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _StateExpenses();
}

class _StateExpenses extends State<Expenses> {
  bool isLoading = false;

  void _toggleTheme(bool isDark) async {
    setState(() => isLoading = true);

    await Future.delayed(Duration(milliseconds: 1000));
    themeNotifier.value = isDark ? ThemeMode.dark : ThemeMode.light;
    setState(() => isLoading = false);
    Future.delayed(Duration(milliseconds: 10), () {
      Navigator.of(context).pop();
    });
  }

  bool isDarkMode = false;
  Future<void> _saveExpenses() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> expenseJsonList = _registeredExpense
        .map((expense) => json.encode(expense.toJson()))
        .toList();

    await prefs.setStringList('expenses', expenseJsonList);
  }

  @override
  void initState() {
    super.initState();
    _loadExpenses();
  }

  Future<void> _loadExpenses() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? expenseJsonList = prefs.getStringList('expenses');

    if (expenseJsonList != null) {
      setState(() {
        _registeredExpense.clear();
        _registeredExpense.addAll(expenseJsonList
            .map((item) => ExpenseModal.fromJson(json.decode(item))));
      });
    }
  }

  final List<ExpenseModal> _registeredExpense = [];

  Map<dynamic, double> get categoryTotals {
    final Map<dynamic, double> totals = {};

    for (final expense in _registeredExpense) {
      totals.update(
        expense.category,
        (existing) => existing + expense.amount,
        ifAbsent: () => expense.amount,
      );
    }

    return totals;
  }

  void _openAddExpenseItem() {
    showModalBottomSheet(
      useSafeArea: true,
      sheetAnimationStyle: AnimationStyle(duration: Duration(seconds: 1)),
      isScrollControlled: true,
      context: context,
      builder: (ctx) => StyledBottomSheet(
        child: NewExpenses(onAddExpense: _addExpense),
      ),
    );
  }

  void _addExpense(ExpenseModal expense) {
    setState(() {
      _registeredExpense.add(expense);
    });
    _saveExpenses();
  }

  void _removeExpense(ExpenseModal expense) {
    final expenseIndex = _registeredExpense.indexOf(expense);
    setState(() {
      _registeredExpense.remove(expense);
    });
    _saveExpenses();
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.black,
        duration: Duration(seconds: 3),
        content: Text(
          'Expense Deleted !',
          style: TextStyle(color: Colors.red),
        ),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                _registeredExpense.insert(expenseIndex, expense);
              });
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    // final isPortrait =
    // MediaQuery.of(context).orientation == Orientation.portrait;
    // print('Is Portait: $isPortrait');
    // final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    Widget mainContent = Center(
      child: Text(
        'You need to add Expenses to appear on Screen!',
        style: TextStyle(
          color: isDarkMode ? Colors.white : Colors.black,
        ),
      ),
    );
    if (_registeredExpense.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpense,
        onRemoveExpense: _removeExpense,
      );
    }

    return Scaffold(
      floatingActionButton: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(8, 3),
            blurRadius: 8,
          )
        ]),
        child: FloatingActionButton(
          onPressed: _openAddExpenseItem,
          child: Icon(Icons.add),
        ),
      ),
      appBar: AppBar(
        elevation: 4,
        title: Text(
          'Expensify',
          style: GoogleFonts.youngSerif(
            fontSize: 22,
          ),
        ),
        actions: [
          Builder(builder: (context) {
            return IconButton(
              icon: Icon(
                Icons.settings,
              ),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            );
          }),
          // IconButton(onPressed: () {
          //  themeNotifier.value = themeNotifier.value == ThemeMode.dark
          //   ? ThemeMode.light
          //   : ThemeMode.dark;
          // },
          //icon: Icon(Icons.brightness_6),),
        ],
      ),
      endDrawer: Drawer(
        backgroundColor: isDarkMode ? Colors.blueGrey : Colors.blueGrey[200],
        child: ListView(
          children: [
            Text(
              'Settings',
              style: GoogleFonts.literata(fontSize: 20, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Dark Mode',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                isLoading
                    ? SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          color: Colors.black,
                          strokeWidth: 10,
                        ),
                      )
                    : Switch(
                        activeColor: isDarkMode ? Colors.white70 : Colors.black,
                        value: themeNotifier.value == ThemeMode.dark,
                        onChanged: _toggleTheme
                        // (val) {
                        //   themeNotifier.value =
                        //       val ? ThemeMode.dark : ThemeMode.light;
                        //       Navigator.of(context).pop();
                        // },
                        ),
              ],
            )
          ],
        ),
      ),
      body: width < 500
          ? Column(
              children: [
                ExpenseChart(categoryTotals),
                SizedBox(height: 10),
                Expanded(child: mainContent),
              ],
            )
          : Row(
              children: [
                Expanded(child: ExpenseChart(categoryTotals)),
                SizedBox(width: 10),
                Expanded(child: mainContent),
              ],
            ),
    );
  }
}
