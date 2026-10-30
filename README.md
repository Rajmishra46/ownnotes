# OwnNotes

Local-first, end-to-end encrypted notes with an Apple Notes look. Runs on iOS, Android, macOS, Windows, Linux and Web from one Flutter codebase. Your notes sync to storage you own: Google Drive, WebDAV (Nextcloud, Synology) or any S3-compatible bucket. There is no OwnNotes server.

## Status

M0 spike: architecture scaffold, provider interface, sync simulator.

## Layout

```
apps/notes_app/              Flutter app (all platforms)
packages/notes_core/         models, SQLite schema, search
packages/notes_crypto/       vault, key derivation, envelope encryption
packages/notes_sync/         push / pull / merge / compaction
packages/provider_api/       StorageProvider interface + in-memory fake
packages/providers/*         Google Drive, WebDAV, S3 adapters
tools/sync_sim/              multi-device convergence simulator
```

## Getting started

```bash
dart pub global activate melos
dart pub get
melos run analyze
melos run sim
cd apps/notes_app && flutter create . --platforms=ios,android,macos,windows,linux,web && flutter run
```

## Design

- Each device appends encrypted change segments to its own folder; it only reads other devices' folders. No locks needed on any backend.
- Row-level CRDT (hybrid logical clocks) for metadata; block-level 3-way merge for note bodies.
- Argon2id-derived key wraps a random vault key; files encrypted with XChaCha20-Poly1305.

## Licence

AGPL-3.0-only. See [LICENSE](LICENSE).
