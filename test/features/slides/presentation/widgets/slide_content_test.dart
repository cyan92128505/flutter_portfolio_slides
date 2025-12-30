import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app/features/slides/presentation/widgets/slide_content.dart';
import 'package:app/features/slides/presentation/widgets/code_block.dart';
import 'package:app/features/slides/domain/entities/slide.dart';
import 'package:app/features/slides/domain/entities/topic.dart';

void main() {
  group('SlideContent', () {
    testWidgets('displays title', (tester) async {
      const slide = Slide(
        topic: Topic.aiTools,
        pageIndex: 0,
        title: 'Test Title',
        content: 'Test Content',
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SlideContent(slide: slide),
          ),
        ),
      );

      expect(find.text('Test Title'), findsOneWidget);
    });

    testWidgets('displays content', (tester) async {
      const slide = Slide(
        topic: Topic.aiTools,
        pageIndex: 0,
        title: 'Title',
        content: 'This is the slide content',
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SlideContent(slide: slide),
          ),
        ),
      );

      expect(find.text('This is the slide content'), findsOneWidget);
    });

    testWidgets('displays code block when present', (tester) async {
      const slide = Slide(
        topic: Topic.bloc,
        pageIndex: 0,
        title: 'Code Example',
        content: 'Here is some code:',
        codeSnippet: 'print("hello");',
        codeLanguage: 'dart',
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SlideContent(slide: slide),
          ),
        ),
      );

      expect(find.byType(CodeBlock), findsOneWidget);
    });

    testWidgets('hides code block when not present', (tester) async {
      const slide = Slide(
        topic: Topic.aiTools,
        pageIndex: 0,
        title: 'No Code',
        content: 'No code here',
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SlideContent(slide: slide),
          ),
        ),
      );

      expect(find.byType(CodeBlock), findsNothing);
    });
  });
}
