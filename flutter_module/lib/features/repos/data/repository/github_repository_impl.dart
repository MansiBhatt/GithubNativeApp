import 'package:flutter_module/core/utils/image_cache_helper.dart';

import '../../domain/entity/repo_entity.dart';
import '../../domain/repository/github_repository.dart';
import '../datasource/github_api.dart';
import '../local/commit_dao.dart';
import '../local/repo_dao.dart';

class GithubRepositoryImpl implements GithubRepository {
  final GithubApi api;
  final RepoDao repoDao;
  final CommitDao commitDao;

  GithubRepositoryImpl(this.api, this.repoDao, this.commitDao);

  @override
  Future<List<RepoEntity>> fetchRepos() async {
    final localData = await repoDao.getRepos();
    if (localData.isNotEmpty) {
      return localData
          .map(
            (e) => RepoEntity(
              name: e['name'],
              description: e['description'] ?? "",
              avatarUrl: e['avatarUrl'],
              localAvatarPath: e['localAvatarPath'],
            ),
          )
          .toList();
    }

    final models = await api.fetchRepos();

    final repos = await Future.wait(
      models.map((e) async {
        final localPath = await ImageCacheHelper.downloadImage(
          e.ownerModel.avatarUrl,
          e.name, // file name
        );

        return RepoEntity(
          name: e.name,
          description: e.description,
          avatarUrl: e.ownerModel.avatarUrl,
          localAvatarPath: localPath,
        );
      }).toList(),
    );

    await repoDao.insertRepos(
      repos
          .map(
            (e) => {
              'name': e.name,
              'description': e.description,
              'avatarUrl': e.avatarUrl,
              'localAvatarPath': e.localAvatarPath,
            },
          )
          .toList(),
    );

    return repos;
  }

  Future<List<RepoEntity>> refreshRepos() async {
    final models = await api.fetchRepos();

    final repos = await Future.wait(
      models.map((e) async {
        final localPath = await ImageCacheHelper.downloadImage(
          e.ownerModel.avatarUrl,
          e.name,
        );

        return RepoEntity(
          name: e.name,
          description: e.description,
          avatarUrl: e.ownerModel.avatarUrl,
          localAvatarPath: localPath,
        );
      }).toList(),
    );

    await repoDao.clearRepos();

    await repoDao.insertRepos(
      repos
          .map(
            (e) => {
              'name': e.name,
              'description': e.description,
              'avatarUrl': e.avatarUrl,
              'localAvatarPath': e.localAvatarPath,
            },
          )
          .toList(),
    );

    return repos;
  }

  @override
  Future<List<String>> fetchCommits(String repoName) async {
    final localCommits = await commitDao.getCommits(repoName);

    if (localCommits.isNotEmpty) {
      return localCommits;
    }
    final commits = await api.fetchCommits(repoName);
    var commitList = commits.map((e) => e.message).toList();
    await commitDao.insertCommits(repoName, commitList);
    return commitList;
  }
}
