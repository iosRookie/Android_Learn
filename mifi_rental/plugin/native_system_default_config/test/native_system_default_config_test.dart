import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:native_system_default_config/native_system_default_config.dart';

void main() {
  const MethodChannel channel = MethodChannel('native_system_default_config');

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
    expect(await NativeSystemDefaultConfig.platformVersion, '42');
  });
}
