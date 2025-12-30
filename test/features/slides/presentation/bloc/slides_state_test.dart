import 'package:flutter_test/flutter_test.dart';
import 'package:app/features/slides/presentation/bloc/slides_state.dart';
import 'package:app/features/slides/domain/entities/slide.dart';
import 'package:app/features/slides/domain/entities/topic.dart';

void main() {
  group('SlidesState', () {
    final testSlides = [
      const Slide(
        topic: Topic.aiTools,
        pageIndex: 0,
        title: 'Slide 1',
        content: 'Content 1',
      ),
      const Slide(
        topic: Topic.aiTools,
        pageIndex: 1,
        title: 'Slide 2',
        content: 'Content 2',
      ),
      const Slide(
        topic: Topic.aiTools,
        pageIndex: 2,
        title: 'Slide 3',
        content: 'Content 3',
      ),
    ];

    group('initial state', () {
      test('has correct default values', () {
        const state = SlidesState();

        expect(state.topic, isNull);
        expect(state.slides, isEmpty);
        expect(state.currentIndex, 0);
        expect(state.status, SlidesStatus.initial);
        expect(state.errorMessage, isNull);
      });
    });

    group('currentSlide', () {
      test('returns correct slide when slides exist', () {
        final state = SlidesState(
          slides: testSlides,
          currentIndex: 1,
        );

        expect(state.currentSlide, testSlides[1]);
      });

      test('returns null when slides is empty', () {
        const state = SlidesState(slides: []);

        expect(state.currentSlide, isNull);
      });

      test('returns null when currentIndex is negative', () {
        final state = SlidesState(
          slides: testSlides,
          currentIndex: -1,
        );

        expect(state.currentSlide, isNull);
      });

      test('returns null when currentIndex is out of bounds', () {
        final state = SlidesState(
          slides: testSlides,
          currentIndex: 10,
        );

        expect(state.currentSlide, isNull);
      });
    });

    group('hasNext', () {
      test('returns true when not at last slide', () {
        final state = SlidesState(
          slides: testSlides,
          currentIndex: 0,
        );

        expect(state.hasNext, isTrue);
      });

      test('returns true when at middle slide', () {
        final state = SlidesState(
          slides: testSlides,
          currentIndex: 1,
        );

        expect(state.hasNext, isTrue);
      });

      test('returns false when at last slide', () {
        final state = SlidesState(
          slides: testSlides,
          currentIndex: 2,
        );

        expect(state.hasNext, isFalse);
      });

      test('returns false when slides is empty', () {
        const state = SlidesState(slides: []);

        expect(state.hasNext, isFalse);
      });
    });

    group('hasPrevious', () {
      test('returns false when at first slide', () {
        final state = SlidesState(
          slides: testSlides,
          currentIndex: 0,
        );

        expect(state.hasPrevious, isFalse);
      });

      test('returns true when at middle slide', () {
        final state = SlidesState(
          slides: testSlides,
          currentIndex: 1,
        );

        expect(state.hasPrevious, isTrue);
      });

      test('returns true when at last slide', () {
        final state = SlidesState(
          slides: testSlides,
          currentIndex: 2,
        );

        expect(state.hasPrevious, isTrue);
      });
    });

    group('totalSlides', () {
      test('returns correct count', () {
        final state = SlidesState(slides: testSlides);

        expect(state.totalSlides, 3);
      });

      test('returns 0 when slides is empty', () {
        const state = SlidesState(slides: []);

        expect(state.totalSlides, 0);
      });
    });

    group('copyWith', () {
      test('creates copy with updated topic', () {
        final state = SlidesState(slides: testSlides);
        final newState = state.copyWith(topic: Topic.bloc);

        expect(newState.topic, Topic.bloc);
        expect(newState.slides, testSlides);
      });

      test('creates copy with updated currentIndex', () {
        final state = SlidesState(slides: testSlides, currentIndex: 0);
        final newState = state.copyWith(currentIndex: 2);

        expect(newState.currentIndex, 2);
      });

      test('creates copy with updated status', () {
        const state = SlidesState(status: SlidesStatus.initial);
        final newState = state.copyWith(status: SlidesStatus.loaded);

        expect(newState.status, SlidesStatus.loaded);
      });
    });

    group('equality', () {
      test('two states with same values are equal', () {
        final state1 = SlidesState(
          topic: Topic.aiTools,
          slides: testSlides,
          currentIndex: 1,
          status: SlidesStatus.loaded,
        );
        final state2 = SlidesState(
          topic: Topic.aiTools,
          slides: testSlides,
          currentIndex: 1,
          status: SlidesStatus.loaded,
        );

        expect(state1, equals(state2));
      });

      test('two states with different values are not equal', () {
        final state1 = SlidesState(
          slides: testSlides,
          currentIndex: 0,
        );
        final state2 = SlidesState(
          slides: testSlides,
          currentIndex: 1,
        );

        expect(state1, isNot(equals(state2)));
      });
    });
  });
}
