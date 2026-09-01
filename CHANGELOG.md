## 0.1.3

- Upgrade `easy_mock_http` to `^0.4.0` and expose matching requests through
  `LazyVerification.requests`.
- Add package repository metadata.

## 0.1.2

- Upgrade `easy_mock_http` to `^0.3.0`.

## 0.1.1

- Support `data_builder_test` 0.11.x and its `craft_runner` 0.11.x dependency.

## 0.1.0

- Initial release. Extracted from the epay app's `test/core` so multiple apps can share one test core.
- `easyTestWidgets` harness with injectable `init` / `appJourney` / `tearDown`; installs `easy_mock_http`, the unmocked-channel guard, and default `SystemChannels` mocks.
- `appLauncher` + `AppJourney` / `JourneyStep` journey model.
- Request helpers: `value` / `matcher` / `Any` / `ValueOrMatcher`, `httpHeaders` / `authHttpHeaders` / `HeaderBuilder`, `LazyVerification`.
- Mock: `mockPlatform` (Firebase fakes live in the separate `easy_mock_firebase` package).
- `PatrolTester.pumpUntil` / `releasePendingAsync`, `PatrolFinder.ensureNotExist`.
