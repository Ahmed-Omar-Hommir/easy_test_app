import 'dart:async';

import 'package:easy_mock_system_channel/easy_mock_system_channel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easy_mock_http/easy_mock_http.dart';
import 'package:patrol_finders/patrol_finders.dart';

import 'app_journey.dart';
import 'extension.dart';

void easyTestWidgets(
  String description,
  PatrolWidgetTestCallback callback, {
  bool? skip,
  Timeout? timeout,
  bool semanticsEnabled = true,
  TestVariant<Object?> variant = const DefaultTestVariant(),
  dynamic tags,
  PatrolTesterConfig config = const PatrolTesterConfig(),
  Future<void> Function()? init,
  Future<void> Function()? tearDown,
}) {
  testWidgets(
    description,
    skip: skip,
    timeout: timeout,
    semanticsEnabled: semanticsEnabled,
    variant: variant,
    tags: tags,
    (widgetTester) async {
      final patrolTester = PatrolTester(tester: widgetTester, config: config);

      await runZoned(
        () async {
          mockHttp.init();
          mockChannel.init();
          mockSystemChannel.init();

          mockChannel('plugins.flutter.io/path_provider')
            ..when(
              method: 'getApplicationDocumentsDirectory',
              returns: '/app_root',
            )
            ..when(
              method: 'getApplicationSupportDirectory',
              returns: '/app_root',
            );

          await init?.call();

          try {
            await callback(patrolTester);
            await patrolTester.releasePendingAsync();
          } finally {
            // ignore: invalid_use_of_protected_member
            AppJourneySteps.steps = [];
            debugDefaultTargetPlatformOverride = null;
            await tearDown?.call();
          }
        },
        zoneSpecification: ZoneSpecification(
          print: (self, parent, zone, line) {},
        ),
      );
    },
  );
}
