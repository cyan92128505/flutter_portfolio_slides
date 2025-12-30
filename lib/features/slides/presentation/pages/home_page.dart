import 'package:app/features/slides/domain/domain.dart';
import 'package:app/features/slides/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Portfolio'), centerTitle: true),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
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
    );
  }
}
