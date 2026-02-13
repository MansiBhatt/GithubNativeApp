import 'package:flutter_module/core/network/api_client.dart';

import '../data/datasource/github_api.dart';
import '../data/local/commit_dao.dart';
import '../data/local/repo_dao.dart';
import '../data/repository/github_repository_impl.dart';
import '../domain/usecase/get_commits_usecase.dart';
import '../domain/usecase/get_repos_usecase.dart';
import '../presentation/bloc/repo_bloc.dart';

class RepoModule {
  static RepoBloc provideBloc() {
    final api = GithubApi(ApiClient());
    final repoDao = RepoDao();
    final commitDao = CommitDao();

    final repo = GithubRepositoryImpl(api, repoDao, commitDao);

    return RepoBloc(
      getReposUseCase: GetReposUseCase(repo),
      getCommitsUseCase: GetCommitsUseCase(repo),
    );
  }
}
