import 'package:flutter_module/features/repos/data/local/repo_dao.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  late RepoDao repoDao;

  setUpAll(() async {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    repoDao = RepoDao();
  });

  test('insertRepos should insert repos', () async {
    final repos = [
      {"id": 1, "name": "Repo1"},
      {"id": 2, "name": "Repo2"},
    ];

    await repoDao.insertRepos(repos);

    final result = await repoDao.getRepos();

    expect(result.length, 2);
  });

  test('clearRepos should delete all repos', () async {
    await repoDao.clearRepos();

    final result = await repoDao.getRepos();

    expect(result, []);
  });
}
