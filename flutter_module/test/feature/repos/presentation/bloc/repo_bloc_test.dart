import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_module/features/repos/domain/entity/repo_entity.dart';
import 'package:flutter_module/features/repos/domain/usecase/get_commits_usecase.dart';
import 'package:flutter_module/features/repos/domain/usecase/get_repos_usecase.dart';
import 'package:flutter_module/features/repos/presentation/bloc/repo_bloc.dart';
import 'package:flutter_module/features/repos/presentation/bloc/repo_event.dart';
import 'package:flutter_module/features/repos/presentation/bloc/repo_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetReposUseCase extends Mock implements GetReposUseCase {}

class MockGetCommitsUseCase extends Mock implements GetCommitsUseCase {}

void main() {
  late RepoBloc repoBloc;
  late MockGetReposUseCase getReposUseCase;
  late MockGetCommitsUseCase getCommitsUseCase;

  final repos = [
    RepoEntity(
      name: "Repo1",
      description: "Desc1",
      avatarUrl: "url1",
      commits: [],
    ),
    RepoEntity(
      name: "Repo2",
      description: "Desc2",
      avatarUrl: "url2",
      commits: [],
    ),
  ];

  setUp(() {
    getReposUseCase = MockGetReposUseCase();
    getCommitsUseCase = MockGetCommitsUseCase();

    repoBloc = RepoBloc(
      getReposUseCase: getReposUseCase,
      getCommitsUseCase: getCommitsUseCase,
    );
  });

  tearDown(() {
    repoBloc.close();
  });

  final localRepos = [
    RepoEntity(
      name: "Repo1",
      description: "Desc1",
      avatarUrl: "url1",
      commits: [],
    ),
  ];

  final freshRepos = [
    RepoEntity(
      name: "Repo1",
      description: "Desc1",
      avatarUrl: "url1",
      commits: [],
    ),
    RepoEntity(
      name: "Repo2",
      description: "Desc2",
      avatarUrl: "url2",
      commits: [],
    ),
  ];

  blocTest<RepoBloc, RepoState>(
    'emits RepoLoaded twice when local repos exist and refresh succeeds',
    build: () {
      when(() => getReposUseCase()).thenAnswer((_) async => localRepos);

      when(() => getReposUseCase.refresh()).thenAnswer((_) async => freshRepos);

      return repoBloc;
    },
    act: (bloc) => bloc.add(LoadRepos()),
    expect: () => [isA<RepoLoaded>(), isA<RepoLoaded>()],
  );

  blocTest<RepoBloc, RepoState>(
    'emits RepoLoaded once when local repos exist but refresh fails',
    build: () {
      when(() => getReposUseCase()).thenAnswer((_) async => repos);

      when(() => getReposUseCase.refresh()).thenThrow(Exception());

      return repoBloc;
    },
    act: (bloc) => bloc.add(LoadRepos()),
    expect: () => [isA<RepoLoaded>()],
  );

  blocTest<RepoBloc, RepoState>(
    'emits RepoLoaded when local empty but API success',
    build: () {
      when(() => getReposUseCase()).thenAnswer((_) async => []);

      when(() => getReposUseCase.refresh()).thenAnswer((_) async => repos);

      return repoBloc;
    },
    act: (bloc) => bloc.add(LoadRepos()),
    expect: () => [isA<RepoLoaded>()],
  );

  blocTest<RepoBloc, RepoState>(
    'emits RepoError when local empty and API fails',
    build: () {
      when(() => getReposUseCase()).thenAnswer((_) async => []);

      when(() => getReposUseCase.refresh()).thenThrow(Exception());

      return repoBloc;
    },
    act: (bloc) => bloc.add(LoadRepos()),
    expect: () => [isA<RepoError>()],
  );
}
