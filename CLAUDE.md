# Flutter Portfolio Slides

## Project Goal

Build a Flutter App/Web presentation showcasing 7 technical topics for job application.
This project itself demonstrates: go_router, flutter_bloc, Clean Architecture.

## Tech Stack

- Flutter App/Web
- go_router (routing + deep link)
- flutter_bloc (state management)
- flutter_highlight or highlighter (code syntax highlight)
- Deploy to GitHub Pages on branch page
- Use FVM

## Architecture
```
lib/
├── core/
│   └── router.dart
├── features/
│   └── slides/
│       ├── domain/
│       │   └── entities/slide.dart
│       ├── data/
│       │   └── slides_data.dart
│       └── presentation/
│           ├── bloc/
│           │   ├── slides_bloc.dart
│           │   ├── slides_event.dart
│           │   └── slides_state.dart
│           ├── pages/
│           │   ├── home_page.dart
│           │   └── slide_page.dart
│           └── widgets/
│               └── code_block.dart
└── main.dart
```

## Routes
```
/                        # Home - table of contents
/slides/ai-tools         # Topic 1
/slides/flutter-lifecycle # Topic 2
/slides/solid            # Topic 3
/slides/bloc             # Topic 4
/slides/go-router        # Topic 5
/slides/restful-api      # Topic 6
/slides/github-flow      # Topic 7
```

## Features

- Keyboard left/right arrow to navigate
- Click to navigate between pages
- Table of contents with deep link to each topic
- Each topic has multiple sub-pages
- Code blocks with syntax highlighting
- Simple transition animation

## 7 Topics Content Guide

### 1. AI Tools Usage
- Tools: Claude, Cursor, Copilot
- Workflow: spec driven development
- Real project: Travel agency document tagging system (Flutter + Node.js serverless + Firebase)
- Completed in 3 weeks with AI assistance
- When AI helps vs when human judgment needed

### 2. Flutter Lifecycle + Clean Architecture
- Widget lifecycle: initState, dispose, didChangeDependencies, didUpdateWidget
- Clean Architecture 3 layers: Data / Domain / Presentation
- Show dependency flow diagram
- Reference: AirlineConnect project (ObjectBox offline architecture)

### 3. SOLID Principles
- Five principles for maintainable code
- Show real code snippets

### 4. BLoC Pattern
- Event -> Bloc -> State flow diagram
- Stream and StreamController concept
- Comparison with Riverpod (event-driven vs provider-based)
- When to use BLoC vs Riverpod

### 5. go_router
- Route configuration structure
- Deep link handling
- Redirect and guard (e.g., unauthenticated redirect to login)
- Relation to Navigator 2.0
- Show this project's router.dart as example

### 6. RESTful API Integration
- Repository pattern for API layer organization
- Dio interceptor design
- Error handling strategy
- Token refresh flow
- Reference: GraphQL API serving 80k users

### 7. GitHub Flow
- Feature branch -> PR -> Review -> Merge
- Difference from Git Flow
- Code review practices
- Conflict resolution
- Keep it simple, this is basic

## Author Background (for content reference)

Cyan Liao - Senior Software Engineer since 2016

Recent experience:
- E-commerce (2023-2025): store social platform - independent Flutter app development (iOS/Android), Golang backend, React website
- Toolkit  App (2021-2022): Flutter state refactor, GetX migration, FPS optimization
- IoT (2020-2021): IoT Module system - Golang + MQTT + GCP, Flutter Web admin panel

Side projects:
- Clinic Link: NestJS + React + Clean Architecture
- AirlineConnect: Flutter Clean Architecture research
- Travel agency project: Flutter + Node.js serverless + Firebase (AI-assisted development)

## Code Style

- Comments and commit messages in English
- No emoji in code or commits
- No thinking comments (e.g., // TODO: think about this)
- Commit format: feat/fix/refactor/docs/style/chore

## Development Priority

1. Project setup + go_router skeleton
2. BLoC basic structure (just slide index state)
3. Home page with topic list
4. Slide page with navigation
5. Code block widget with syntax highlight
6. Fill in content for all 7 topics
7. Deploy to GitHub Pages
8. Unit Test in field: Domain, UseCase

Do skeleton first, content later. Ship working version before polishing.