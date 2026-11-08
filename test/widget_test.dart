import 'package:flutter_test/flutter_test.dart';
import 'package:mynearby_partner/main.dart';

void main() {
  testWidgets('MyNearby Partner App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyNearbyPartnerApp());
    expect(find.byType(MyNearbyPartnerApp), findsOneWidget);
  });
}
