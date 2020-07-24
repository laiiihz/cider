import 'dart:io';

import 'package:change/model.dart';
import 'package:path/path.dart';

class ChangelogFile {
  ChangelogFile(this._dir);

  static final name = 'CHANGELOG.md';

  final String _dir;

  /// Updates the changelog in-place
  void update(Changelog Function(Changelog changelog) mutate) =>
      _write(mutate(read()));

  /// Reads the changelog from file
  Changelog read() => Changelog.fromLines(
      (_file..createSync(recursive: true)).readAsLinesSync());

  void _write(Changelog changelog) => _file.writeAsStringSync(changelog.dump());

  File get _file => File(join(_dir, name));
}
