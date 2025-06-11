import 'package:flutter/material.dart';
import 'package:markdown_widget/widget/markdown.dart';

class PromptResult extends StatelessWidget {
  const PromptResult({super.key, required this.promptResult});
  final String? promptResult;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(left: 24, right: 84, top: 6, bottom: 6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(12),
        ),
        child: MarkdownWidget(
          data: promptResult ?? "",
          selectable: true,
          shrinkWrap: true,
        ),
      ),
    );
  }
}
