import 'dart:typed_data';

class RemoteEntry {
  final String path;
  final int size;
  final DateTime modified;
  const RemoteEntry(this.path, this.size, this.modified);
}

class Quota {
  final int used;
  final int? total;
  const Quota(this.used, this.total);
}

class NotFoundException implements Exception {
  final String path;
  const NotFoundException(this.path);
  @override
  String toString() => 'NotFoundException: $path';
}

/// The only thing a backend implements. Paths are '/'-separated and
/// relative to the vault root. Sync logic never depends on the backend.
abstract interface class StorageProvider {
  String get id;
  Future<void> connect();
  Future<List<RemoteEntry>> list(String prefix);
  Future<Uint8List> get(String path);
  Future<void> put(String path, Uint8List bytes);
  Future<void> delete(String path);
  Future<Quota?> quota();
}

/// In-memory provider for tests and the sync simulator.
class MemoryProvider implements StorageProvider {
  final _files = <String, (Uint8List, DateTime)>{};

  @override
  String get id => 'memory';

  @override
  Future<void> connect() async {}

  @override
  Future<List<RemoteEntry>> list(String prefix) async => [
        for (final e in _files.entries)
          if (e.key.startsWith(prefix))
            RemoteEntry(e.key, e.value.$1.length, e.value.$2)
      ]..sort((a, b) => a.path.compareTo(b.path));

  @override
  Future<Uint8List> get(String path) async =>
      _files[path]?.$1 ?? (throw NotFoundException(path));

  @override
  Future<void> put(String path, Uint8List bytes) async =>
      _files[path] = (Uint8List.fromList(bytes), DateTime.now().toUtc());

  @override
  Future<void> delete(String path) async => _files.remove(path);

  @override
  Future<Quota?> quota() async =>
      Quota(_files.values.fold(0, (s, f) => s + f.$1.length), null);
}
