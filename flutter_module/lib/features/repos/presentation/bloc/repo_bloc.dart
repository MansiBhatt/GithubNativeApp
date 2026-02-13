import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_module/features/repos/presentation/bloc/repo_event.dart';
import 'package:flutter_module/features/repos/presentation/bloc/repo_state.dart';

import '../../domain/entity/repo_entity.dart';
import '../../domain/usecase/get_commits_usecase.dart';
import '../../domain/usecase/get_repos_usecase.dart';

class RepoBloc extends Bloc<RepoEvent, RepoState> {
  final GetReposUseCase getReposUseCase;
  final GetCommitsUseCase getCommitsUseCase;

  RepoBloc({required this.getReposUseCase, required this.getCommitsUseCase})
    : super(RepoLoading()) {
    on<LoadRepos>(_loadRepos);
    on<LoadCommits>(_loadCommits);
  }

  Future<void> _loadRepos(LoadRepos event, Emitter<RepoState> emit) async {
    try {
      final localRepos = await getReposUseCase();

      if (localRepos.isNotEmpty) {
        emit(RepoLoaded(localRepos));
      }

      try {
        final freshRepos = await getReposUseCase.refresh();
        emit(RepoLoaded(freshRepos));
      } catch (e) {
        if (localRepos.isEmpty) {
          emit(RepoError());
        }
      }
    } catch (_) {
      emit(RepoError());
    }
  }

  Future<void> _loadCommits(LoadCommits event, Emitter<RepoState> emit) async {
    final state = this.state;
    if (state is RepoLoaded) {
      final repos = List<RepoEntity>.from(state.repos);
      final repo = repos[event.index];

      if (repo.commits.isNotEmpty || repo.isLoadingCommits) return;

      repo.isLoadingCommits = true;
      emit(RepoLoaded(repos));

      final commits = await getCommitsUseCase(event.repoName);

      repo.commits = commits;
      repo.isLoadingCommits = false;

      emit(RepoLoaded(repos));
    }
  }
}
