import 'package:flutter_test/flutter_test.dart';
import 'package:app/features/slides/data/markdown_slides_parser.dart';
import 'package:app/features/slides/domain/entities/topic.dart';

void main() {
  group('MarkdownSlidesParser', () {
    test('parses topic header correctly', () {
      const markdown = '''
# 1. AI Tools Usage

---

## First Slide

Content here.
''';

      final result = MarkdownSlidesParser.parse(markdown);

      expect(result.containsKey(Topic.aiTools), isTrue);
      expect(result[Topic.aiTools]!.length, 1);
    });

    test('splits slides by ---', () {
      const markdown = '''
# 1. AI Tools Usage

---

## First Slide

Content 1.

---

## Second Slide

Content 2.
''';

      final result = MarkdownSlidesParser.parse(markdown);

      expect(result[Topic.aiTools]!.length, 2);
      expect(result[Topic.aiTools]![0].title, 'First Slide');
      expect(result[Topic.aiTools]![1].title, 'Second Slide');
    });

    test('extracts slide title', () {
      const markdown = '''
# 1. AI Tools Usage

---

## My Slide Title

Some content.
''';

      final result = MarkdownSlidesParser.parse(markdown);

      expect(result[Topic.aiTools]![0].title, 'My Slide Title');
    });

    test('extracts code block with language', () {
      const markdown = '''
# 1. AI Tools Usage

---

## Code Example

Description here.

```dart
void main() {
  print('hello');
}
```
''';

      final result = MarkdownSlidesParser.parse(markdown);
      final slide = result[Topic.aiTools]![0];

      expect(slide.codeSnippet, contains("void main()"));
      expect(slide.codeLanguage, 'dart');
    });

    test('extracts content without code block', () {
      const markdown = '''
# 1. AI Tools Usage

---

## No Code Slide

Just some text content.
Multiple lines.
''';

      final result = MarkdownSlidesParser.parse(markdown);
      final slide = result[Topic.aiTools]![0];

      expect(slide.content, contains('Just some text content.'));
      expect(slide.codeSnippet, isNull);
      expect(slide.codeLanguage, isNull);
    });

    test('handles multiple topics', () {
      const markdown = '''
# 1. AI Tools Usage

---

## AI Slide

AI content.

---

# 2. GitHub Flow

---

## GitHub Slide

GitHub content.
''';

      final result = MarkdownSlidesParser.parse(markdown);

      expect(result.containsKey(Topic.aiTools), isTrue);
      expect(result.containsKey(Topic.githubFlow), isTrue);
      expect(result[Topic.aiTools]!.length, 1);
      expect(result[Topic.githubFlow]!.length, 1);
    });

    test('assigns correct pageIndex', () {
      const markdown = '''
# 1. AI Tools Usage

---

## Slide 0

Content.

---

## Slide 1

Content.

---

## Slide 2

Content.
''';

      final result = MarkdownSlidesParser.parse(markdown);

      expect(result[Topic.aiTools]![0].pageIndex, 0);
      expect(result[Topic.aiTools]![1].pageIndex, 1);
      expect(result[Topic.aiTools]![2].pageIndex, 2);
    });

    test('handles empty slides gracefully', () {
      const markdown = '''
# 1. AI Tools Usage

---

---

## Valid Slide

Content.

---
''';

      final result = MarkdownSlidesParser.parse(markdown);

      expect(result[Topic.aiTools]!.length, 1);
      expect(result[Topic.aiTools]![0].title, 'Valid Slide');
    });

    test('skips invalid topic names', () {
      const markdown = '''
# 1. Invalid Topic Name

---

## Slide

Content.

---

# 2. AI Tools Usage

---

## Valid Slide

Content.
''';

      final result = MarkdownSlidesParser.parse(markdown);

      expect(result.containsKey(Topic.aiTools), isTrue);
      expect(result.length, 1);
    });

    test('sets topic correctly on each slide', () {
      const markdown = '''
# 1. SOLID Principles

---

## SRP

Content.
''';

      final result = MarkdownSlidesParser.parse(markdown);
      final slide = result[Topic.solid]![0];

      expect(slide.topic, Topic.solid);
    });

    test('content excludes code block', () {
      const markdown = '''
# 1. AI Tools Usage

---

## Mixed Content

Text before code.

```dart
code here
```
''';

      final result = MarkdownSlidesParser.parse(markdown);
      final slide = result[Topic.aiTools]![0];

      expect(slide.content, contains('Text before code.'));
      expect(slide.content, isNot(contains('```')));
      expect(slide.content, isNot(contains('code here')));
    });
  });
}
