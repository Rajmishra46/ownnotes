import 'dart:convert';
import 'dart:typed_data';

import 'package:notes_sync/notes_sync.dart';
import 'package:provider_api/provider_api.dart';

/// M0 placeholder: 3 devices push plaintext changesets through one
/// MemoryProvider; each pulls and must end up with every other device's
/// segments. Replace payloads with sealed sqlite_crdt changesets in M0.
Future<void> main() async {
  final remote = MemoryProvider();
  final devices = ['a', 'b', 'c'].map((d) => SyncEngine(remote, d)).toList();

  for (var round = 0; round < 5; round++) {
    for (final d in devices) {
      await d.push(Uint8List.fromList(utf8.encode('${d.deviceId}:$round')));
    }
  }

  for (final d in devices) {
    final got = (await d.pull()).map(utf8.decode).toList();
    final expected = devices.length - 1;
    final ok = got.length == expected * 5;
    print('${d.deviceId}: received ${got.length} segments ${ok ? 'OK' : 'FAIL'}');
    if (!ok) throw StateError('device ${d.deviceId} did not converge');
  }
  print('converged');
}
