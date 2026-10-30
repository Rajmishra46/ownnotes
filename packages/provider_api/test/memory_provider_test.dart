import 'dart:typed_data';

import 'package:provider_api/provider_api.dart';
import 'package:test/test.dart';

void main() {
  test('put, list, get, delete round-trip', () async {
    final p = MemoryProvider();
    await p.put('devices/a/seg-000001.enc', Uint8List.fromList([1, 2, 3]));
    await p.put('vault.json', Uint8List.fromList([9]));

    final entries = await p.list('devices/');
    expect(entries.map((e) => e.path), ['devices/a/seg-000001.enc']);
    expect(await p.get('vault.json'), [9]);

    await p.delete('vault.json');
    expect(() => p.get('vault.json'), throwsA(isA<NotFoundException>()));
  });
}
