import 'package:flutter/material.dart';

class KeyboardKeyCustom extends StatelessWidget {
  final String character;
  final Function positionedTap;
  final Color? textColor;

  KeyboardKeyCustom(this.character, {required this.positionedTap, this.textColor});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: OutlinedButton(
        onPressed: positionedTap(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Text(
            character,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 60,color: textColor),
          ),
        ),
      ),
    );
  }
}