import 'package:flutter/material.dart';

import 'keyboardkeys.dart';

class CustomKeyboard extends StatelessWidget {
  final Function onKeyRelease;

  final Widget child;
  CustomKeyboard({required this.onKeyRelease, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(0.0, 0.0),
      child: Align(
        alignment: Alignment.bottomCenter,

        child: Container(
          // decoration: BoxDecoration(color: Colors.blue),
          child: KeyboardKeys(
            onKeyRelease: onKeyRelease,
            child: child,
          ),
        ),
      ),
    );
  }
}
