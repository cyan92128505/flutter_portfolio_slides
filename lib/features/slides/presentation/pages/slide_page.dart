import 'package:app/features/slides/domain/domain.dart';
import 'package:app/features/slides/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SlidePage extends StatelessWidget {
  final Topic topic;

  const SlidePage({super.key, required this.topic});

  @override
  Widget build(BuildContext context) {
    final repository = context.read<SlidesRepository>();
    return BlocProvider(
      create: (context) =>
          SlidesBloc(repository: repository)..add(LoadSlides(topic)),
      child: _SlidePageContent(topic: topic),
    );
  }
}

class _SlidePageContent extends StatefulWidget {
  final Topic topic;

  const _SlidePageContent({required this.topic});

  @override
  State<_SlidePageContent> createState() => _SlidePageContentState();
}

class _SlidePageContentState extends State<_SlidePageContent> {
  int _previousIndex = 0;
  bool _isForward = true;

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
          title: Text(widget.topic.displayName),
          leading: IconButton(
            icon: const Icon(Icons.home),
            onPressed: () => context.go('/'),
          ),
        ),
        body: BlocConsumer<SlidesBloc, SlidesState>(
          listener: (context, state) {
            if (state.currentIndex != _previousIndex) {
              _isForward = state.currentIndex > _previousIndex;
              _previousIndex = state.currentIndex;
            }
          },
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
                    transitionBuilder: (child, animation) {
                      final offsetAnimation = Tween<Offset>(
                        begin: Offset(_isForward ? 1.0 : -1.0, 0.0),
                        end: Offset.zero,
                      ).animate(CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeInOut,
                      ));
                      return SlideTransition(
                        position: offsetAnimation,
                        child: child,
                      );
                    },
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
