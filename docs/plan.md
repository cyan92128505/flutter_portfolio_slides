# Flutter Portfolio Slides - Development Plan

## Overview

This document tracks development progress for session continuity.
Each task is atomic and has corresponding unit tests.

## Progress Legend

- [ ] Not started
- [x] Completed
- [~] In progress

---

## Phase 0: Project Setup

### 0.1 Dependencies
- [x] **0.1.1** Update pubspec.yaml with go_router
- [x] **0.1.2** Update pubspec.yaml with flutter_bloc
- [x] **0.1.3** Update pubspec.yaml with flutter_highlight
- [x] **0.1.4** Update pubspec.yaml with equatable (for bloc states)
- [x] **0.1.5** Run fvm flutter pub get

### 0.2 Directory Structure
- [x] **0.2.1** Create lib/core/
- [x] **0.2.2** Create lib/features/slides/domain/entities/
- [x] **0.2.3** Create lib/features/slides/data/
- [x] **0.2.4** Create lib/features/slides/presentation/bloc/
- [x] **0.2.5** Create lib/features/slides/presentation/pages/
- [x] **0.2.6** Create lib/features/slides/presentation/widgets/
- [x] **0.2.7** Create test/features/slides/domain/
- [x] **0.2.8** Create test/features/slides/data/
- [x] **0.2.9** Create test/features/slides/presentation/bloc/

---

## Phase 1: Domain Layer (No Dependencies)

### 1.1 Topic Enum
- [x] **1.1.1** Create `lib/features/slides/domain/entities/topic.dart`
  - Define Topic enum with 7 values
  - Add `routeName` getter (e.g., 'ai-tools')
  - Add `displayName` getter (e.g., 'AI Tools Usage')
  - Add `fromRouteName` factory
- [x] **1.1.2** Create `test/features/slides/domain/entities/topic_test.dart`
  - Test: each topic has correct routeName
  - Test: each topic has correct displayName
  - Test: fromRouteName returns correct topic
  - Test: fromRouteName throws for invalid route

### 1.2 Slide Entity
- [x] **1.2.1** Create `lib/features/slides/domain/entities/slide.dart`
  - Define Slide class with: topic, pageIndex, title, content, codeSnippet (optional)
  - Implement equality (extend Equatable or override ==)
- [x] **1.2.2** Create `test/features/slides/domain/entities/slide_test.dart`
  - Test: Slide creation with all fields
  - Test: Slide creation without codeSnippet
  - Test: Slide equality comparison
  - Test: Slide inequality when different

### 1.3 Slides Repository Interface
- [x] **1.3.1** Create `lib/features/slides/domain/repositories/slides_repository.dart`
  - Define abstract SlidesRepository
  - Method: List<Slide> getSlidesByTopic(Topic topic)
  - Method: Slide? getSlide(Topic topic, int pageIndex)
  - Method: int getSlideCount(Topic topic)
  - Method: List<Topic> getAllTopics()
- [x] **1.3.2** No unit test needed (interface only)

---

## Phase 2: Data Layer

### 2.1 Slides Data (Static Content)
- [x] **2.1.1** Create `lib/features/slides/data/slides_data.dart`
  - Define slidesData as Map<Topic, List<Slide>>
  - Add placeholder content for all 7 topics (1-2 slides each initially)
- [x] **2.1.2** Create `test/features/slides/data/slides_data_test.dart`
  - Test: slidesData contains all 7 topics
  - Test: each topic has at least 1 slide
  - Test: all slides have valid topic reference

### 2.2 Slides Repository Implementation
- [x] **2.2.1** Create `lib/features/slides/data/repositories/slides_repository_impl.dart`
  - Implement SlidesRepository interface
  - Use slidesData as data source
- [x] **2.2.2** Create `test/features/slides/data/repositories/slides_repository_impl_test.dart`
  - Test: getSlidesByTopic returns correct slides
  - Test: getSlidesByTopic returns empty list for topic with no slides
  - Test: getSlide returns correct slide
  - Test: getSlide returns null for invalid index
  - Test: getSlideCount returns correct count
  - Test: getAllTopics returns all 7 topics

---

## Phase 3: Presentation Layer - BLoC

### 3.1 Slides Event
- [ ] **3.1.1** Create `lib/features/slides/presentation/bloc/slides_event.dart`
  - Define abstract SlidesEvent (extends Equatable)
  - Define LoadSlides event (with Topic parameter)
  - Define NextSlide event
  - Define PreviousSlide event
  - Define GoToSlide event (with int pageIndex)
- [ ] **3.1.2** Create `test/features/slides/presentation/bloc/slides_event_test.dart`
  - Test: LoadSlides equality
  - Test: GoToSlide equality
  - Test: NextSlide and PreviousSlide are singletons or equal

### 3.2 Slides State
- [ ] **3.2.1** Create `lib/features/slides/presentation/bloc/slides_state.dart`
  - Define SlidesState (extends Equatable)
  - Fields: topic, slides, currentIndex, status (loading/loaded/error)
  - Getters: currentSlide, hasNext, hasPrevious, totalSlides
- [ ] **3.2.2** Create `test/features/slides/presentation/bloc/slides_state_test.dart`
  - Test: initial state values
  - Test: currentSlide returns correct slide
  - Test: hasNext returns true when not at last slide
  - Test: hasNext returns false at last slide
  - Test: hasPrevious returns false at first slide
  - Test: hasPrevious returns true when not at first slide
  - Test: state equality

### 3.3 Slides BLoC
- [ ] **3.3.1** Create `lib/features/slides/presentation/bloc/slides_bloc.dart`
  - Inject SlidesRepository
  - Handle LoadSlides: load slides for topic, set currentIndex to 0
  - Handle NextSlide: increment currentIndex if hasNext
  - Handle PreviousSlide: decrement currentIndex if hasPrevious
  - Handle GoToSlide: set currentIndex if valid
- [ ] **3.3.2** Create `test/features/slides/presentation/bloc/slides_bloc_test.dart`
  - Test: initial state is correct
  - Test: LoadSlides emits loading then loaded state
  - Test: LoadSlides sets slides and currentIndex to 0
  - Test: NextSlide increments currentIndex
  - Test: NextSlide does nothing at last slide
  - Test: PreviousSlide decrements currentIndex
  - Test: PreviousSlide does nothing at first slide
  - Test: GoToSlide sets correct index
  - Test: GoToSlide ignores invalid index

---

## Phase 4: Presentation Layer - Router

### 4.1 App Router
- [ ] **4.1.1** Create `lib/core/router.dart`
  - Define GoRouter with routes:
    - `/` -> HomePage
    - `/slides/:topic` -> SlidePage
  - Add redirect for invalid topic routes
- [ ] **4.1.2** Create `test/core/router_test.dart`
  - Test: root route navigates to HomePage
  - Test: /slides/ai-tools navigates to SlidePage with correct topic
  - Test: /slides/invalid redirects to home or shows error

---

## Phase 5: Presentation Layer - Widgets

### 5.1 Code Block Widget
- [ ] **5.1.1** Create `lib/features/slides/presentation/widgets/code_block.dart`
  - Display code with syntax highlighting
  - Support language parameter (dart, yaml, etc.)
  - Scrollable for long code
- [ ] **5.1.2** Create `test/features/slides/presentation/widgets/code_block_test.dart`
  - Test: widget renders code text
  - Test: widget handles empty code
  - Test: widget is scrollable

### 5.2 Topic Card Widget
- [ ] **5.2.1** Create `lib/features/slides/presentation/widgets/topic_card.dart`
  - Display topic name and description
  - Tappable with onTap callback
- [ ] **5.2.2** Create `test/features/slides/presentation/widgets/topic_card_test.dart`
  - Test: displays topic name
  - Test: onTap callback is triggered

### 5.3 Slide Navigation Widget
- [ ] **5.3.1** Create `lib/features/slides/presentation/widgets/slide_navigation.dart`
  - Previous/Next buttons
  - Page indicator (e.g., "3 / 10")
  - Disable buttons at boundaries
- [ ] **5.3.2** Create `test/features/slides/presentation/widgets/slide_navigation_test.dart`
  - Test: displays correct page indicator
  - Test: previous button disabled at first slide
  - Test: next button disabled at last slide
  - Test: button callbacks are triggered

### 5.4 Slide Content Widget
- [ ] **5.4.1** Create `lib/features/slides/presentation/widgets/slide_content.dart`
  - Display slide title
  - Display slide content (markdown or plain text)
  - Display code block if present
- [ ] **5.4.2** Create `test/features/slides/presentation/widgets/slide_content_test.dart`
  - Test: displays title
  - Test: displays content
  - Test: displays code block when present
  - Test: hides code block when not present

---

## Phase 6: Presentation Layer - Pages

### 6.1 Home Page
- [ ] **6.1.1** Create `lib/features/slides/presentation/pages/home_page.dart`
  - Display title "Flutter Portfolio"
  - List all 7 topics as TopicCards
  - Navigate to SlidePage on tap
- [ ] **6.1.2** Create `test/features/slides/presentation/pages/home_page_test.dart`
  - Test: displays all 7 topics
  - Test: tapping topic navigates to correct route

### 6.2 Slide Page
- [ ] **6.2.1** Create `lib/features/slides/presentation/pages/slide_page.dart`
  - Receive topic from route parameter
  - Provide SlidesBloc
  - Display SlideContent for current slide
  - Display SlideNavigation
  - Handle keyboard left/right arrows
  - Add slide transition animation
- [ ] **6.2.2** Create `test/features/slides/presentation/pages/slide_page_test.dart`
  - Test: displays slide content
  - Test: displays navigation
  - Test: keyboard right arrow goes to next slide
  - Test: keyboard left arrow goes to previous slide

---

## Phase 7: App Integration

### 7.1 Main App
- [ ] **7.1.1** Update `lib/main.dart`
  - Remove counter demo code
  - Setup MaterialApp.router with GoRouter
  - Setup BlocProvider at app level (optional, or per-page)
  - Configure theme
- [ ] **7.1.2** Update `test/widget_test.dart`
  - Test: app builds without error
  - Test: app shows home page initially

### 7.2 Barrel Files (Optional)
- [ ] **7.2.1** Create barrel files for clean imports
  - lib/features/slides/domain/domain.dart
  - lib/features/slides/data/data.dart
  - lib/features/slides/presentation/presentation.dart

---

## Phase 8: Content Population

### 8.1 AI Tools Content
- [ ] **8.1.1** Add slides for AI Tools topic (3-5 slides)

### 8.2 Flutter Lifecycle Content
- [ ] **8.2.1** Add slides for Flutter Lifecycle topic (3-5 slides)

### 8.3 SOLID Content
- [ ] **8.3.1** Add slides for SOLID topic (3-5 slides)

### 8.4 BLoC Content
- [ ] **8.4.1** Add slides for BLoC topic (3-5 slides)

### 8.5 go_router Content
- [ ] **8.5.1** Add slides for go_router topic (3-5 slides)

### 8.6 RESTful API Content
- [ ] **8.6.1** Add slides for RESTful API topic (3-5 slides)

### 8.7 GitHub Flow Content
- [ ] **8.7.1** Add slides for GitHub Flow topic (3-5 slides)

---

## Phase 9: Polish and Deploy

### 9.1 UI Polish
- [ ] **9.1.1** Add transition animations between slides
- [ ] **9.1.2** Responsive layout for web/mobile
- [ ] **9.1.3** Theme and styling refinement

### 9.2 GitHub Pages Deployment
- [ ] **9.2.1** Configure web build for GitHub Pages
- [ ] **9.2.2** Setup GitHub Actions for auto-deploy
- [ ] **9.2.3** Test deployment on branch `page`

---

## Session Continuity Notes

When resuming a session:
1. Check this file for current progress
2. Find the first uncompleted `[ ]` task
3. Read related completed tasks for context
4. Continue from that point

### Current Session Status

**Last Updated**: Not started
**Current Phase**: 0
**Current Task**: 0.1.1
**Notes**: Initial project setup pending

---

## File Dependency Graph

```
Domain (no deps):
  topic.dart
  slide.dart
  slides_repository.dart (interface)

Data (depends on Domain):
  slides_data.dart
  slides_repository_impl.dart

Presentation - BLoC (depends on Domain):
  slides_event.dart
  slides_state.dart
  slides_bloc.dart (depends on repository interface)

Presentation - Router (depends on Pages):
  router.dart

Presentation - Widgets (depends on Domain entities):
  code_block.dart
  topic_card.dart
  slide_navigation.dart
  slide_content.dart

Presentation - Pages (depends on BLoC, Widgets):
  home_page.dart
  slide_page.dart

App:
  main.dart (depends on Router, BLoC)
```

## Test Commands

```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/features/slides/domain/entities/topic_test.dart

# Run tests with coverage
flutter test --coverage

# Run tests in watch mode (with build_runner)
flutter pub run build_runner watch
```
