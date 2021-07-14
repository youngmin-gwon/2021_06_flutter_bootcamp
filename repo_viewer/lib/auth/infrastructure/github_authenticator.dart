import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:oauth2/oauth2.dart';
import 'package:repo_viewer/auth/domain/auth_failure.dart';
import 'package:repo_viewer/auth/infrastructure/credentials_storage/credentials_storage.dart';
import 'package:http/http.dart' as http;
import 'package:repo_viewer/core/shared/encoders.dart';
import 'package:repo_viewer/core/infrastructure/dio_extensions.dart';

// github의 default response가 JSON, XML이 아니기 때문에 이를 설정해주기 위해서 만듬
class GithubOAuthHttpClient extends http.BaseClient {
  final httpClient = http.Client();
  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers["Accept"] = "application/json";
    return httpClient.send(request);
  }
}

class GithubAuthenticator {
  // get signed in credential
  final CredentialStorage _credentialStorage;
  final Dio _dio;

  GithubAuthenticator(this._credentialStorage, this._dio);
  // abstract class인 이유는 나중에 바꿔줄 경우를 위해

  // github client id 정의
  static const clientId = 'a39bf2ea8164eb357e05';
  static const clientSecret = 'bbaf53a8e526586b36b4932f431732af52ed5c7b';
  // scope : 어디까지 할 수 있는지 권한 부여하는 것
  static const scopes = ["read:user", "repo"];
  // endpoint 정의
  static final authorizationEndpoint =
      Uri.parse("https://github.com/login/oauth/authorize");

  static final tokenEndpoint =
      Uri.parse("https://github.com/login/oauth/access_token");

  // redirect url (나중에 웹을 위해 필요함)
  static final redirectUrl = Uri.parse("http://localhost:3000/callback");
  // revocation endpoint
  static final revocationEndpoint =
      Uri.parse("https://api.github.com/applications/$clientId/token");
  // -------------

  Future<Credentials?> getSignedInCredentials() async {
    try {
      // signed in 되면 access_token을 저장
      final storedCredentials = await _credentialStorage.read();
      // 다음 조건은 github에는 필요 없지만 (github는 refresh token 이 없기 때문에) 다른 OAuth들을 위해 추가
      if (storedCredentials != null) {
        if (storedCredentials.canRefresh && storedCredentials.isExpired) {
          final failureOrCredentials = await refresh(storedCredentials);
          return failureOrCredentials.fold((l) => null, (r) => r);
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

  // state notifier에서 사용하게 될것임
  // AuthorizationCodeGrant :  github documentation을 보면 parameter를 넘기는 부분이 있는데 이를 대신해주는 역할을 함
  AuthorizationCodeGrant createGrant() {
    return AuthorizationCodeGrant(
      clientId,
      authorizationEndpoint,
      tokenEndpoint,
      secret: clientSecret,
      httpClient: GithubOAuthHttpClient(),
    );
  }

  Uri getAuthorizationUrl(AuthorizationCodeGrant grant) {
    return grant.getAuthorizationUrl(
      redirectUrl,
      scopes: scopes,
    );
  }

  Future<Either<AuthFailure, Unit>> handleAuthorizationResponse(
    AuthorizationCodeGrant grant,
    Map<String, String> queryParams,
  ) async {
    try {
      // Unit : void를 return 하고 싶을 때 사용
      // redirect 받은 정보를 포함하고 있게 됨
      final httpClient = await grant.handleAuthorizationResponse(
          queryParams); // return client => access token 을 원하는데 왜 나오는가?
      // authorization header를 가지게 됨
      // dio package를 사용하기 위해서 바꿔줘야함
      await _credentialStorage.save(httpClient.credentials);
      return right(unit);
    } on FormatException {
      return left(const AuthFailure.server());
    } on AuthorizationException catch (e) {
      return left(AuthFailure.server("${e.error}: ${e.description}"));
    } on PlatformException {
      return left(const AuthFailure.storage());
    }
  }

  Future<Either<AuthFailure, Unit>> signOut() async {
    final accessToken = await _credentialStorage
        .read()
        .then((credentials) => credentials?.accessToken);
    // authorization header 에 base64로 encode해서 client id, client secret 넣어야함
    final usernameAndPassword =
        stringToBase64.encode("$clientId:$clientSecret");
    try {
      try {
        // authorization data 넣어줘야함
        await _dio.deleteUri(
          revocationEndpoint,
          data: {
            "access_token": accessToken,
          },
          options: Options(
            headers: {
              "Authorization": "basic $usernameAndPassword",
            },
          ),
        );
      } on DioError catch (e) {
        // offline 으로 dio error 가 생긴 경우
        if (e.isNoConnectionError) {
          // ignoring
        } else {
          rethrow;
        }
      }

      await _credentialStorage.clear();
      return right(unit);
    } on PlatformException {
      return left(const AuthFailure.storage());
    }
  }

  // github에는 사용되지 않지만 다른 OAuth 사용할 때 쓸 수 있는 token refresher
  Future<Either<AuthFailure, Credentials>> refresh(
    Credentials credentials,
  ) async {
    try {
      final refreshedCredentials = await credentials.refresh(
        identifier: clientId,
        secret: clientSecret,
        httpClient: GithubOAuthHttpClient(),
      );
      await _credentialStorage.save(refreshedCredentials);
      return right(refreshedCredentials);
    } on FormatException {
      return left(const AuthFailure.server());
    } on AuthorizationException catch (e) {
      return left(AuthFailure.server("${e.error}: ${e.description}"));
    } on PlatformException {
      return left(const AuthFailure.storage());
    }
  }
}
