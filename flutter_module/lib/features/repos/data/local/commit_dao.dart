import 'repo_db.dart';
import 'commit_table.dart';

class CommitDao {
  Future<void> insertCommits(String repoName, List<String> commits) async {
    final db = await RepoDB.instance.database;
    final batch = db.batch();

    for (var msg in commits) {
      batch.insert(CommitTable.table, {
        CommitTable.repoName: repoName,
        CommitTable.message: msg,
      });
    }

    await batch.commit();
  }

  Future<List<String>> getCommits(String repoName) async {
    final db = await RepoDB.instance.database;
    final result = await db.query(
      CommitTable.table,
      where: '${CommitTable.repoName} = ?',
      whereArgs: [repoName],
    );

    return result.map((e) => e[CommitTable.message] as String).toList();
  }
}
