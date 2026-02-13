import 'package:flutter_module/features/repos/data/repository/github_repository_impl.dart';
import 'package:flutter_module/features/repos/domain/entity/repo_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks/commit_dao_mock.dart';
import '../../../../mocks/github_api_mock.dart';
import '../../../../mocks/repo_dao_mock.dart';

void main() {
  late MockGithubApi api;
  late MockRepoDao repoDao;
  late MockCommitDao commitDao;
  late GithubRepositoryImpl repository;

  setUp(() {
    api = MockGithubApi();
    repoDao = MockRepoDao();
    commitDao = MockCommitDao();
    repository = GithubRepositoryImpl(api, repoDao, commitDao);
  });

  test('should return repos from DB if available', () async {
    when(() => repoDao.getRepos()).thenAnswer(
      (_) async => [
        {
          "name": "repo1",
          "description": "desc",
          "avatarUrl": "url",
          "localAvatarPath": "path",
        },
      ],
    );

    final result = await repository.fetchRepos();

    expect(result.first.name, "repo1");
    verifyNever(() => api.fetchRepos());
  });

  test('should fetch repos from API if DB empty', () async {
    when(() => repoDao.getRepos()).thenAnswer((_) async => []);

    when(() => api.fetchRepos()).thenAnswer((_) async => []);

    when(
      () => repoDao.insertRepos(any()),
    ).thenAnswer((_) async => Future.value());

    final result = await repository.fetchRepos();

    expect(result, isA<List<RepoEntity>>());
  });

  test('should return commits from DB if available', () async {
    when(() => commitDao.getCommits("repo1")).thenAnswer((_) async => ["c1"]);

    final commits = await repository.fetchCommits("repo1");

    expect(commits, ["c1"]);
  });
}
