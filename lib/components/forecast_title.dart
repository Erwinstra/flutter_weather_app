import 'package:flutter/material.dart';

import '../models/constant.dart';

class ForecastTitle extends StatelessWidget {
  ForecastTitle({
    super.key,
  });

  final Constant myColor = Constant();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Today',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        Text(
          'Next 5 Days',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: myColor.primaryColor,
          ),
        ),
      ],
    );
  }
}
