import '../entity/repo_entity.dart';

abstract class GithubRepository {
  Future<List<RepoEntity>> fetchRepos();

  Future<List<String>> fetchCommits(String repoName);
}
