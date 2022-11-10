import 'package:flutter/material.dart';

class IconElevatedButton extends StatelessWidget {
  const IconElevatedButton({
    required this.icon,
    required this.onPressed,
    required this.style,
    required this.label,
    Key? key,
  }) : super(key: key);
  final Icon icon;
  final void Function()? onPressed;
  final ButtonStyle style;
  final Widget label;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        icon:icon,
        onPressed:onPressed,
        style:style,
        label:label);
  }
}
