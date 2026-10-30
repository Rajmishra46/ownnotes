import 'dart:typed_data';

import 'package:provider_api/provider_api.dart';

/// Drive v3 via googleapis. Scope: drive.file, folder "OwnNotes".
/// Drive allows duplicate names, so keep a local path -> fileId cache.
class GoogleDriveProvider implements StorageProvider {
  @override
  String get id => 'gdrive';

  @override
  Future<void> connect() => throw UnimplementedError('M2');
  @override
  Future<List<RemoteEntry>> list(String prefix) => throw UnimplementedError('M2');
  @override
  Future<Uint8List> get(String path) => throw UnimplementedError('M2');
  @override
  Future<void> put(String path, Uint8List bytes) => throw UnimplementedError('M2');
  @override
  Future<void> delete(String path) => throw UnimplementedError('M2');
  @override
  Future<Quota?> quota() => throw UnimplementedError('M2');
}
