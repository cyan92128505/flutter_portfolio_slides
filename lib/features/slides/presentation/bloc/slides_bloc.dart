import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/slides_repository.dart';
import 'slides_event.dart';
import 'slides_state.dart';

class SlidesBloc extends Bloc<SlidesEvent, SlidesState> {
  final SlidesRepository repository;

  SlidesBloc({required this.repository}) : super(const SlidesState()) {
    on<LoadSlides>(_onLoadSlides);
    on<NextSlide>(_onNextSlide);
    on<PreviousSlide>(_onPreviousSlide);
    on<GoToSlide>(_onGoToSlide);
  }

  void _onLoadSlides(LoadSlides event, Emitter<SlidesState> emit) {
    emit(state.copyWith(status: SlidesStatus.loading));

    final slides = repository.getSlidesByTopic(event.topic);

    emit(state.copyWith(
      topic: event.topic,
      slides: slides,
      currentIndex: 0,
      status: SlidesStatus.loaded,
    ));
  }

  void _onNextSlide(NextSlide event, Emitter<SlidesState> emit) {
    if (state.hasNext) {
      emit(state.copyWith(currentIndex: state.currentIndex + 1));
    }
  }

  void _onPreviousSlide(PreviousSlide event, Emitter<SlidesState> emit) {
    if (state.hasPrevious) {
      emit(state.copyWith(currentIndex: state.currentIndex - 1));
    }
  }

  void _onGoToSlide(GoToSlide event, Emitter<SlidesState> emit) {
    if (event.pageIndex >= 0 && event.pageIndex < state.slides.length) {
      emit(state.copyWith(currentIndex: event.pageIndex));
    }
  }
}
