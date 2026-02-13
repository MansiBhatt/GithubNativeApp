class CommitTable {
  static const table = 'commits';

  static const id = 'id';
  static const repoName = 'repoName';
  static const message = 'message';

  static String createTable() =>
      '''
  CREATE TABLE $table (
    $id INTEGER PRIMARY KEY AUTOINCREMENT,
    $repoName TEXT,
    $message TEXT
  )
  ''';
}
