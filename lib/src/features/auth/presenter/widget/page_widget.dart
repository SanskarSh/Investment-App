
import 'package:flutter/material.dart';

class PageViewWidget extends StatelessWidget {
  final Color color;
  final String title;
  final String description;
  const PageViewWidget(
      {super.key,
      required this.color,
      required this.title,
      required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: color,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 70.0,
              height: 1,
              fontWeight: FontWeight.w800,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 20.0),
          Text(
            description,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}