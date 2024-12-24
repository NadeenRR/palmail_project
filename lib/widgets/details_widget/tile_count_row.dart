import 'package:flutter/material.dart';

class TitleAndCountRow extends StatelessWidget {
  final String title;
  final int count;

  TitleAndCountRow({
    required this.title,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Text('$count FOUND'),
      ],
    );
  }
}
