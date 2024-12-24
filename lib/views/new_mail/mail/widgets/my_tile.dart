import 'package:flutter/material.dart';

class CategoryExpansionTile extends StatefulWidget {
  final void Function(DateTime) onSelectdate;
  final DateTime date;
  const CategoryExpansionTile({
    super.key,
    required this.onSelectdate,
    required this.date,
  });
  @override
  State<CategoryExpansionTile> createState() => _CategoryExpansionTileState();
}

class _CategoryExpansionTileState extends State<CategoryExpansionTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: ExpansionTile(
        shape: const Border(
          top: BorderSide(color: Colors.transparent),
          bottom: BorderSide(color: Colors.transparent),
        ),
        iconColor: Colors.black,
        textColor: const Color(0xff272727),
        collapsedIconColor: const Color(0xffB2B2B2),
        tilePadding: EdgeInsets.zero,
        title: const Text(
          'Date',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
        subtitle: Text(
          '${widget.date.year}-${widget.date.month}-${widget.date.day}',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Color(0xff6589FF),
          ),
        ),
        leading: const Icon(
          Icons.date_range_rounded,
          color: Color(0xffD62929),
          size: 32,
        ),
        children: <Widget>[
          CalendarDatePicker(
            firstDate: DateTime.now(),
            lastDate: DateTime(2025, 12, 12),
            initialDate: DateTime.now(),
            onDateChanged: widget.onSelectdate,
          ),
        ],
      ),
    );
  }
}
