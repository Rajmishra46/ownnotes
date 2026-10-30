import 'dart:typed_data';

import 'package:provider_api/provider_api.dart';

/// PROPFIND depth 1 for list, GET/PUT/DELETE for the rest. HTTPS only.
class WebDavProvider implements StorageProvider {
  final Uri baseUrl;
  WebDavProvider(this.baseUrl);

  @override
  String get id => 'webdav';

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
