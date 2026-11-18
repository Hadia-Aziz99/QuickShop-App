import 'package:flutter_test/flutter_test.dart';
import 'package:quickshop/main.dart';
import 'package:quickshop/screens/splash_screen.dart';
import 'package:quickshop/screens/home_screen.dart';

void main() {
  testWidgets('QuickShop app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const QuickShopApp());

    // Verify that the splash screen is displayed initially with tagline
    expect(find.byType(SplashScreen), findsOneWidget);
    expect(find.text('Fast Find, Easy Buy'), findsOneWidget);

    // Fast-forward past the splash screen timer (2.5 seconds)
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();

    // Verify navigation to HomeScreen
    expect(find.byType(HomeScreen), findsOneWidget);
    expect(find.text('QuickShop'), findsOneWidget);
  });
}
