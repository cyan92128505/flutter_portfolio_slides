---
title: Flutter Portfolio
tags: presentation
slideOptions:
  theme: white
  transition: slide
---

# Flutter Portfolio

**Cyan Liao**
Senior Software Engineer

---

## Topics

1. AI Tools Usage
2. Flutter Lifecycle + Clean Architecture
3. SOLID Principles
4. BLoC Pattern
5. go_router
6. RESTful API Integration
7. GitHub Flow

---

# 1. AI Tools Usage

---

## AI Tools in Development

Tools I use daily:

- **Claude**: Architecture design, code review
- **Claude Code With VSCode**: AI-powered IDE for coding

---

## Spec-Driven Development

My AI-assisted workflow:

1. Write clear specifications first
2. Let AI generate initial code
3. Review and refine together
4. Human judgment for architecture decisions

---

## Real Project: Travel Agency System

Document tagging system built with AI:

- Stack: Flutter + Node.js serverless + Firebase
- Timeline: 3 weeks (vs estimated 8 weeks)
- AI helped with: boilerplate, edge cases, testing

---

## When AI Helps vs Human Judgment

**AI excels at:**
- Boilerplate code generation
- Finding edge cases
- Documentation

**Human judgment needed for:**
- Architecture decisions
- Business logic validation
- Security review

---

# 2. Flutter Lifecycle + Clean Architecture

---

## StatefulWidget Lifecycle

Key lifecycle methods:

- `createState()`: Creates mutable state
- `initState()`: Called once when inserted
- `didChangeDependencies()`: InheritedWidget changes
- `build()`: Constructs widget tree
- `dispose()`: Cleanup resources

---

## Lifecycle in Action

```dart
class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  late StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = stream.listen(onData);
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
```

---

## Clean Architecture Layers

Three layers with clear boundaries:

1. **Presentation**: UI, BLoC, Widgets
2. **Domain**: Entities, Use Cases, Repository interfaces
3. **Data**: API clients, Database, Repository impl

Dependency rule: outer layers depend on inner layers

---

## Project Example: AirlineConnect

Offline-first architecture:

- ObjectBox for local database
- Repository pattern for data access
- Sync service for conflict resolution
- Clean separation enabled easy testing

---

# 3. SOLID Principles

---

## SOLID Overview

Five principles for maintainable code:

- **S** - Single Responsibility
- **O** - Open/Closed
- **L** - Liskov Substitution
- **I** - Interface Segregation
- **D** - Dependency Inversion

---

## Single Responsibility (SRP)

A class should have only one reason to change.

```dart
// Bad: Multiple responsibilities
class UserManager {
  void login() { }
  void updateProfile() { }
  void sendNotification() { }
}

// Good: Single responsibility each
class AuthService { void login() { } }
class ProfileService { void update() { } }
class NotificationService { void send() { } }
```

---

## Open/Closed (OCP)

Open for extension, closed for modification.

```dart
// Bad: modify existing code for new shapes
double area(Object shape) {
  if (shape is Circle) return pi * shape.r * shape.r;
  if (shape is Square) return shape.side * shape.side;
  // must modify to add Triangle...
}

// Good: extend without modification
abstract class Shape { double area(); }
class Circle extends Shape { double area() => pi * r * r; }
class Square extends Shape { double area() => side * side; }
class Triangle extends Shape { double area() => 0.5 * b * h; }
```

---

## Liskov Substitution (LSP)

Subtypes must be substitutable for their base types.

```dart
// Bad: Square breaks Rectangle behavior
class Rectangle { int width, height; }
class Square extends Rectangle {
  set width(int w) { super.width = w; super.height = w; }
  // Unexpected behavior!
}

// Good: separate abstractions
abstract class Shape { double area(); }
class Rectangle extends Shape { ... }
class Square extends Shape { ... }
```

---

## Interface Segregation (ISP)

Clients should not depend on interfaces they do not use.

```dart
// Bad: fat interface
abstract class Worker {
  void work();
  void eat();
  void sleep();
}

// Good: segregated interfaces
abstract class Workable { void work(); }
abstract class Eatable { void eat(); }
abstract class Sleepable { void sleep(); }

class Human implements Workable, Eatable, Sleepable { ... }
class Robot implements Workable { ... }
```

---

## Dependency Inversion (DIP)

High-level modules should not depend on low-level modules.

```dart
// Domain layer - abstraction
abstract class UserRepository {
  Future<User> getUser(String id);
}

// Data layer - implementation
class UserRepositoryImpl implements UserRepository {
  final ApiClient _api;
  Future<User> getUser(String id) => _api.fetchUser(id);
}

// Presentation - depends on abstraction
class UserBloc {
  final UserRepository _repo; // not UserRepositoryImpl
  UserBloc(this._repo);
}
```

---

# 4. BLoC Pattern

---

## BLoC Pattern

Business Logic Component:

- Separates UI from business logic
- Unidirectional data flow
- Event-driven state management

**Flow:** UI -> Event -> BLoC -> State -> UI

---

## Event and State

```dart
// Events - user actions
abstract class AuthEvent {}
class LoginRequested extends AuthEvent {
  final String email, password;
  LoginRequested(this.email, this.password);
}

// States - UI representation
abstract class AuthState {}
class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {}
class AuthSuccess extends AuthState {
  final User user;
  AuthSuccess(this.user);
}
class AuthFailure extends AuthState {
  final String error;
  AuthFailure(this.error);
}
```

---

## BLoC Implementation

```dart
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _repository;

  AuthBloc(this._repository) : super(AuthInitial()) {
    on<LoginRequested>(_onLogin);
  }

  Future<void> _onLogin(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final user = await _repository.login(
        event.email, event.password);
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
```

---

## BLoC vs Riverpod

**BLoC:**
- Event-driven, explicit state transitions
- Better for complex state machines
- More boilerplate

**Riverpod:**
- Provider-based, reactive
- Less boilerplate
- Good for simple to medium complexity

---

# 5. go_router

---

## go_router Overview

Declarative routing package:

- Built on Navigator 2.0
- Deep linking support (web, mobile)
- Type-safe route parameters
- Redirect and authentication guards
- Nested navigation

---

## Basic Configuration

```dart
final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/slides/:topic',
      name: 'slide',
      builder: (context, state) {
        final topic = state.pathParameters['topic']!;
        return SlidePage(topic: Topic.fromRouteName(topic));
      },
    ),
  ],
);
```

---

## Redirect and Guards

```dart
GoRouter(
  redirect: (context, state) {
    final isLoggedIn = authService.isLoggedIn;
    final isLoginRoute = state.matchedLocation == '/login';

    if (!isLoggedIn && !isLoginRoute) {
      return '/login';
    }
    if (isLoggedIn && isLoginRoute) {
      return '/';
    }
    return null; // no redirect
  },
  routes: [...],
);
```

---

## This Project Example

This presentation app uses go_router:

- `/` : Home page with topic list
- `/slides/:topic` : Slide viewer
- Deep links work on web
- Invalid topics handled gracefully

See: `lib/core/router.dart`

---

# 6. RESTful API Integration

---

## API Layer Architecture

Repository pattern for clean API integration:

- **ApiClient**: Low-level HTTP calls
- **Repository**: Business logic interface
- **Use Cases**: Application-specific operations

Tool of choice: **Dio**

---

## Dio Interceptors

```dart
class AuthInterceptor extends Interceptor {
  @override
  void onRequest(options, handler) {
    final token = tokenStorage.accessToken;
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(error, handler) {
    if (error.response?.statusCode == 401) {
      // Trigger token refresh
    }
    handler.next(error);
  }
}
```

---

## Token Refresh Flow

Automatic token refresh on 401:

1. Request fails with 401
2. Interceptor catches error
3. Call refresh token endpoint
4. Store new tokens
5. Retry original request
6. Handle refresh failure (logout)

---

## Error Handling Strategy

Unified error handling:

- Network errors -> Retry with backoff
- 4xx errors -> Show user message
- 5xx errors -> Generic error + logging
- Timeout -> Retry or offline mode

```dart
sealed class ApiResult<T> {}
class Success<T> extends ApiResult<T> {
  final T data;
  Success(this.data);
}
class Failure<T> extends ApiResult<T> {
  final ApiError error;
  Failure(this.error);
}
```

---

## Scale Experience

GraphQL API serving 80k users:

- Pagination with cursor
- Caching with normalized store
- Optimistic updates for UX
- Subscription for real-time data

---

# 7. GitHub Flow

---

## GitHub Flow

Simple, effective branching model:

1. Create branch from main
2. Make changes, commit often
3. Open Pull Request
4. Discuss and review
5. Merge to main
6. Deploy immediately

---

## GitHub Flow vs Git Flow

**GitHub Flow:**
- Single main branch
- Feature branches only
- Continuous deployment

**Git Flow:**
- main + develop branches
- release, hotfix branches
- Scheduled releases

Choose GitHub Flow for: CI/CD, web apps

---

## Code Review Practices

Effective PR reviews:

- Small, focused PRs (< 400 lines)
- Clear description with context
- Self-review before requesting
- Use draft PRs for WIP
- Address feedback promptly

---

## Branch Naming Convention

Consistent naming helps:

- `feature/add-user-auth`
- `fix/login-crash-ios`
- `refactor/api-layer`
- `docs/update-readme`

Include ticket number if available:
`feature/JIRA-123-add-user-auth`

---

# Thank You

**Cyan Liao**
Senior Software Engineer since 2016

- E-commerce: Flutter iOS/Android, Golang, React
- IoT: Golang + MQTT + GCP, Flutter Web
- Side projects: NestJS, Clean Architecture

---

# Q&A
