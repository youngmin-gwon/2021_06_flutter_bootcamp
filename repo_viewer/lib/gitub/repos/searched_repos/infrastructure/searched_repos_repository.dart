import 'package:dartz/dartz.dart';
import 'package:repo_viewer/core/domain/fresh.dart';
import 'package:repo_viewer/core/infrastructure/network_exceptions.dart';
import 'package:repo_viewer/gitub/core/domain/github_failure.dart';
import 'package:repo_viewer/gitub/core/domain/github_repo.dart';
import 'package:repo_viewer/gitub/repos/searched_repos/infrastructure/searched_repos_remote_service.dart';
import 'package:repo_viewer/gitub/repos/core/infrastructure/extensions.dart';

class SearchedReposRepository {
  final SearchedReposRemoteService _remoteService;

  const SearchedReposRepository(this._remoteService);

  Future<Either<GithubFailure, Fresh<List<GithubRepo>>>> getSearcehdReposPage(
    String query,
    int page,
  ) async {
    try {
      final remotePageItems =
          await _remoteService.getSearchedReposPage(query, page);

      return right(
        remotePageItems.maybeWhen(
          withNewData: (data, maxPage) => Fresh.yes(
            data.toDomain(),
            isNextPageAvailable: page < maxPage,
          ),
          orElse: () => Fresh.no([], isNextPageAvailable: false),
        ),
      );
    } on RestApiException catch (e) {
      return left(GithubFailure.api(e.errorCode));
    }
  }
}
