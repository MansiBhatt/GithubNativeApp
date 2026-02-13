import '../../data/repository/github_repository_impl.dart';
import '../entity/repo_entity.dart';
import '../repository/github_repository.dart';

class GetReposUseCase {
  final GithubRepository repository;

  GetReposUseCase(this.repository);

  Future<List<RepoEntity>> call() {
    return repository.fetchRepos();
  }

  Future<List<RepoEntity>> refresh() {
    return (repository as GithubRepositoryImpl).refreshRepos();
  }
}
