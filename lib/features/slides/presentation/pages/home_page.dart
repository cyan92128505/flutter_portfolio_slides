import 'package:app/features/slides/domain/domain.dart';
import 'package:app/features/slides/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const double _breakpoint = 600;
  static const double _maxContentWidth = 800;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Portfolio'), centerTitle: true),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > _breakpoint;
          final crossAxisCount = isWide ? 2 : 1;

          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: _maxContentWidth),
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: isWide ? 2.5 : 3.5,
                ),
                itemCount: Topic.values.length,
                itemBuilder: (context, index) {
                  final topic = Topic.values[index];
                  return TopicCard(
                    topic: topic,
                    index: index,
                    onTap: () => context.go('/slides/${topic.routeName}'),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
