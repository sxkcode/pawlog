import 'package:flutter_test/flutter_test.dart';
import 'package:dijupoo_front/main.dart';

void main() {
  testWidgets('App renders without crashing', (WidgetTester tester) async {
    await tester.pumpWidget(const PawlogApp());
    expect(find.text('Pawlog'), findsOneWidget);
  });
}
