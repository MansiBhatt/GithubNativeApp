class RepoEntity {
  final String name;
  final String description;
  final String avatarUrl;
  final String? localAvatarPath;
  List<String> commits;
  bool isLoadingCommits;

  RepoEntity({
    required this.name,
    required this.description,
    required this.avatarUrl,
    this.localAvatarPath,
    this.commits = const [],
    this.isLoadingCommits = false,
  });
}
