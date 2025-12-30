import '../domain/entities/slide.dart';
import '../domain/entities/topic.dart';

class MarkdownSlidesParser {
  static final _topicHeaderRegex = RegExp(r'^# \d+\. (.+)$', multiLine: true);
  static final _slideTitleRegex = RegExp(r'^## (.+)$', multiLine: true);
  static final _codeBlockRegex = RegExp(r'```(\w+)?\n([\s\S]*?)```');

  static Map<Topic, List<Slide>> parse(String markdown) {
    final result = <Topic, List<Slide>>{};

    final topicSections = _splitByTopicHeaders(markdown);

    for (final section in topicSections) {
      final topicName = section.topicName;
      if (topicName == null) continue;

      try {
        final topic = Topic.fromDisplayName(topicName);
        final slides = _parseSlidesInSection(section.content, topic);
        if (slides.isNotEmpty) {
          result[topic] = slides;
        }
      } catch (_) {
        // Skip invalid topic names
      }
    }

    return result;
  }

  static List<_TopicSection> _splitByTopicHeaders(String markdown) {
    final sections = <_TopicSection>[];
    final matches = _topicHeaderRegex.allMatches(markdown).toList();

    for (int i = 0; i < matches.length; i++) {
      final match = matches[i];
      final topicName = match.group(1);
      final startIndex = match.end;
      final endIndex = i + 1 < matches.length ? matches[i + 1].start : markdown.length;
      final content = markdown.substring(startIndex, endIndex).trim();

      sections.add(_TopicSection(topicName: topicName, content: content));
    }

    return sections;
  }

  static List<Slide> _parseSlidesInSection(String content, Topic topic) {
    final slides = <Slide>[];
    final rawSlides = content.split(RegExp(r'\n---\n'));

    int pageIndex = 0;
    for (final rawSlide in rawSlides) {
      final trimmed = rawSlide.trim();
      if (trimmed.isEmpty) continue;

      final slide = _parseSlide(trimmed, topic, pageIndex);
      if (slide != null) {
        slides.add(slide);
        pageIndex++;
      }
    }

    return slides;
  }

  static Slide? _parseSlide(String rawSlide, Topic topic, int pageIndex) {
    final titleMatch = _slideTitleRegex.firstMatch(rawSlide);
    if (titleMatch == null) return null;

    final title = titleMatch.group(1)!.trim();

    String content = rawSlide.substring(titleMatch.end).trim();

    String? codeSnippet;
    String? codeLanguage;

    final codeMatch = _codeBlockRegex.firstMatch(content);
    if (codeMatch != null) {
      codeLanguage = codeMatch.group(1) ?? 'dart';
      codeSnippet = codeMatch.group(2)?.trim();

      content = content.replaceFirst(_codeBlockRegex, '').trim();
    }

    return Slide(
      topic: topic,
      pageIndex: pageIndex,
      title: title,
      content: content,
      codeSnippet: codeSnippet,
      codeLanguage: codeLanguage,
    );
  }
}

class _TopicSection {
  final String? topicName;
  final String content;

  _TopicSection({required this.topicName, required this.content});
}
