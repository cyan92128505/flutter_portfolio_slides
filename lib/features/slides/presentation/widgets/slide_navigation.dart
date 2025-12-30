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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: hasPrevious ? onPrevious : null,
            tooltip: 'Previous (Left Arrow)',
          ),
          Text(
            '${currentIndex + 1} / $totalSlides',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: hasNext ? onNext : null,
            tooltip: 'Next (Right Arrow)',
          ),
        ],
      ),
    );
  }
}
