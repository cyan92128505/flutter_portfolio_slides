import 'package:equatable/equatable.dart';
import '../../domain/entities/topic.dart';

abstract class SlidesEvent extends Equatable {
  const SlidesEvent();

  @override
  List<Object?> get props => [];
}

class LoadSlides extends SlidesEvent {
  final Topic topic;

  const LoadSlides(this.topic);

  @override
  List<Object?> get props => [topic];
}

class NextSlide extends SlidesEvent {
  const NextSlide();
}

class PreviousSlide extends SlidesEvent {
  const PreviousSlide();
}

class GoToSlide extends SlidesEvent {
  final int pageIndex;

  const GoToSlide(this.pageIndex);

  @override
  List<Object?> get props => [pageIndex];
}
