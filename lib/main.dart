import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'widgets/expenses_list/expenses.dart';

var kColorScheme =
    ColorScheme.fromSeed(seedColor: Color.fromARGB(161, 20, 27, 80));

var kDarkColorScheme =
    ColorScheme.fromSeed(seedColor: Color.fromARGB(63, 20, 27, 80));

final themeNotifier = ValueNotifier<ThemeMode>(ThemeMode.system);

void main() {
  runApp(
    ValueListenableBuilder(
      valueListenable: themeNotifier,
      builder: (context, ThemeMode currentMode, _) {
        return MaterialApp(
          themeMode: currentMode,
          home: Expenses(),
          theme: ThemeData.light(
            useMaterial3: true,
          ).copyWith(
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.blueAccent[100],
              foregroundColor: Colors.black,
              // backgroundColor:  Color(0xFF6C63FF),
              // foregroundColor:Color(0xFFFFFFFF),
            ),
            scaffoldBackgroundColor: CupertinoColors.systemBackground,
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[800],
                foregroundColor: kColorScheme.onPrimary,
              ),
            ),
            cardTheme: CardThemeData(
              shadowColor: Colors.blueGrey,
              color: Colors.blueAccent[100],
            ),
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: Colors.blue[800],
              foregroundColor: Color(0xFFFFFFFF),
            ),
          ),
          darkTheme: ThemeData.dark().copyWith(
              appBarTheme: AppBarTheme(
                backgroundColor: Colors.black,
                foregroundColor: kDarkColorScheme.onPrimary,
              ),
              scaffoldBackgroundColor: Colors.grey[500],
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: Colors.black54,
                foregroundColor: kDarkColorScheme.onPrimary,
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kDarkColorScheme.onPrimaryContainer,
                  foregroundColor: kDarkColorScheme.onPrimary,
                ),
              ),
              cardTheme: CardThemeData(
                color: Colors.black54,
              )),
        );
      },
    ),
  );
}
