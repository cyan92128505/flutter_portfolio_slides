import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:app/features/slides/presentation/widgets/code_block.dart';

void main() {
  group('CodeBlock', () {
    testWidgets('renders HighlightView widget', (tester) async {
      const testCode = 'print("Hello World");';

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CodeBlock(code: testCode),
          ),
        ),
      );

      expect(find.byType(HighlightView), findsOneWidget);
    });

    testWidgets('handles empty code', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CodeBlock(code: ''),
          ),
        ),
      );

      expect(find.byType(CodeBlock), findsOneWidget);
    });

    testWidgets('handles multiline code', (tester) async {
      const multilineCode = '''void main() {
  print("Hello");
  print("World");
}''';

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CodeBlock(code: multilineCode),
          ),
        ),
      );

      expect(find.byType(CodeBlock), findsOneWidget);
      expect(find.byType(HighlightView), findsOneWidget);
    });
  });
}
