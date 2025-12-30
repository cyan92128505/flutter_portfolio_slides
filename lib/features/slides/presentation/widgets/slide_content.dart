import 'package:app/features/slides/domain/domain.dart';
import 'package:flutter/material.dart';
import 'code_block.dart';

class SlideContent extends StatelessWidget {
  final Slide slide;

  const SlideContent({super.key, required this.slide});

  static const double _maxContentWidth = 900;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWide = screenWidth > 600;
    final horizontalPadding = isWide ? 48.0 : 24.0;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: 24,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: _maxContentWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                slide.title,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: isWide ? 32 : 24,
                    ),
              ),
              const SizedBox(height: 24),
              Text(
                slide.content,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      height: 1.6,
                      fontSize: isWide ? 18 : 16,
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
        ),
      ),
    );
  }
}
