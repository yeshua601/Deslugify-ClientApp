import 'package:flutter_test/flutter_test.dart';
import 'package:clientapp/main.dart';

void main() {
  testWidgets('App starts on Landing screen', (WidgetTester tester) async {
    await tester.pumpWidget(const DeslugifyApp());
    await tester.pumpAndSettle();

    // Landing should show app name
    expect(find.text('Deslugify'), findsWidgets);
  });

  testWidgets('Landing has Get Started and Login', (WidgetTester tester) async {
    await tester.pumpWidget(const DeslugifyApp());
    await tester.pumpAndSettle();

    expect(find.text('Get Started'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
  });
}