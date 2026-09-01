import 'package:flutter/foundation.dart';

class MockPlatform {
  const MockPlatform._();
  void asAndroid() {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
  }

  void asiOS() {
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
  }
}

const mockPlatform = MockPlatform._();
