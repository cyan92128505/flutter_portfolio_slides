import 'package:equatable/equatable.dart';
import 'topic.dart';

class Slide extends Equatable {
  final Topic topic;
  final int pageIndex;
  final String title;
  final String content;
  final String? codeSnippet;
  final String? codeLanguage;

  const Slide({
    required this.topic,
    required this.pageIndex,
    required this.title,
    required this.content,
    this.codeSnippet,
    this.codeLanguage,
  });

  @override
  List<Object?> get props => [
        topic,
        pageIndex,
        title,
        content,
        codeSnippet,
        codeLanguage,
      ];
}
