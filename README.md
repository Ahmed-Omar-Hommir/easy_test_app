# easy_test_app

App-agnostic building blocks for full-app **widget tests** of Flutter apps. It
holds the parts that don't change between apps — the test harness, the launch +
journey model, request matchers, and the platform mock — so each app only
supplies its own glue.

## What's in the box

- **`easyTestWidgets(...)`** — a `testWidgets` wrapper that swallows prints,
  installs the transport mocks (`easy_mock_http`), the unmocked-channel guard,
  and the default `SystemChannels` mocks, then runs your callback. App-specific
  setup is injected:
  - `init` — install the app's own fakes (secure storage, permissions, device
    info, Firebase boot, …) before the app is launched.
  - `appJourney` — the journey whose `steps` are reset after each test.
  - `tearDown` — extra cleanup.
- **`appLauncher({app, patrol, appJourney})`** — pumps the widget and runs each
  `JourneyStep`'s `prepare` (stub HTTP) then `walk` (drive the UI).
- **`AppJourney` / `JourneyStep`** — the journey abstraction. Subclass
  `AppJourney` per app to add fluent steps (`signIn()`, `acceptPolicy()`, …).
- **`value` / `matcher` / `Any` / `ValueOrMatcher`** — pass a concrete value or a
  `Matcher` wherever an HTTP-case field is expected; `mapValue` transforms a
  concrete value while letting a matcher pass through.
- **`httpHeaders()` / `authHttpHeaders()` / `HeaderBuilder`** — build expected
  request headers, with or without a bearer token.
- **`LazyVerification`** — a `easy_mock_http` `Verification` resolved lazily.
- **`mockPlatform`** — flip `defaultTargetPlatform` to Android / iOS.
- **`PatrolTester.pumpUntil` / `releasePendingAsync`**, **`PatrolFinder.ensureNotExist`**.

Firebase fakes moved to the separate `easy_mock_firebase` package.

## Composing it in an app

```dart
// test/core/core.dart (in your app)
@isTest
void appWidgetTest(String description, PatrolWidgetTestCallback callback) {
  easyTestWidgets(
    description,
    callback,
    init: () async {
      mockSecureStorage.init();
      // … the rest of this app's fakes …
    },
    appJourney: () => _appJourney, // your AppJourney subclass
  );
}
```

Everything is exported from the single barrel:

```dart
import 'package:easy_test_app/easy_test_app.dart';
```
