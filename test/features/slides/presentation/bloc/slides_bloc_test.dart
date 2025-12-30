import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app/features/slides/presentation/bloc/slides_bloc.dart';
import 'package:app/features/slides/presentation/bloc/slides_event.dart';
import 'package:app/features/slides/presentation/bloc/slides_state.dart';
import 'package:app/features/slides/domain/entities/slide.dart';
import 'package:app/features/slides/domain/entities/topic.dart';
import 'package:app/features/slides/domain/repositories/slides_repository.dart';

class MockSlidesRepository implements SlidesRepository {
  final Map<Topic, List<Slide>> _data;

  MockSlidesRepository(this._data);

  @override
  List<Slide> getSlidesByTopic(Topic topic) => _data[topic] ?? [];

  @override
  Slide? getSlide(Topic topic, int pageIndex) {
    final slides = _data[topic];
    if (slides == null || pageIndex < 0 || pageIndex >= slides.length) {
      return null;
    }
    return slides[pageIndex];
  }

  @override
  int getSlideCount(Topic topic) => _data[topic]?.length ?? 0;

  @override
  List<Topic> getAllTopics() => Topic.values;
}

void main() {
  group('SlidesBloc', () {
    late SlidesBloc bloc;
    late MockSlidesRepository repository;
    late List<Slide> testSlides;

    setUp(() {
      testSlides = [
        const Slide(
          topic: Topic.aiTools,
          pageIndex: 0,
          title: 'Slide 1',
          content: 'Content 1',
        ),
        const Slide(
          topic: Topic.aiTools,
          pageIndex: 1,
          title: 'Slide 2',
          content: 'Content 2',
        ),
        const Slide(
          topic: Topic.aiTools,
          pageIndex: 2,
          title: 'Slide 3',
          content: 'Content 3',
        ),
      ];
      repository = MockSlidesRepository({Topic.aiTools: testSlides});
      bloc = SlidesBloc(repository: repository);
    });

    tearDown(() {
      bloc.close();
    });

    test('initial state is correct', () {
      expect(bloc.state, const SlidesState());
      expect(bloc.state.status, SlidesStatus.initial);
      expect(bloc.state.slides, isEmpty);
      expect(bloc.state.currentIndex, 0);
    });

    group('LoadSlides', () {
      blocTest<SlidesBloc, SlidesState>(
        'emits loading then loaded state',
        build: () => bloc,
        act: (bloc) => bloc.add(const LoadSlides(Topic.aiTools)),
        expect: () => [
          const SlidesState(status: SlidesStatus.loading),
          SlidesState(
            topic: Topic.aiTools,
            slides: testSlides,
            currentIndex: 0,
            status: SlidesStatus.loaded,
          ),
        ],
      );

      blocTest<SlidesBloc, SlidesState>(
        'sets currentIndex to 0',
        build: () => bloc,
        act: (bloc) => bloc.add(const LoadSlides(Topic.aiTools)),
        verify: (bloc) {
          expect(bloc.state.currentIndex, 0);
        },
      );

      blocTest<SlidesBloc, SlidesState>(
        'loads empty slides for topic with no slides',
        build: () => SlidesBloc(
          repository: MockSlidesRepository({Topic.aiTools: testSlides}),
        ),
        act: (bloc) => bloc.add(const LoadSlides(Topic.bloc)),
        verify: (bloc) {
          expect(bloc.state.slides, isEmpty);
          expect(bloc.state.status, SlidesStatus.loaded);
        },
      );
    });

    group('NextSlide', () {
      blocTest<SlidesBloc, SlidesState>(
        'increments currentIndex',
        build: () => bloc,
        seed: () => SlidesState(
          slides: testSlides,
          currentIndex: 0,
          status: SlidesStatus.loaded,
        ),
        act: (bloc) => bloc.add(const NextSlide()),
        expect: () => [
          SlidesState(
            slides: testSlides,
            currentIndex: 1,
            status: SlidesStatus.loaded,
          ),
        ],
      );

      blocTest<SlidesBloc, SlidesState>(
        'does nothing at last slide',
        build: () => bloc,
        seed: () => SlidesState(
          slides: testSlides,
          currentIndex: 2,
          status: SlidesStatus.loaded,
        ),
        act: (bloc) => bloc.add(const NextSlide()),
        expect: () => [],
      );
    });

    group('PreviousSlide', () {
      blocTest<SlidesBloc, SlidesState>(
        'decrements currentIndex',
        build: () => bloc,
        seed: () => SlidesState(
          slides: testSlides,
          currentIndex: 2,
          status: SlidesStatus.loaded,
        ),
        act: (bloc) => bloc.add(const PreviousSlide()),
        expect: () => [
          SlidesState(
            slides: testSlides,
            currentIndex: 1,
            status: SlidesStatus.loaded,
          ),
        ],
      );

      blocTest<SlidesBloc, SlidesState>(
        'does nothing at first slide',
        build: () => bloc,
        seed: () => SlidesState(
          slides: testSlides,
          currentIndex: 0,
          status: SlidesStatus.loaded,
        ),
        act: (bloc) => bloc.add(const PreviousSlide()),
        expect: () => [],
      );
    });

    group('GoToSlide', () {
      blocTest<SlidesBloc, SlidesState>(
        'sets correct index',
        build: () => bloc,
        seed: () => SlidesState(
          slides: testSlides,
          currentIndex: 0,
          status: SlidesStatus.loaded,
        ),
        act: (bloc) => bloc.add(const GoToSlide(2)),
        expect: () => [
          SlidesState(
            slides: testSlides,
            currentIndex: 2,
            status: SlidesStatus.loaded,
          ),
        ],
      );

      blocTest<SlidesBloc, SlidesState>(
        'ignores negative index',
        build: () => bloc,
        seed: () => SlidesState(
          slides: testSlides,
          currentIndex: 1,
          status: SlidesStatus.loaded,
        ),
        act: (bloc) => bloc.add(const GoToSlide(-1)),
        expect: () => [],
      );

      blocTest<SlidesBloc, SlidesState>(
        'ignores index out of bounds',
        build: () => bloc,
        seed: () => SlidesState(
          slides: testSlides,
          currentIndex: 1,
          status: SlidesStatus.loaded,
        ),
        act: (bloc) => bloc.add(const GoToSlide(10)),
        expect: () => [],
      );
    });
  });
}
