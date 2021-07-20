import 'package:repo_viewer/core/infrastructure/sembast_database.dart';
import 'package:repo_viewer/gitub/core/infrastructure/github_repo_dto.dart';
import 'package:repo_viewer/gitub/core/infrastructure/pagination_config.dart';
import 'package:sembast/sembast.dart';
import 'package:collection/collection.dart'; // 직접 추가해줘야함 => List 에 mapIndexed extension을 추가하기 위해

class StarredReposLocalService {
  final SembastDatabase _sembastDatabase;
  final _store = intMapStoreFactory.store("starredRepos");

  StarredReposLocalService(
    this._sembastDatabase,
  );

  // upsert : insert + update
  Future<void> upsertPage(List<GithubRepoDTO> dtos, int page) async {
    final sembastPage = page - 1;

    // 0,1,2||3,4,5|| 이런식으로 pagination 된다고 가정하고 진행함 추후에 수정할 것임

    await _store
        .records(
          dtos.mapIndexed(
            (index, _) => index + PaginationConfig.itemsPerPage * sembastPage,
          ),
        )
        .put(_sembastDatabase.instace, dtos.map((e) => e.toJson()).toList());
  }

  Future<List<GithubRepoDTO>> getPage(int page) async {
    final sembastPage = page - 1;

    // limit 나중에 수정할 것 임
    final records = await _store.find(
      _sembastDatabase.instace,
      finder: Finder(
        limit: PaginationConfig.itemsPerPage,
        offset: PaginationConfig.itemsPerPage * sembastPage,
      ),
    );

    return records.map((e) => GithubRepoDTO.fromJson(e.value)).toList();
  }
}
