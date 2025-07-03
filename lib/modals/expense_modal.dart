import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

final formatter = DateFormat.yMd();

const uuid = Uuid();

enum Category {
  food,
  travel,
  shopping,
  work,
}

final categoryIcons = {
  Category.food: Icons.lunch_dining_outlined,
  Category.travel: Icons.flight_takeoff,
  Category.shopping: Icons.shopping_bag,
  Category.work: Icons.work_history,
};

class ExpenseModal {
  ExpenseModal({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate {
    return formatter.format(date);
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'amount': amount,
      'date': date.toIso8601String(),
      'category': category.name, // name gives the string (e.g., 'food')
    };
  }

  factory ExpenseModal.fromJson(Map<String, dynamic> json) {
    return ExpenseModal(
      title: json['title'],
      amount: json['amount'],
      date: DateTime.parse(json['date']),
      category: Category.values.firstWhere((c) => c.name == json['category']),
    );
  }
}
