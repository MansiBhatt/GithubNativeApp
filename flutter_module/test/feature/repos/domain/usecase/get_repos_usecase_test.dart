import 'package:flutter_module/features/repos/domain/entity/repo_entity.dart';
import 'package:flutter_module/features/repos/domain/usecase/get_repos_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks/github_repository_mock.dart';

void main() {
  late MockGithubRepository repository;
  late GetReposUseCase useCase;

  setUp(() {
    repository = MockGithubRepository();
    useCase = GetReposUseCase(repository);
  });

  test('should return repo list', () async {
    final repos = [
      RepoEntity(name: "repo1", description: "desc", avatarUrl: "url"),
    ];

    when(() => repository.fetchRepos()).thenAnswer((_) async => repos);

    final result = await useCase.call();

    expect(result, repos);
  });

  test('should throw exception when repository fails', () async {
    when(() => repository.fetchRepos()).thenThrow(Exception());

    expect(() => useCase.call(), throwsException);
  });
}
