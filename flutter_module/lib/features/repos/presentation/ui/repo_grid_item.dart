import 'dart:io';

import 'package:flutter/material.dart';

import '../../domain/entity/repo_entity.dart';

class RepoGridItem extends StatelessWidget {
  final RepoEntity repo;

  const RepoGridItem(this.repo, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: const Color(0xFFE6E6DC),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
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
                child: Text(
                  repo.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
