import 'package:easy_mock_http/easy_mock_http.dart';

class LazyVerification implements Verification {
  const LazyVerification(this._verification);

  final Verification Function() _verification;

  @override
  void called(int times) {
    _verification().called(times);
  }

  @override
  void calledAtLeast(int times) {
    _verification().calledAtLeast(times);
  }

  @override
  void calledAtMost(int times) {
    _verification().calledAtMost(times);
  }

  @override
  void get calledOnce {
    _verification().calledOnce;
  }

  @override
  List<MockHttpRequest> get calls => _verification().calls;

  @override
  int get count => _verification().count;

  @override
  void get never {
    _verification().never;
  }

  @override
  MockHttpRequest get single => _verification().single;
}
