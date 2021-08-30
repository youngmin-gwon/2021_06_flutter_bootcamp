import 'package:repo_viewer/gitub/core/domain/github_repo.dart';
import 'package:repo_viewer/gitub/core/infrastructure/github_repo_dto.dart';

extension DTOListToDomainList on List<GithubRepoDTO> {
  List<GithubRepo> toDomain() {
    return map((e) => e.toDomain()).toList();
  }
}
