import 'package:flutter/material.dart';

class SlideNavigation extends StatelessWidget {
  final int currentIndex;
  final int totalSlides;
  final bool hasPrevious;
  final bool hasNext;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  const SlideNavigation({
    super.key,
    required this.currentIndex,
    required this.totalSlides,
    required this.hasPrevious,
    required this.hasNext,
    required this.onPrevious,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        border: Border(
          top: BorderSide(color: colorScheme.outlineVariant, width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FilledButton.tonalIcon(
            key: const Key('SlideNavigationPrevButton'),
            icon: const Icon(Icons.arrow_back),
            label: const Text('Prev'),
            onPressed: hasPrevious ? onPrevious : null,
          ),
          const SizedBox(width: 24),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '${currentIndex + 1} / $totalSlides',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: colorScheme.onPrimaryContainer,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 24),
          FilledButton.tonalIcon(
            key: const Key('SlideNavigationNextButton'),
            icon: const Icon(Icons.arrow_forward),
            label: const Text('Next'),
            onPressed: hasNext ? onNext : null,
          ),
        ],
      ),
    );
  }
}
