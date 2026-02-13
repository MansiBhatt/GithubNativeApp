import '../../domain/entity/repo_entity.dart';

sealed class RepoState {}

class RepoLoading extends RepoState {}

class RepoLoaded extends RepoState {
  final List<RepoEntity> repos;

  RepoLoaded(this.repos);
}

class RepoError extends RepoState {}
