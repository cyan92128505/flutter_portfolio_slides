import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/github.dart';

class CodeBlock extends StatelessWidget {
  final String code;
  final String language;

  const CodeBlock({
    super.key,
    required this.code,
    this.language = 'dart',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: HighlightView(
          code,
          language: language,
          theme: githubTheme,
          padding: const EdgeInsets.all(16),
          textStyle: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
