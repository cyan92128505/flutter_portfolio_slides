import 'package:flutter_test/flutter_test.dart';
import 'package:app/features/slides/data/repositories/slides_repository_impl.dart';
import 'package:app/features/slides/domain/entities/slide.dart';
import 'package:app/features/slides/domain/entities/topic.dart';

void main() {
  group('SlidesRepositoryImpl', () {
    late SlidesRepositoryImpl repository;
    late Map<Topic, List<Slide>> testData;

    setUp(() {
      testData = {
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
        ],
        Topic.bloc: [
          const Slide(
            topic: Topic.bloc,
            pageIndex: 0,
            title: 'BLoC Slide 1',
            content: 'Content 1',
          ),
        ],
      };
      repository = SlidesRepositoryImpl(data: testData);
    });

    group('getSlidesByTopic', () {
      test('returns correct slides for topic', () {
        final slides = repository.getSlidesByTopic(Topic.aiTools);

        expect(slides.length, 2);
        expect(slides[0].title, 'AI Slide 1');
        expect(slides[1].title, 'AI Slide 2');
      });

      test('returns empty list for topic with no slides', () {
        final slides = repository.getSlidesByTopic(Topic.solid);

        expect(slides, isEmpty);
      });
    });

    group('getSlide', () {
      test('returns correct slide for valid index', () {
        final slide = repository.getSlide(Topic.aiTools, 1);

        expect(slide, isNotNull);
        expect(slide!.title, 'AI Slide 2');
        expect(slide.pageIndex, 1);
      });

      test('returns null for negative index', () {
        final slide = repository.getSlide(Topic.aiTools, -1);

        expect(slide, isNull);
      });

      test('returns null for index out of bounds', () {
        final slide = repository.getSlide(Topic.aiTools, 10);

        expect(slide, isNull);
      });

      test('returns null for topic with no slides', () {
        final slide = repository.getSlide(Topic.solid, 0);

        expect(slide, isNull);
      });
    });

    group('getSlideCount', () {
      test('returns correct count for topic with slides', () {
        expect(repository.getSlideCount(Topic.aiTools), 2);
        expect(repository.getSlideCount(Topic.bloc), 1);
      });

      test('returns 0 for topic with no slides', () {
        expect(repository.getSlideCount(Topic.solid), 0);
      });
    });

    group('getAllTopics', () {
      test('returns all 7 topics', () {
        final topics = repository.getAllTopics();

        expect(topics.length, 7);
        expect(topics, containsAll(Topic.values));
      });
    });
  });

  group('SlidesRepositoryImpl with default data', () {
    test('uses slidesData when no data provided', () {
      final repository = SlidesRepositoryImpl();

      final slides = repository.getSlidesByTopic(Topic.aiTools);
      expect(slides, isNotEmpty);
    });
  });
}
