import 'package:flutter/cupertino.dart';
import 'package:patrol_finders/patrol_finders.dart';

abstract class AppJourneySteps {
  @protected
  static List<JourneyStep> steps = [];
}

class JourneyStep {
  const JourneyStep({required this.prepare, required this.walk});
  final Future<void> Function(PatrolTester $) prepare;
  final Future<void> Function(PatrolTester $) walk;
}

class Journey {
  const Journey();
}

const journey = Journey();
