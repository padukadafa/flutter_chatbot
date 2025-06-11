import 'package:flutter/material.dart';

class MessagePrompt extends StatelessWidget {
  const MessagePrompt({super.key, this.prompt});
  final String? prompt;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(left: 84, right: 24, top: 6, bottom: 6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          prompt ?? "",
          style: TextStyle(color: colorScheme.onSurface),
        ),
      ),
    );
  }
}
