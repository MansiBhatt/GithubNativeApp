import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/repo_bloc.dart';
import '../bloc/repo_state.dart';
import 'repo_widgets.dart';

class RepoScreen extends StatelessWidget {
  const RepoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("GITHUB"), centerTitle: true),
      body: BlocBuilder<RepoBloc, RepoState>(
        builder: (context, state) {
          if (state is RepoLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is RepoLoaded) {
            return RepoContent(state.repos);
          }
          return const Center(child: Text("Error"));
        },
      ),
    );
  }
}
