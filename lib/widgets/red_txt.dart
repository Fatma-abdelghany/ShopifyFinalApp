import 'package:flutter/material.dart';

class RedTxt extends StatelessWidget {
 final String label;
  const RedTxt({required this.label,super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
        label,
        maxLines: 2,
        style: Theme.of(context).textTheme.headlineSmall

    );
  }
}
