import 'package:flutter/material.dart';
import '../../domain/entities/slide.dart';
import 'code_block.dart';

class SlideContent extends StatelessWidget {
  final Slide slide;

  const SlideContent({super.key, required this.slide});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            slide.title,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 24),
          Text(
            slide.content,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  height: 1.6,
                ),
          ),
          if (slide.codeSnippet != null) ...[
            const SizedBox(height: 24),
            CodeBlock(
              code: slide.codeSnippet!,
              language: slide.codeLanguage ?? 'dart',
            ),
          ],
        ],
      ),
    );
  }
}
