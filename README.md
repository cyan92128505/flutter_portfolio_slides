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