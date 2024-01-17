import 'package:flutter/material.dart';

class GreyTxt extends StatelessWidget {
  final String label;
  const GreyTxt({required this.label,super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.displaySmall


    );
  }
}
