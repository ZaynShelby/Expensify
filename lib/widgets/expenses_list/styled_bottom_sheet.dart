import 'package:flutter/material.dart';

class StyledBottomSheet extends StatelessWidget{
  final Widget child;

  const StyledBottomSheet({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[500] : Colors.blueAccent[50],
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black54 : Colors.grey.withOpacity(0.3),
            offset: Offset(0, -4),
            blurRadius: 12,
            spreadRadius: 1,
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: child,
    );
  }
}