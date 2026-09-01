import 'package:flutter_test/flutter_test.dart';
import 'package:patrol_finders/patrol_finders.dart';

extension PatrolFinderX on PatrolFinder {
  Future<void> ensureNotExist({
    Duration timeout = const Duration(seconds: 10),
  }) async {
    final interval = const Duration(milliseconds: 100);

    final totalTicks = timeout.inMilliseconds ~/ interval.inMilliseconds;

    for (var i = 0; i < totalTicks; i++) {
      await tester.pump(interval);
      if (!exists) return;
    }

    if (exists) {
      throw Exception(
        'Element still exists after exceeding the ${timeout.inSeconds}s timeout.',
      );
    }
  }
}

extension PatrolTesterExtension on PatrolTester {
  Future<void> pumpUntil(bool Function() condition, {String? reason}) async {
    for (var i = 0; i < 100; i++) {
      if (condition()) return;
      await tester.pump(const Duration(milliseconds: 100));
    }
    fail(reason ?? 'pumpUntil: condition never held');
  }

  Future<void> releasePendingAsync() async {
    await tester.idle();
  }
}
