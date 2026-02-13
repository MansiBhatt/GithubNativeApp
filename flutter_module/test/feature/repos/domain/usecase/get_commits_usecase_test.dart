import 'package:flutter_module/features/repos/domain/usecase/get_commits_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks/github_repository_mock.dart';

void main() {
  late MockGithubRepository repository;
  late GetCommitsUseCase useCase;

  setUp(() {
    repository = MockGithubRepository();
    useCase = GetCommitsUseCase(repository);
  });

  test('should return commits list', () async {
    when(
      () => repository.fetchCommits("repo1"),
    ).thenAnswer((_) async => ["commit1", "commit2"]);

    final result = await useCase.call("repo1");

    expect(result.length, 2);
  });
}
