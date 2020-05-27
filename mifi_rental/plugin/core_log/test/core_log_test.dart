import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:core_log/core_log.dart';

void main() {
  const MethodChannel channel = MethodChannel('core_log');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await ULog.platformVersion, '42');
  });
}
