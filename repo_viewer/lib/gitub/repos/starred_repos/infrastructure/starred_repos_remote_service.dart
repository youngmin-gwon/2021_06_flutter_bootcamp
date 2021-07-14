import 'package:dio/dio.dart';
import 'package:repo_viewer/core/infrastructure/network_exceptions.dart';

import 'package:repo_viewer/core/infrastructure/remote_response.dart';
import 'package:repo_viewer/gitub/core/infrastructure/github_headers_cache.dart';
import 'package:repo_viewer/gitub/core/infrastructure/github_repo_dto.dart';
import 'package:repo_viewer/core/infrastructure/dio_extensions.dart';

class StarredReposRemoteService {
  final Dio _dio;
  final GithubHeadersCache _headersCache;

  StarredReposRemoteService(
    this._dio,
    this._headersCache,
  );

  Future<RemoteResponse<List<GithubRepoDTO>>> getStarredReposPage(
    int page,
  ) async {
    final token = "access_token";
    final accept = "application/vnd.github.v3.html+json";
    final requestUri = Uri.https(
      "api.github.com",
      "/user/starred",
      {"page": "$page"},
    );

    final previousHeaders = await _headersCache.getHeaders(requestUri);

    try {
      final response = await _dio.getUri(
        requestUri,
        options: Options(
          headers: {
            "Authorization": "bearer $token",
            "Accept": accept,
            "If-None-Match": previousHeaders?.etag ?? "",
          },
        ),
      );
      // 예시
      return RemoteResponse.noConnection();
    } on DioError catch (e) {
      if (e.isNoConnectionError) {
        return const RemoteResponse.noConnection();
      } else if (e.response != null) {
        throw RestApiException(errorCode: e.response?.statusCode);
      } else {
        rethrow;
      }
    }
  }
}
