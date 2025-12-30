import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/router.dart';
import 'features/slides/data/markdown_slides_parser.dart';
import 'features/slides/data/repositories/slides_repository_impl.dart';
import 'features/slides/domain/repositories/slides_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final repository = await _loadSlidesRepository();

  runApp(PortfolioApp(repository: repository));
}

Future<SlidesRepository> _loadSlidesRepository() async {
  try {
    final markdown = await rootBundle.loadString('assets/slides.md');
    final slidesData = MarkdownSlidesParser.parse(markdown);
    return SlidesRepositoryImpl(data: slidesData);
  } catch (e) {
    return SlidesRepositoryImpl(data: {});
  }
}

class PortfolioApp extends StatelessWidget {
  final SlidesRepository repository;

  const PortfolioApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<SlidesRepository>.value(
      value: repository,
      child: MaterialApp.router(
        title: 'Flutter Portfolio',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
          useMaterial3: true,
        ),
        routerConfig: appRouter,
      ),
    );
  }
}
