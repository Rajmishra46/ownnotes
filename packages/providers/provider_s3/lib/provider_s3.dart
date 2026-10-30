import 'dart:typed_data';

import 'package:provider_api/provider_api.dart';

/// ListObjectsV2 with paging for list; bucket + prefix = vault root.
class S3Provider implements StorageProvider {
  final String endpoint;
  final String bucket;
  final String prefix;
  S3Provider({required this.endpoint, required this.bucket, this.prefix = 'ownnotes/'});

  @override
  String get id => 's3';

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
