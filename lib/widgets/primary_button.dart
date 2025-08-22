import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  const PrimaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton.icon(
        onPressed: onPressed,
        icon: Icon(icon ?? Icons.chevron_right),
        label: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Text(label),
        ),
      ),
    );
  }
}
