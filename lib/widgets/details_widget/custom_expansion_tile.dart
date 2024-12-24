import 'package:flutter/material.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';

class CustomExpandedTile extends StatelessWidget {
  final bool? isSnackBarVisible;
  final Widget title;
  final Widget content;
  final Function()? onTap;
  final Function()? onLongTap;
  final Widget? leading;
  final ExpandedTileController controller;

  const CustomExpandedTile({
    super.key,
    this.isSnackBarVisible = false,
    required this.title,
    required this.content,
    this.onTap,
    this.onLongTap,
    required this.controller,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return ExpandedTile(
      theme: ExpandedTileThemeData(
        headerColor:
            isSnackBarVisible! ? Colors.white.withOpacity(0.5) : Colors.white,
        headerRadius: 24.0,
        headerPadding: const EdgeInsets.all(24.0),
        contentBackgroundColor:
            isSnackBarVisible! ? Colors.white.withOpacity(0.5) : Colors.white,
        contentPadding: const EdgeInsets.all(24.0),
        contentRadius: 12.0,
      ),
      title: title,
      content: content,
      leading: leading,
      onTap: onTap,
      onLongTap: () {},
      controller: controller,
    );
  }
}

class MailExpandedTile extends StatelessWidget {
  final bool? isSnackBarVisible;
  final Widget title;
  final Widget content;
  final Function()? onTap;
  final Function()? onLongTap;
  final Widget? leading;
  final ExpandedTileController controller;

  const MailExpandedTile({
    super.key,
    this.isSnackBarVisible = false,
    required this.title,
    required this.content,
    this.onTap,
    this.onLongTap,
    required this.controller,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Material(
            color: isSnackBarVisible!
                ? Colors.white.withOpacity(0.5)
                : Colors.white,
            borderRadius: BorderRadius.circular(24.0),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                children: [
                  Expanded(child: title),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 8), // Add some spacing between header and content
          Visibility(
            visible: controller.isExpanded,
            child: Material(
              color: isSnackBarVisible!
                  ? Colors.white.withOpacity(0.5)
                  : Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: content,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
