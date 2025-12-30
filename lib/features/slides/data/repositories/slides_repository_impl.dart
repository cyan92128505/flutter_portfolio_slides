import 'package:app/features/slides/data/data.dart';
import 'package:app/features/slides/domain/domain.dart';

class SlidesRepositoryImpl implements SlidesRepository {
  final Map<Topic, List<Slide>> _data;

  SlidesRepositoryImpl({Map<Topic, List<Slide>>? data})
    : _data = data ?? slidesData;

  @override
  List<Slide> getSlidesByTopic(Topic topic) {
    return _data[topic] ?? [];
  }

  @override
  Slide? getSlide(Topic topic, int pageIndex) {
    final slides = _data[topic];
    if (slides == null || pageIndex < 0 || pageIndex >= slides.length) {
      return null;
    }
    return slides[pageIndex];
  }

  @override
  int getSlideCount(Topic topic) {
    return _data[topic]?.length ?? 0;
  }

  @override
  List<Topic> getAllTopics() {
    return Topic.values;
  }
}
