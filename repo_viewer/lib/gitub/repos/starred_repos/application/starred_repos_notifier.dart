import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:repo_viewer/core/domain/fresh.dart';
import 'package:repo_viewer/gitub/core/domain/github_failure.dart';
import 'package:repo_viewer/gitub/core/domain/github_repo.dart';

part 'starred_repos_notifier.freezed.dart';

// 왜 repos가 모두 들어가야하는지 생각해보기
@freezed
class StarredReposState with _$StarredReposState {
  const StarredReposState._();
  const factory StarredReposState.initial(
    Fresh<List<GithubRepo>> repos,
  ) = _Initial;
  const factory StarredReposState.loadInProgress(
    Fresh<List<GithubRepo>> repos,
    int itemsPerPage,
  ) = _LoadInProgress;
  const factory StarredReposState.loadSuccess(
    Fresh<List<GithubRepo>> repos, {
    required bool isNextPageAvailable,
  }) = _LoadSuccess;
  const factory StarredReposState.loadFailure(
    Fresh<List<GithubRepo>> repos,
    GithubFailure failure,
  ) = _LoadFailure;
}
