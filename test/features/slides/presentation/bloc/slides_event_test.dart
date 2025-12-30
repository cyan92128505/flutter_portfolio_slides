import 'package:flutter_test/flutter_test.dart';
import 'package:app/features/slides/presentation/bloc/slides_event.dart';
import 'package:app/features/slides/domain/entities/topic.dart';

void main() {
  group('SlidesEvent', () {
    group('LoadSlides', () {
      test('two LoadSlides with same topic are equal', () {
        const event1 = LoadSlides(Topic.aiTools);
        const event2 = LoadSlides(Topic.aiTools);

        expect(event1, equals(event2));
      });

      test('two LoadSlides with different topics are not equal', () {
        const event1 = LoadSlides(Topic.aiTools);
        const event2 = LoadSlides(Topic.bloc);

        expect(event1, isNot(equals(event2)));
      });

      test('props contains topic', () {
        const event = LoadSlides(Topic.solid);

        expect(event.props, [Topic.solid]);
      });
    });

    group('NextSlide', () {
      test('two NextSlide instances are equal', () {
        const event1 = NextSlide();
        const event2 = NextSlide();

        expect(event1, equals(event2));
      });

      test('props is empty', () {
        const event = NextSlide();

        expect(event.props, isEmpty);
      });
    });

    group('PreviousSlide', () {
      test('two PreviousSlide instances are equal', () {
        const event1 = PreviousSlide();
        const event2 = PreviousSlide();

        expect(event1, equals(event2));
      });

      test('props is empty', () {
        const event = PreviousSlide();

        expect(event.props, isEmpty);
      });
    });

    group('GoToSlide', () {
      test('two GoToSlide with same index are equal', () {
        const event1 = GoToSlide(5);
        const event2 = GoToSlide(5);

        expect(event1, equals(event2));
      });

      test('two GoToSlide with different indices are not equal', () {
        const event1 = GoToSlide(3);
        const event2 = GoToSlide(7);

        expect(event1, isNot(equals(event2)));
      });

      test('props contains pageIndex', () {
        const event = GoToSlide(10);

        expect(event.props, [10]);
      });
    });
  });
}
