import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../data/repositories/slides_repository_impl.dart';
import '../../domain/entities/topic.dart';
import '../bloc/slides_bloc.dart';
import '../bloc/slides_event.dart';
import '../bloc/slides_state.dart';
import '../widgets/slide_content.dart';
import '../widgets/slide_navigation.dart';

class SlidePage extends StatelessWidget {
  final Topic topic;

  const SlidePage({super.key, required this.topic});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SlidesBloc(repository: SlidesRepositoryImpl())
        ..add(LoadSlides(topic)),
      child: _SlidePageContent(topic: topic),
    );
  }
}

class _SlidePageContent extends StatelessWidget {
  final Topic topic;

  const _SlidePageContent({required this.topic});

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: FocusNode()..requestFocus(),
      onKeyEvent: (event) {
        if (event is KeyDownEvent) {
          if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
            context.read<SlidesBloc>().add(const NextSlide());
          } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
            context.read<SlidesBloc>().add(const PreviousSlide());
          } else if (event.logicalKey == LogicalKeyboardKey.escape) {
            context.go('/');
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(topic.displayName),
          leading: IconButton(
            icon: const Icon(Icons.home),
            onPressed: () => context.go('/'),
          ),
        ),
        body: BlocBuilder<SlidesBloc, SlidesState>(
          builder: (context, state) {
            if (state.status == SlidesStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.slides.isEmpty) {
              return const Center(child: Text('No slides available'));
            }

            return Column(
              children: [
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: SlideContent(
                      key: ValueKey(state.currentIndex),
                      slide: state.currentSlide!,
                    ),
                  ),
                ),
                SlideNavigation(
                  currentIndex: state.currentIndex,
                  totalSlides: state.totalSlides,
                  hasPrevious: state.hasPrevious,
                  hasNext: state.hasNext,
                  onPrevious: () =>
                      context.read<SlidesBloc>().add(const PreviousSlide()),
                  onNext: () =>
                      context.read<SlidesBloc>().add(const NextSlide()),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
