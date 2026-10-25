import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:inventry_mobile/core/network/api_exception.dart';
import 'package:inventry_mobile/features/auth/data/auth_api.dart';
import 'package:inventry_mobile/features/auth/providers/auth_provider.dart';
import 'package:inventry_mobile/features/auth/screens/login_screen.dart';
import 'package:inventry_mobile/features/auth/screens/register_screen.dart';
import 'package:inventry_mobile/main.dart';

class _FakeAuthApi extends AuthApi {
  _FakeAuthApi({this.error}) : super(Dio());

  final ApiException? error;
  Map<String, Object?>? submitted;

  @override
  Future<void> register({
    required String businessName,
    required String ownerName,
    required String mobileNumber,
    String? email,
    required String password,
  }) async {
    if (error != null) throw error!;
    submitted = {
      'businessName': businessName,
      'ownerName': ownerName,
      'mobileNumber': mobileNumber,
      'email': email,
      'password': password,
    };
  }
}

void main() {
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

  Future<void> openRegister(WidgetTester tester, _FakeAuthApi api) async {
    await tester.pumpWidget(
      ProviderScope(overrides: [authApiProvider.overrideWithValue(api)], child: const InventryApp()),
    );
    await tester.pumpAndSettle();
    expect(find.byType(LoginScreen), findsOneWidget);
    await tester.ensureVisible(find.text('Register your business'));
    await tester.tap(find.text('Register your business'));
    await tester.pumpAndSettle();
    expect(find.byType(RegisterScreen), findsOneWidget);
  }

  Future<void> fill(WidgetTester tester, {String confirm = 'StrongPass99'}) async {
    await tester.enterText(find.widgetWithText(TextFormField, 'Business Name'), 'Verma Tiles');
    await tester.enterText(find.widgetWithText(TextFormField, 'Owner Name'), 'Anil Verma');
    await tester.enterText(find.widgetWithText(TextFormField, 'Mobile Number'), '9876543210');
    await tester.enterText(find.widgetWithText(TextFormField, 'Password'), 'StrongPass99');
    await tester.enterText(find.widgetWithText(TextFormField, 'Confirm Password'), confirm);
  }

  Future<void> tapSubmit(WidgetTester tester) async {
    await tester.ensureVisible(find.text('Submit Registration'));
    await tester.tap(find.text('Submit Registration'));
    await tester.pumpAndSettle();
  }

  testWidgets('submits the registration and shows the pending-approval message', (tester) async {
    final api = _FakeAuthApi();
    await openRegister(tester, api);
    await fill(tester);
    await tapSubmit(tester);

    expect(api.submitted, {
      'businessName': 'Verma Tiles',
      'ownerName': 'Anil Verma',
      'mobileNumber': '9876543210',
      'email': null,
      'password': 'StrongPass99',
    });
    expect(find.text('Request submitted'), findsOneWidget);
  });

  testWidgets('blocks mismatched passwords without calling the API', (tester) async {
    final api = _FakeAuthApi();
    await openRegister(tester, api);
    await fill(tester, confirm: 'Different99');
    await tapSubmit(tester);

    expect(find.text('Passwords do not match'), findsOneWidget);
    expect(api.submitted, isNull);
  });

  testWidgets('shows the backend error, e.g. an already-registered number', (tester) async {
    final api = _FakeAuthApi(
      error: const ApiException(
        message: 'This mobile number is already registered. Please sign in instead.',
        type: ApiErrorType.unknown,
        statusCode: 409,
      ),
    );
    await openRegister(tester, api);
    await fill(tester);
    await tapSubmit(tester);

    expect(find.text('This mobile number is already registered. Please sign in instead.'), findsOneWidget);
    expect(find.text('Request submitted'), findsNothing);
  });
}
