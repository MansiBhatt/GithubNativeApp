import '../../../../core/network/api_client.dart';
import '../models/commit_model.dart';
import '../models/repo_model.dart';

class GithubApi {
  final ApiClient client;

  GithubApi(this.client);

  Future<List<RepoModel>> fetchRepos() async {
    final response = await client.dio.get('users/mralexgray/repos');

    return (response.data as List).map((e) => RepoModel.fromJson(e)).toList();
  }

  Future<List<CommitModel>> fetchCommits(String repoName) async {
    final response = await client.dio.get(
      'repos/mralexgray/$repoName/commits?per_page=3',
    );

    return (response.data as List).map((e) => CommitModel.fromJson(e)).toList();
  }
}
