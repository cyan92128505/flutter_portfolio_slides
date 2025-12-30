import 'package:app/features/slides/domain/domain.dart';
import 'package:equatable/equatable.dart';

enum SlidesStatus { initial, loading, loaded, error }

class SlidesState extends Equatable {
  final Topic? topic;
  final List<Slide> slides;
  final int currentIndex;
  final SlidesStatus status;
  final String? errorMessage;

  const SlidesState({
    this.topic,
    this.slides = const [],
    this.currentIndex = 0,
    this.status = SlidesStatus.initial,
    this.errorMessage,
  });

  Slide? get currentSlide {
    if (slides.isEmpty || currentIndex < 0 || currentIndex >= slides.length) {
      return null;
    }
    return slides[currentIndex];
  }

  bool get hasNext => currentIndex < slides.length - 1;

  bool get hasPrevious => currentIndex > 0;

  int get totalSlides => slides.length;

  SlidesState copyWith({
    Topic? topic,
    List<Slide>? slides,
    int? currentIndex,
    SlidesStatus? status,
    String? errorMessage,
  }) {
    return SlidesState(
      topic: topic ?? this.topic,
      slides: slides ?? this.slides,
      currentIndex: currentIndex ?? this.currentIndex,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    topic,
    slides,
    currentIndex,
    status,
    errorMessage,
  ];
}
