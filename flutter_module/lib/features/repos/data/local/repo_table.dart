class RepoTable {
  static const table = 'repos';

  static const id = 'id';
  static const name = 'name';
  static const description = 'description';
  static const avatarUrl = 'avatarUrl';
  static const localAvatarPath = 'localAvatarPath';

  static String createTable() =>
      '''
  CREATE TABLE $table (
    $id INTEGER PRIMARY KEY AUTOINCREMENT,
    $name TEXT,
    $description TEXT,
    $avatarUrl TEXT,
    $localAvatarPath TEXT
  )
  ''';
}
