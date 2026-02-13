import 'dart:io';

import 'package:flutter/material.dart';

import '../../domain/entity/repo_entity.dart';

void openRepoDetails(BuildContext context, RepoEntity repo) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (_) => RepoDetailSheet(repo),
  );
}

class RepoDetailSheet extends StatelessWidget {
  final RepoEntity repo;

  const RepoDetailSheet(this.repo, {super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      builder: (_, controller) {
        return ListView(
          controller: controller,
          padding: const EdgeInsets.all(16),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    repo.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            SizedBox(height: 5),
            Divider(height: 1, thickness: 1, color: Colors.grey),
            SizedBox(height: 20),
            Material(
              elevation: 6,
              borderRadius: BorderRadius.circular(12),
              clipBehavior: Clip.antiAlias,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: repo.localAvatarPath != null
                    ? Image.file(
                        File(repo.localAvatarPath!),
                        height: 140,
                        fit: BoxFit.cover,
                      )
                    : Image.network(
                        repo.avatarUrl,
                        height: 140,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Description: ${repo.description}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 12),
            ...repo.commits.map(
              (c) => Padding(
                padding: EdgeInsets.only(top: 8),
                child: Text(c, style: const TextStyle(fontSize: 12)),
              ),
            ),
          ],
        );
      },
    );
  }
}
