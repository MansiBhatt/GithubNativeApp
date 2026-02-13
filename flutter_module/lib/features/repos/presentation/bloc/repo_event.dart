sealed class RepoEvent {}

class LoadRepos extends RepoEvent {}

class LoadCommits extends RepoEvent {
  final int index;
  final String repoName;

  LoadCommits(this.index, this.repoName);
}
