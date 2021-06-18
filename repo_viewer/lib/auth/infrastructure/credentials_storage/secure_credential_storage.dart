import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:oauth2/oauth2.dart';
import 'package:repo_viewer/auth/infrastructure/credentials_storage/credentials_storage.dart';

class SecureCredentialStorage implements CredentialStorage {
  // 어떠한 클래스가 다른 클래스 인스턴스에 종속될 때 다음처럼 사용함
  final FlutterSecureStorage _storage;

  SecureCredentialStorage(this._storage);
  // 종속성 전달하는 것은 riverpod이 추후에 할 것임

  static const _key = "oauth2_credentials";

  Credentials? _cachedCredentials;

  @override
  Future<Credentials?> read() async {
    if (_cachedCredentials != null) {
      return _cachedCredentials;
    }
    // 저장한 형태가 json
    final json = await _storage.read(key: _key);
    if (json == null) {
      return null;
    }
    try {
      // 2번째 이상부터는 _cachedCredentials는 항상 비어있기 때문에 넣어줌
      return _cachedCredentials = Credentials.fromJson(json);
    } on FormatException {
      return null;
    }
  }

  @override
  Future<void> save(Credentials credentials) {
    _cachedCredentials = credentials;
    return _storage.write(key: _key, value: credentials.toJson());
  }

  @override
  Future<void> clear() {
    _cachedCredentials = null;
    return _storage.delete(key: _key);
  }
}
