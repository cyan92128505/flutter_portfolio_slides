import 'package:flutter_test/flutter_test.dart';
import 'package:app/features/slides/domain/entities/topic.dart';

void main() {
  group('Topic', () {
    group('routeName', () {
      test('aiTools returns ai-tools', () {
        expect(Topic.aiTools.routeName, 'ai-tools');
      });

      test('flutterLifecycle returns flutter-lifecycle', () {
        expect(Topic.flutterLifecycle.routeName, 'flutter-lifecycle');
      });

      test('solid returns solid', () {
        expect(Topic.solid.routeName, 'solid');
      });

      test('bloc returns bloc', () {
        expect(Topic.bloc.routeName, 'bloc');
      });

      test('goRouter returns go-router', () {
        expect(Topic.goRouter.routeName, 'go-router');
      });

      test('restfulApi returns restful-api', () {
        expect(Topic.restfulApi.routeName, 'restful-api');
      });

      test('githubFlow returns github-flow', () {
        expect(Topic.githubFlow.routeName, 'github-flow');
      });
    });

    group('displayName', () {
      test('aiTools returns AI Tools Usage', () {
        expect(Topic.aiTools.displayName, 'AI Tools Usage');
      });

      test('flutterLifecycle returns Flutter Lifecycle + Clean Architecture',
          () {
        expect(Topic.flutterLifecycle.displayName,
            'Flutter Lifecycle + Clean Architecture');
      });

      test('solid returns SOLID Principles', () {
        expect(Topic.solid.displayName, 'SOLID Principles');
      });

      test('bloc returns BLoC Pattern', () {
        expect(Topic.bloc.displayName, 'BLoC Pattern');
      });

      test('goRouter returns go_router', () {
        expect(Topic.goRouter.displayName, 'go_router');
      });

      test('restfulApi returns RESTful API Integration', () {
        expect(Topic.restfulApi.displayName, 'RESTful API Integration');
      });

      test('githubFlow returns GitHub Flow', () {
        expect(Topic.githubFlow.displayName, 'GitHub Flow');
      });
    });

    group('fromRouteName', () {
      test('returns correct topic for ai-tools', () {
        expect(Topic.fromRouteName('ai-tools'), Topic.aiTools);
      });

      test('returns correct topic for flutter-lifecycle', () {
        expect(Topic.fromRouteName('flutter-lifecycle'), Topic.flutterLifecycle);
      });

      test('returns correct topic for solid', () {
        expect(Topic.fromRouteName('solid'), Topic.solid);
      });

      test('returns correct topic for bloc', () {
        expect(Topic.fromRouteName('bloc'), Topic.bloc);
      });

      test('returns correct topic for go-router', () {
        expect(Topic.fromRouteName('go-router'), Topic.goRouter);
      });

      test('returns correct topic for restful-api', () {
        expect(Topic.fromRouteName('restful-api'), Topic.restfulApi);
      });

      test('returns correct topic for github-flow', () {
        expect(Topic.fromRouteName('github-flow'), Topic.githubFlow);
      });

      test('throws ArgumentError for invalid route name', () {
        expect(
          () => Topic.fromRouteName('invalid-route'),
          throwsA(isA<ArgumentError>()),
        );
      });
    });

    test('has exactly 7 topics', () {
      expect(Topic.values.length, 7);
    });
  });
}
