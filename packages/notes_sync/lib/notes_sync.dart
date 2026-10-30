import 'dart:typed_data';

import 'package:provider_api/provider_api.dart';

/// Remote layout:
///   vault.json
///   devices/<deviceId>/seg-000001.enc
///   devices/<deviceId>/snapshot-<hlc>.enc
///   blobs/<hmac>.enc
String segmentPath(String deviceId, int seq) =>
    'devices/$deviceId/seg-${seq.toString().padLeft(6, '0')}.enc';

int? segmentSeq(String path) {
  final m = RegExp(r'seg-(\d{6})\.enc$').firstMatch(path);
  return m == null ? null : int.parse(m.group(1)!);
}

/// Each device writes only its own folder and reads everyone else's,
/// so no locks or atomic writes are needed on any backend.
class SyncEngine {
  final StorageProvider remote;
  final String deviceId;
  int _nextSeq = 1;
  final Map<String, int> cursors = {}; // last applied seq per remote device

  SyncEngine(this.remote, this.deviceId);

  Future<void> push(Uint8List sealedChangeset) async {
    await remote.put(segmentPath(deviceId, _nextSeq), sealedChangeset);
    _nextSeq++;
  }

  /// Returns new sealed segments from other devices, in order, and
  /// advances cursors. The caller decrypts and merges them.
  Future<List<Uint8List>> pull() async {
    final out = <Uint8List>[];
    final entries = await remote.list('devices/');
    for (final e in entries) {
      final parts = e.path.split('/');
      if (parts.length != 3 || parts[1] == deviceId) continue;
      final seq = segmentSeq(e.path);
      if (seq == null || seq <= (cursors[parts[1]] ?? 0)) continue;
      out.add(await remote.get(e.path));
      cursors[parts[1]] = seq;
    }
    return out;
  }
}
