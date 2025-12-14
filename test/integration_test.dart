import 'dart:io';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:im/main.dart';

// Mock HttpOverrides
class TestHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return _createMockImageHttpClient(context);
  }
}

HttpClient _createMockImageHttpClient(SecurityContext? _) {
  final client = _MockHttpClient();
  return client;
}

class _MockHttpClient extends Fake implements HttpClient {
  @override
  Future<HttpClientRequest> getUrl(Uri url) async {
    return _MockHttpClientRequest();
  }
}

class _MockHttpClientRequest extends Fake implements HttpClientRequest {
  @override
  Future<HttpClientResponse> close() async {
    return _MockHttpClientResponse();
  }
}

class _MockHttpClientResponse extends Fake implements HttpClientResponse {
  @override
  int get statusCode => 200;

  @override
  int get contentLength => 0;

  @override
  HttpClientResponseCompressionState get compressionState =>
      HttpClientResponseCompressionState.notCompressed;
      
  @override
  StreamSubscription<List<int>> listen(void Function(List<int> event)? onData,
      {Function? onError, void Function()? onDone, bool? cancelOnError}) {
    // Return a 1x1 transparent PNG
    final transparentPixelPng = [
      0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A,
      0x00, 0x00, 0x00, 0x0D, 0x49, 0x48, 0x44, 0x52,
      0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01,
      0x08, 0x06, 0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4,
      0x89, 0x00, 0x00, 0x00, 0x0A, 0x49, 0x44, 0x41,
      0x54, 0x78, 0x9C, 0x63, 0x00, 0x01, 0x00, 0x00,
      0x05, 0x00, 0x01, 0x0D, 0x0A, 0x2D, 0xB4, 0x00,
      0x00, 0x00, 0x00, 0x00, 0x49, 0x45, 0x4E, 0x44,
      0xAE, 0x42, 0x60, 0x82,
    ];
    return Stream.value(transparentPixelPng).listen(onData,
        onError: onError, onDone: onDone, cancelOnError: cancelOnError);
  }
}

void main() {
  testWidgets('Full app flow: Login -> Home -> Chat -> Send Message', (WidgetTester tester) async {
    await HttpOverrides.runZoned(() async {
      // Start app
      await tester.pumpWidget(const ProviderScope(child: IMApp()));
      await tester.pumpAndSettle();

      // 1. Verify Login Screen
      expect(find.text('Welcome Back'), findsOneWidget);
      // CupertinoTextFormFieldRow doesn't have direct text label like TextFormField, checking placeholder
      expect(find.text('Phone Number (e.g. 13800000000)'), findsOneWidget);

      // 2. Perform Login
      await tester.enterText(find.byType(CupertinoTextFormFieldRow).at(0), '13800000000');
      await tester.enterText(find.byType(CupertinoTextFormFieldRow).at(1), '1234');
      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();

      // 3. Verify Home Screen
      expect(find.text('Messages'), findsOneWidget);
      expect(find.text('Bob'), findsOneWidget);

      // 4. Navigate to Chat with Bob
      await tester.tap(find.text('Bob'));
      await tester.pumpAndSettle();

      // 5. Verify Chat Screen
      expect(find.text('Chat'), findsOneWidget);
      expect(find.text('Hello!'), findsOneWidget);

      // 6. Send a new message
      await tester.enterText(find.byType(CupertinoTextField), 'Test Message');
      await tester.tap(find.byIcon(CupertinoIcons.arrow_up_circle_fill));
      await tester.pump(); 

      // 7. Verify message appears
      expect(find.text('Test Message'), findsOneWidget);
    }, createHttpClient: (context) => _createMockImageHttpClient(context));
  });
}
