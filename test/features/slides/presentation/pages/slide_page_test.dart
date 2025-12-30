import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/features/slides/data/repositories/slides_repository_impl.dart';
import 'package:app/features/slides/domain/entities/slide.dart';
import 'package:app/features/slides/domain/entities/topic.dart';
import 'package:app/features/slides/domain/repositories/slides_repository.dart';
import 'package:app/features/slides/presentation/pages/slide_page.dart';
import 'package:app/features/slides/presentation/widgets/slide_content.dart';
import 'package:app/features/slides/presentation/widgets/slide_navigation.dart';

void main() {
  group('SlidePage', () {
    late SlidesRepositoryImpl mockRepository;

    setUp(() {
      mockRepository = SlidesRepositoryImpl(data: {
        Topic.aiTools: [
          const Slide(
            topic: Topic.aiTools,
            pageIndex: 0,
            title: 'AI Slide 1',
            content: 'Content 1',
          ),
          const Slide(
            topic: Topic.aiTools,
            pageIndex: 1,
            title: 'AI Slide 2',
            content: 'Content 2',
          ),
          const Slide(
            topic: Topic.aiTools,
            pageIndex: 2,
            title: 'AI Slide 3',
            content: 'Content 3',
          ),
          const Slide(
            topic: Topic.aiTools,
            pageIndex: 3,
            title: 'AI Slide 4',
            content: 'Content 4',
          ),
        ],
        Topic.bloc: [
          const Slide(
            topic: Topic.bloc,
            pageIndex: 0,
            title: 'BLoC Slide 1',
            content: 'Content 1',
          ),
        ],
      });
    });

    testWidgets('displays topic name in app bar', (tester) async {
      await tester.pumpWidget(
        RepositoryProvider<SlidesRepository>.value(
          value: mockRepository,
          child: const MaterialApp(
            home: SlidePage(topic: Topic.aiTools),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('AI Tools Usage'), findsWidgets);
    });

    testWidgets('displays SlideContent widget', (tester) async {
      await tester.pumpWidget(
        RepositoryProvider<SlidesRepository>.value(
          value: mockRepository,
          child: const MaterialApp(
            home: SlidePage(topic: Topic.aiTools),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(SlideContent), findsOneWidget);
    });

    testWidgets('displays SlideNavigation widget', (tester) async {
      await tester.pumpWidget(
        RepositoryProvider<SlidesRepository>.value(
          value: mockRepository,
          child: const MaterialApp(
            home: SlidePage(topic: Topic.aiTools),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(SlideNavigation), findsOneWidget);
    });

    testWidgets('displays page indicator starting at 1', (tester) async {
      await tester.pumpWidget(
        RepositoryProvider<SlidesRepository>.value(
          value: mockRepository,
          child: const MaterialApp(
            home: SlidePage(topic: Topic.aiTools),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.textContaining('1 /'), findsOneWidget);
    });

    testWidgets('next button navigates to next slide', (tester) async {
      await tester.pumpWidget(
        RepositoryProvider<SlidesRepository>.value(
          value: mockRepository,
          child: const MaterialApp(
            home: SlidePage(topic: Topic.aiTools),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('1 / 4'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.arrow_forward));
      await tester.pumpAndSettle();

      expect(find.text('2 / 4'), findsOneWidget);
    });

    testWidgets('previous button navigates to previous slide', (tester) async {
      await tester.pumpWidget(
        RepositoryProvider<SlidesRepository>.value(
          value: mockRepository,
          child: const MaterialApp(
            home: SlidePage(topic: Topic.aiTools),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.arrow_forward));
      await tester.pumpAndSettle();
      expect(find.text('2 / 4'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();
      expect(find.text('1 / 4'), findsOneWidget);
    });

    testWidgets('keyboard right arrow goes to next slide', (tester) async {
      await tester.pumpWidget(
        RepositoryProvider<SlidesRepository>.value(
          value: mockRepository,
          child: const MaterialApp(
            home: SlidePage(topic: Topic.aiTools),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('1 / 4'), findsOneWidget);

      await tester.sendKeyEvent(LogicalKeyboardKey.arrowRight);
      await tester.pumpAndSettle();

      expect(find.text('2 / 4'), findsOneWidget);
    });

    testWidgets('keyboard left arrow goes to previous slide', (tester) async {
      await tester.pumpWidget(
        RepositoryProvider<SlidesRepository>.value(
          value: mockRepository,
          child: const MaterialApp(
            home: SlidePage(topic: Topic.aiTools),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.sendKeyEvent(LogicalKeyboardKey.arrowRight);
      await tester.pumpAndSettle();
      expect(find.text('2 / 4'), findsOneWidget);

      await tester.sendKeyEvent(LogicalKeyboardKey.arrowLeft);
      await tester.pumpAndSettle();
      expect(find.text('1 / 4'), findsOneWidget);
    });

    testWidgets('displays home button', (tester) async {
      await tester.pumpWidget(
        RepositoryProvider<SlidesRepository>.value(
          value: mockRepository,
          child: const MaterialApp(
            home: SlidePage(topic: Topic.bloc),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.home), findsOneWidget);
    });
  });
}
