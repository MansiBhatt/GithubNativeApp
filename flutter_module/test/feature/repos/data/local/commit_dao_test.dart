import 'package:flutter_module/features/repos/data/local/commit_dao.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  late CommitDao commitDao;

  setUpAll(() async {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    commitDao = CommitDao();
  });

  test('insertCommits should insert commit messages', () async {
    await commitDao.insertCommits("repo1", ["c1", "c2"]);

    final commits = await commitDao.getCommits("repo1");

    expect(commits.length, 2);
    expect(commits, ["c1", "c2"]);
  });

  test('getCommits should return empty list if no data', () async {
    final commits = await commitDao.getCommits("unknown_repo");

    expect(commits, []);
  });
}
