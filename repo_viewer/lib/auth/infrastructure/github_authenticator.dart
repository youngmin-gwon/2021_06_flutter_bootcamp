import 'package:flutter/services.dart';
import 'package:oauth2/oauth2.dart';
import 'package:repo_viewer/auth/infrastructure/credentials_storage/credentials_storage.dart';

class GithubAuthenticator {
  // get signed in credential
  final CredentialStorage _credentialStorage;

  GithubAuthenticator(this._credentialStorage);
  // abstract class인 이유는 나중에 바꿔줄 경우를 위해
  Future<Credentials?> getSignedInCredentials() async {
    try {
      // signed in 되면 access_token을 저장
      final storedCredentials = await _credentialStorage.read();
      // 다음 조건은 github에는 필요 없지만 (github는 refresh token 이 없기 때문에) 다른 OAuth들을 위해 추가
      if (storedCredentials != null) {
        if (storedCredentials.canRefresh && storedCredentials.isExpired) {
          // TODO : refresh
        }
      }
      return storedCredentials;
    } on PlatformException {
      // secure credential 에서 처리할 수 있었지만 auth failure로 내보내기 위해서 여기서 catch
      return null;
    }
  }

  Future<bool> isSignedIn() =>
      getSignedInCredentials().then((credentials) => credentials != null);
}
