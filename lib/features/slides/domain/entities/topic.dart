enum Topic {
  aiTools,
  flutterLifecycle,
  solid,
  bloc,
  goRouter,
  restfulApi,
  githubFlow;

  String get routeName {
    switch (this) {
      case Topic.aiTools:
        return 'ai-tools';
      case Topic.flutterLifecycle:
        return 'flutter-lifecycle';
      case Topic.solid:
        return 'solid';
      case Topic.bloc:
        return 'bloc';
      case Topic.goRouter:
        return 'go-router';
      case Topic.restfulApi:
        return 'restful-api';
      case Topic.githubFlow:
        return 'github-flow';
    }
  }

  String get displayName {
    switch (this) {
      case Topic.aiTools:
        return 'AI Tools Usage';
      case Topic.flutterLifecycle:
        return 'Flutter Lifecycle + Clean Architecture';
      case Topic.solid:
        return 'SOLID Principles';
      case Topic.bloc:
        return 'BLoC Pattern';
      case Topic.goRouter:
        return 'go_router';
      case Topic.restfulApi:
        return 'RESTful API Integration';
      case Topic.githubFlow:
        return 'GitHub Flow';
    }
  }

  static Topic fromRouteName(String routeName) {
    for (final topic in Topic.values) {
      if (topic.routeName == routeName) {
        return topic;
      }
    }
    throw ArgumentError('Invalid route name: $routeName');
  }

  static Topic fromDisplayName(String displayName) {
    for (final topic in Topic.values) {
      if (topic.displayName == displayName) {
        return topic;
      }
    }
    throw ArgumentError('Invalid display name: $displayName');
  }
}
