import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ke_flutter_webview/ke_flutter_webview.dart';

void main() {
  const MethodChannel channel = MethodChannel('ke_flutter_webview');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });
  
}
