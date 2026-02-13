import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'commit_table.dart';
import 'repo_table.dart';

class RepoDB {
  static final RepoDB instance = RepoDB._internal();
  Database? _db;

  RepoDB._internal();

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'github.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(RepoTable.createTable());
        await db.execute(CommitTable.createTable());
      },
    );
  }
}
