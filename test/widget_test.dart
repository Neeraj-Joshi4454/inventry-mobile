import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:inventry_mobile/features/auth/screens/login_screen.dart';
import 'package:inventry_mobile/main.dart';

void main() {
  // flutter_secure_storage talks to native code over a MethodChannel, which
  // doesn't exist in the widget-test environment — stub it to behave like
  // "no session stored" so AuthNotifier's startup flow resolves cleanly to
  // unauthenticated instead of throwing.
  const channel = MethodChannel('plugins.it_nomads.com/flutter_secure_storage');

  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, (call) async {
      if (call.method == 'read') return null;
      if (call.method == 'readAll') return <String, String>{};
      return null;
    });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  testWidgets('shows the login screen when no session is stored', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: InventryApp()));

    // First frame: splash screen while session restoration is in flight.
    await tester.pump();
    // Let the fire-and-forget restoration microtask + redirect settle.
    await tester.pumpAndSettle();

    expect(find.byType(LoginScreen), findsOneWidget);
    expect(find.text('Mobile Number'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
  });
}
