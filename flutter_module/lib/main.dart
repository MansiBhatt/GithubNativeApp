import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/repos/di/repo_module.dart';
import 'features/repos/presentation/bloc/repo_event.dart';
import 'features/repos/presentation/ui/repo_screen.dart';

void main() {
  runApp(const GithubApp());
}

class GithubApp extends StatelessWidget {
  const GithubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/repos',
      routes: {
        '/repos': (_) => BlocProvider(
          create: (_) => RepoModule.provideBloc()..add(LoadRepos()),
          child: RepoScreen(),
        ),
      },
    );
  }
}
