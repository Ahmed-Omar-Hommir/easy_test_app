import 'package:flutter_test/flutter_test.dart';

enum _ValueOrMatcherType { matcher, value }

class ValueOrMatcher<T> {
  const ValueOrMatcher.matcher(Matcher this._matcher)
    : _value = null,
      _type = _ValueOrMatcherType.matcher;
  const ValueOrMatcher.value(T this._value)
    : _matcher = null,
      _type = _ValueOrMatcherType.value;

  final T? _value;
  final Matcher? _matcher;
  final _ValueOrMatcherType _type;

  Object? get value {
    switch (_type) {
      case _ValueOrMatcherType.matcher:
        return _matcher;
      case _ValueOrMatcherType.value:
        return _value;
    }
  }

  /// Maps a concrete value through [onValue] (e.g. wrap a token in `Bearer …`);
  /// a matcher passes through untouched so easy_mock_http matches on it.
  Object? mapValue(Object Function(T value) onValue) {
    switch (_type) {
      case _ValueOrMatcherType.matcher:
        return _matcher;
      case _ValueOrMatcherType.value:
        return onValue(_value as T);
    }
  }
}

ValueOrMatcher<T> matcher<T>(Matcher matcher) =>
    ValueOrMatcher<T>.matcher(matcher);
ValueOrMatcher<T> value<T>(T value) => ValueOrMatcher<T>.value(value);

class Any<T> extends ValueOrMatcher<T> {
  const Any() : super.matcher(anything);
}
