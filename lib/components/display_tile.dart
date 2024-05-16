import 'package:flutter/material.dart';

class DisplayTile extends StatelessWidget {
  const DisplayTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.asset(
        'assets/windy.gif',
        width: 45,
      ),
    );
  }
}
