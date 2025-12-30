import 'package:flutter/material.dart';
import '../../domain/entities/topic.dart';

class TopicCard extends StatelessWidget {
  final Topic topic;
  final int index;
  final VoidCallback onTap;

  const TopicCard({
    super.key,
    required this.topic,
    required this.index,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          child: Text('${index + 1}'),
        ),
        title: Text(topic.displayName),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
}
