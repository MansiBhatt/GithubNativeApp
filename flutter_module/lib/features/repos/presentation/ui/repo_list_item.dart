import 'dart:io';

import 'package:flutter/material.dart';

import '../../domain/entity/repo_entity.dart';

class RepoListItem extends StatelessWidget {
  final RepoEntity repo;
  final VoidCallback onTap;

  const RepoListItem(this.repo, {required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: const Color(0xFFE6E6DC),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: repo.localAvatarPath != null
                    ? Image.file(
                        File(repo.localAvatarPath!),
                        height: 60,
                        width: 60,
                        fit: BoxFit.cover,
                      )
                    : Image.network(
                        repo.avatarUrl,
                        height: 60,
                        width: 60,
                        fit: BoxFit.cover,
                      ),
              ),

              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      repo.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    if (repo.isLoadingCommits)
                      const Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: LinearProgressIndicator(minHeight: 2),
                      ),
                    if (repo.commits.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: repo.commits.map((commit) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text(
                                commit,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 12),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
