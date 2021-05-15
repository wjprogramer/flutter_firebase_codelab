import 'package:flutter/material.dart';

class StyledButton extends StatelessWidget {
  const StyledButton({required this.child, required this.onPressed});
  final Widget child;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) => OutlinedButton(
        style: OutlinedButton.styleFrom(
            side: BorderSide(color: Colors.deepPurple)),
        onPressed: onPressed,
        child: child,
      );
}
