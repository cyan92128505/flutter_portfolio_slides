import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/core/router.dart';
import 'package:app/features/slides/data/repositories/slides_repository_impl.dart';
import 'package:app/features/slides/domain/entities/slide.dart';
import 'package:app/features/slides/domain/entities/topic.dart';
import 'package:app/features/slides/domain/repositories/slides_repository.dart';
import 'package:app/features/slides/presentation/pages/home_page.dart';
import 'package:app/features/slides/presentation/pages/slide_page.dart';

void main() {
  group('AppRouter', () {
    late SlidesRepositoryImpl mockRepository;

    setUp(() {
      mockRepository = SlidesRepositoryImpl(data: {
        Topic.aiTools: [
          const Slide(
            topic: Topic.aiTools,
            pageIndex: 0,
            title: 'Test Slide',
            content: 'Test Content',
          ),
        ],
      });
    });

    testWidgets('root route navigates to HomePage', (tester) async {
      await tester.pumpWidget(
        RepositoryProvider<SlidesRepository>.value(
          value: mockRepository,
          child: MaterialApp.router(
            routerConfig: appRouter,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(HomePage), findsOneWidget);
    });

    testWidgets('/slides/ai-tools navigates to SlidePage', (tester) async {
      appRouter.go('/slides/ai-tools');

      await tester.pumpWidget(
        RepositoryProvider<SlidesRepository>.value(
          value: mockRepository,
          child: MaterialApp.router(
            routerConfig: appRouter,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(SlidePage), findsOneWidget);
      expect(find.text('AI Tools Usage'), findsWidgets);
    });

    testWidgets('/slides/invalid shows InvalidTopicPage', (tester) async {
      appRouter.go('/slides/invalid-topic');

      await tester.pumpWidget(
        RepositoryProvider<SlidesRepository>.value(
          value: mockRepository,
          child: MaterialApp.router(
            routerConfig: appRouter,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Topic not found'), findsOneWidget);
    });

    tearDown(() {
      appRouter.go('/');
    });
  });
}
