import 'package:dio/dio.dart';
import 'package:repo_viewer/core/infrastructure/network_exceptions.dart';

import 'package:repo_viewer/core/infrastructure/remote_response.dart';
import 'package:repo_viewer/gitub/core/infrastructure/github_headers.dart';
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

      // 데이터가 변하지 않았을 경우
      if (response.statusCode == 304) {
        return RemoteResponse.notModified(
            maxPage: previousHeaders?.link?.maxPage ?? 0);
      } else if (response.statusCode == 200) {
        // header 받은 값 headerCache 에 저장하기
        final headers = GithubHeaders.parse(response);
        // max number 넘기기
        await _headersCache.saveHeaders(requestUri, headers);

        // data 변환
        final convertedData = (response.data as List<dynamic>)
            .map((e) => GithubRepoDTO.fromJson(e as Map<String, dynamic>))
            .toList();
        return RemoteResponse.withNewData(
          convertedData,
          maxPage: headers.link?.maxPage ?? 1,
        );
      } else {
        throw RestApiException(errorCode: response.statusCode);
      }
    } on DioError catch (e) {
      if (e.isNoConnectionError) {
        return RemoteResponse.noConnection(
            maxPage: previousHeaders?.link?.maxPage ?? 0);
      } else if (e.response != null) {
        throw RestApiException(errorCode: e.response?.statusCode);
      } else {
        rethrow;
      }
    }
  }
}
