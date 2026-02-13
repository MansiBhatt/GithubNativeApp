import '../repository/github_repository.dart';

class GetCommitsUseCase {
  final GithubRepository repository;

  GetCommitsUseCase(this.repository);

  Future<List<String>> call(String repoName) {
    return repository.fetchCommits(repoName);
  }
}
