import 'package:app/features/slides/domain/domain.dart';

abstract class SlidesRepository {
  List<Slide> getSlidesByTopic(Topic topic);

  Slide? getSlide(Topic topic, int pageIndex);

  int getSlideCount(Topic topic);

  List<Topic> getAllTopics();
}
