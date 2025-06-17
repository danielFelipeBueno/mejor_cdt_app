

import 'package:flutter/material.dart';
import 'package:mejor_cdt_app/utils/constants.dart';

class PointDataInvestment extends StatelessWidget {
  const PointDataInvestment({
    super.key,
    required this.color,
    required this.text,
    required this.value
  });

  final Color color;
  final String text, value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 8,
                backgroundColor: color,
              ),
              const SizedBox(width: 10),
              Text(text, style: TextStyle(color: color))
            ],
          ),
          const SizedBox(height: 4),
          Text(value, 
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 21,
              color: color
            )
          )
        ],
      )
    );
  }
}