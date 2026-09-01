import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol_finders/patrol_finders.dart';

import 'app_journey.dart';

Future<void> appLauncher({
  required Widget app,
  required PatrolTester patrol,
}) async {
  // ignore: invalid_use_of_protected_member
  final history = AppJourneySteps.steps;

  for (var journey in history) {
    await journey.prepare(patrol);
  }

  await patrol.pumpWidget(app);

  for (var journey in history) {
    await journey.walk(patrol);
  }
}
