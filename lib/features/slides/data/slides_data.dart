import '../domain/entities/slide.dart';
import '../domain/entities/topic.dart';

final Map<Topic, List<Slide>> slidesData = {
  Topic.aiTools: [
    const Slide(
      topic: Topic.aiTools,
      pageIndex: 0,
      title: 'AI Tools Usage',
      content: 'Tools: Claude, Cursor, Copilot\n\n'
          'Workflow: Spec-driven development with AI assistance.',
    ),
    const Slide(
      topic: Topic.aiTools,
      pageIndex: 1,
      title: 'Real Project Example',
      content: 'Travel agency document tagging system\n\n'
          '- Flutter + Node.js serverless + Firebase\n'
          '- Completed in 3 weeks with AI assistance',
    ),
  ],
  Topic.flutterLifecycle: [
    const Slide(
      topic: Topic.flutterLifecycle,
      pageIndex: 0,
      title: 'Flutter Widget Lifecycle',
      content: 'Key lifecycle methods:\n\n'
          '- initState()\n'
          '- didChangeDependencies()\n'
          '- didUpdateWidget()\n'
          '- dispose()',
    ),
    const Slide(
      topic: Topic.flutterLifecycle,
      pageIndex: 1,
      title: 'Clean Architecture Layers',
      content: 'Three layers:\n\n'
          '1. Data Layer - API, Database\n'
          '2. Domain Layer - Entities, Use Cases\n'
          '3. Presentation Layer - UI, State Management',
    ),
  ],
  Topic.solid: [
    const Slide(
      topic: Topic.solid,
      pageIndex: 0,
      title: 'SOLID Principles',
      content: 'Focus on SRP and DIP:\n\n'
          '- Single Responsibility Principle\n'
          '- Dependency Inversion Principle',
    ),
    const Slide(
      topic: Topic.solid,
      pageIndex: 1,
      title: 'Dependency Inversion',
      content: 'High-level modules should not depend on low-level modules.\n\n'
          'Both should depend on abstractions.',
      codeSnippet: '''abstract class Repository {
  Future<User> getUser(String id);
}

class UserBloc {
  final Repository repository;
  UserBloc(this.repository);
}''',
      codeLanguage: 'dart',
    ),
  ],
  Topic.bloc: [
    const Slide(
      topic: Topic.bloc,
      pageIndex: 0,
      title: 'BLoC Pattern',
      content: 'Event -> BLoC -> State\n\n'
          'Unidirectional data flow with streams.',
    ),
    const Slide(
      topic: Topic.bloc,
      pageIndex: 1,
      title: 'Stream Concept',
      content: 'BLoC uses StreamController internally.\n\n'
          'Events in, States out.',
      codeSnippet: '''class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    on<Increment>((event, emit) => emit(state + 1));
    on<Decrement>((event, emit) => emit(state - 1));
  }
}''',
      codeLanguage: 'dart',
    ),
  ],
  Topic.goRouter: [
    const Slide(
      topic: Topic.goRouter,
      pageIndex: 0,
      title: 'go_router',
      content: 'Declarative routing for Flutter.\n\n'
          '- Deep linking support\n'
          '- Type-safe routes\n'
          '- Redirect and guards',
    ),
    const Slide(
      topic: Topic.goRouter,
      pageIndex: 1,
      title: 'Route Configuration',
      content: 'Define routes with GoRoute objects.',
      codeSnippet: '''final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => HomePage(),
    ),
    GoRoute(
      path: '/slides/:topic',
      builder: (context, state) {
        final topic = state.pathParameters['topic']!;
        return SlidePage(topic: topic);
      },
    ),
  ],
);''',
      codeLanguage: 'dart',
    ),
  ],
  Topic.restfulApi: [
    const Slide(
      topic: Topic.restfulApi,
      pageIndex: 0,
      title: 'RESTful API Integration',
      content: 'Repository pattern for API layer.\n\n'
          '- Dio for HTTP client\n'
          '- Interceptors for auth/logging\n'
          '- Error handling strategy',
    ),
    const Slide(
      topic: Topic.restfulApi,
      pageIndex: 1,
      title: 'Token Refresh Flow',
      content: 'Handle 401 errors with token refresh.\n\n'
          'Interceptor catches error, refreshes token, retries request.',
    ),
  ],
  Topic.githubFlow: [
    const Slide(
      topic: Topic.githubFlow,
      pageIndex: 0,
      title: 'GitHub Flow',
      content: 'Simple branching model:\n\n'
          '1. Create feature branch\n'
          '2. Make changes\n'
          '3. Open Pull Request\n'
          '4. Review and merge',
    ),
    const Slide(
      topic: Topic.githubFlow,
      pageIndex: 1,
      title: 'vs Git Flow',
      content: 'GitHub Flow is simpler:\n\n'
          '- No develop branch\n'
          '- No release branches\n'
          '- Main is always deployable',
    ),
  ],
};
