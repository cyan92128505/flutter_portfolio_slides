import '../entities/slide.dart';
import '../entities/topic.dart';

abstract class SlidesRepository {
  List<Slide> getSlidesByTopic(Topic topic);

  Slide? getSlide(Topic topic, int pageIndex);

  int getSlideCount(Topic topic);

  List<Topic> getAllTopics();
}
