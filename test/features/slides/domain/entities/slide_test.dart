import 'package:flutter_test/flutter_test.dart';
import 'package:app/features/slides/domain/entities/slide.dart';
import 'package:app/features/slides/domain/entities/topic.dart';

void main() {
  group('Slide', () {
    test('creates slide with all fields', () {
      const slide = Slide(
        topic: Topic.aiTools,
        pageIndex: 0,
        title: 'Test Title',
        content: 'Test Content',
        codeSnippet: 'print("hello")',
        codeLanguage: 'dart',
      );

      expect(slide.topic, Topic.aiTools);
      expect(slide.pageIndex, 0);
      expect(slide.title, 'Test Title');
      expect(slide.content, 'Test Content');
      expect(slide.codeSnippet, 'print("hello")');
      expect(slide.codeLanguage, 'dart');
    });

    test('creates slide without codeSnippet', () {
      const slide = Slide(
        topic: Topic.bloc,
        pageIndex: 1,
        title: 'No Code Title',
        content: 'No Code Content',
      );

      expect(slide.topic, Topic.bloc);
      expect(slide.pageIndex, 1);
      expect(slide.title, 'No Code Title');
      expect(slide.content, 'No Code Content');
      expect(slide.codeSnippet, isNull);
      expect(slide.codeLanguage, isNull);
    });

    test('two slides with same properties are equal', () {
      const slide1 = Slide(
        topic: Topic.solid,
        pageIndex: 2,
        title: 'Title',
        content: 'Content',
        codeSnippet: 'code',
        codeLanguage: 'dart',
      );

      const slide2 = Slide(
        topic: Topic.solid,
        pageIndex: 2,
        title: 'Title',
        content: 'Content',
        codeSnippet: 'code',
        codeLanguage: 'dart',
      );

      expect(slide1, equals(slide2));
      expect(slide1.hashCode, equals(slide2.hashCode));
    });

    test('two slides with different properties are not equal', () {
      const slide1 = Slide(
        topic: Topic.solid,
        pageIndex: 2,
        title: 'Title',
        content: 'Content',
      );

      const slide2 = Slide(
        topic: Topic.solid,
        pageIndex: 3,
        title: 'Title',
        content: 'Content',
      );

      expect(slide1, isNot(equals(slide2)));
    });

    test('two slides with different topics are not equal', () {
      const slide1 = Slide(
        topic: Topic.solid,
        pageIndex: 0,
        title: 'Title',
        content: 'Content',
      );

      const slide2 = Slide(
        topic: Topic.bloc,
        pageIndex: 0,
        title: 'Title',
        content: 'Content',
      );

      expect(slide1, isNot(equals(slide2)));
    });
  });
}
