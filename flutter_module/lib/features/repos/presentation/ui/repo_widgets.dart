import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entity/repo_entity.dart';
import '../bloc/repo_bloc.dart';
import '../bloc/repo_event.dart';
import 'repo_detail_sheet.dart';
import 'repo_grid_item.dart';
import 'repo_list_item.dart';

class RepoContent extends StatefulWidget {
  final List<RepoEntity> repos;

  const RepoContent(this.repos, {super.key});

  @override
  State<RepoContent> createState() => _RepoContentState();
}

class _RepoContentState extends State<RepoContent> {
  late PageController _controller;
  final int infiniteOffset = 1000;

  @override
  void initState() {
    super.initState();
    _controller = PageController(
      viewportFraction: 0.75,
      initialPage: infiniteOffset,
    );
  }

  int getRealIndex(int index, int length) => index % length;

  @override
  Widget build(BuildContext context) {
    final topFive = widget.repos.take(5).toList();
    final rest = widget.repos.skip(5).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 110,
          child: PageView.builder(
            controller: _controller,
            itemBuilder: (_, index) {
              final repo = topFive[getRealIndex(index, topFive.length)];
              return RepoGridItem(repo);
            },
          ),
        ),

        const SizedBox(height: 8),

        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            double page = 0;
            if (_controller.hasClients && _controller.page != null) {
              page = _controller.page!;
            }

            int currentIndex = getRealIndex(page.round(), topFive.length);

            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(topFive.length, (index) {
                final isActive = index == currentIndex;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: isActive ? 18 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: isActive ? Colors.black : Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(10),
                  ),
                );
              }),
            );
          },
        ),
        const SizedBox(height: 16),

        /// 🔹 LIST TITLE
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Text(
            "Git Repo",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),

        Expanded(
          child: ListView.builder(
            itemCount: rest.length,
            itemBuilder: (_, i) {
              final repo = rest[i];
              final actualIndex = i + 5;

              WidgetsBinding.instance.addPostFrameCallback((_) {
                context.read<RepoBloc>().add(
                  LoadCommits(actualIndex, repo.name),
                );
              });

              return RepoListItem(
                repo,
                onTap: () {
                  openRepoDetails(context, repo);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}