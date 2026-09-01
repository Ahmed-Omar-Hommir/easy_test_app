const defaultAccessToken = 'default-access-token';

HeaderBuilder httpHeaders() => HeaderBuilder._({}).withoutAccessToken();

HeaderBuilder authHttpHeaders() => HeaderBuilder._({}).withDefaultAccessToken();

class HeaderBuilder {
  const HeaderBuilder._(this._value);
  final Map<String, dynamic> _value;

  HeaderBuilder withDefaultAccessToken() {
    return HeaderBuilder._({
      ..._value,
      'Authorization': 'Bearer $defaultAccessToken',
    });
  }

  HeaderBuilder withAccessToken(String token) {
    return HeaderBuilder._({..._value, 'Authorization': 'Bearer $token'});
  }

  HeaderBuilder withoutAccessToken() {
    final copy = {..._value};
    copy.remove('Authorization');
    return HeaderBuilder._(copy);
  }

  Map<String, dynamic> build() {
    return _value;
  }
}
