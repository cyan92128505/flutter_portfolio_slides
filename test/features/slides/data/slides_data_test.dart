import 'package:flutter_test/flutter_test.dart';
import 'package:app/features/slides/data/slides_data.dart';
import 'package:app/features/slides/domain/entities/topic.dart';

void main() {
  group('slidesData', () {
    test('contains all 7 topics', () {
      expect(slidesData.keys.length, 7);
      for (final topic in Topic.values) {
        expect(slidesData.containsKey(topic), isTrue,
            reason: 'Missing topic: ${topic.displayName}');
      }
    });

    test('each topic has at least 1 slide', () {
      for (final topic in Topic.values) {
        final slides = slidesData[topic]!;
        expect(slides.isNotEmpty, isTrue,
            reason: '${topic.displayName} has no slides');
      }
    });

    test('all slides have valid topic reference', () {
      for (final entry in slidesData.entries) {
        final topic = entry.key;
        final slides = entry.value;
        for (final slide in slides) {
          expect(slide.topic, topic,
              reason:
                  'Slide "${slide.title}" has wrong topic: ${slide.topic} != $topic');
        }
      }
    });

    test('all slides have sequential page indices', () {
      for (final entry in slidesData.entries) {
        final slides = entry.value;
        for (int i = 0; i < slides.length; i++) {
          expect(slides[i].pageIndex, i,
              reason:
                  'Slide "${slides[i].title}" has wrong pageIndex: ${slides[i].pageIndex} != $i');
        }
      }
    });

    test('all slides have non-empty title', () {
      for (final slides in slidesData.values) {
        for (final slide in slides) {
          expect(slide.title.isNotEmpty, isTrue);
        }
      }
    });

    test('all slides have non-empty content', () {
      for (final slides in slidesData.values) {
        for (final slide in slides) {
          expect(slide.content.isNotEmpty, isTrue);
        }
      }
    });
  });
}
