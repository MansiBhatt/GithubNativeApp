import 'package:sqflite/sqflite.dart';

import 'repo_db.dart';
import 'repo_table.dart';

class RepoDao {
  Future<void> insertRepos(List<Map<String, dynamic>> repos) async {
    final db = await RepoDB.instance.database;
    final batch = db.batch();

    for (var repo in repos) {
      batch.insert(
        RepoTable.table,
        repo,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit();
  }

  Future<List<Map<String, dynamic>>> getRepos() async {
    final db = await RepoDB.instance.database;
    return db.query(RepoTable.table);
  }

  Future<void> clearRepos() async {
    final db = await RepoDB.instance.database;
    await db.delete(RepoTable.table);
  }
}
