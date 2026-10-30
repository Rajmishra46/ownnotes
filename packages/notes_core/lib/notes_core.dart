/// Synced tables (sqlite_crdt adds hlc, node_id, modified, is_deleted).
const schema = <String>[
  '''CREATE TABLE IF NOT EXISTS folders (
    id TEXT PRIMARY KEY, parent_id TEXT, name TEXT NOT NULL, sort_key TEXT NOT NULL)''',
  '''CREATE TABLE IF NOT EXISTS notes (
    id TEXT PRIMARY KEY, folder_id TEXT, parent_note TEXT, title TEXT NOT NULL,
    snippet TEXT, pinned INTEGER DEFAULT 0, locked INTEGER DEFAULT 0,
    sort_key TEXT NOT NULL, created_at TEXT NOT NULL, updated_at TEXT NOT NULL)''',
  '''CREATE TABLE IF NOT EXISTS note_bodies (
    note_id TEXT PRIMARY KEY, doc_json TEXT NOT NULL, rev INTEGER NOT NULL)''',
  '''CREATE TABLE IF NOT EXISTS attachments (
    id TEXT PRIMARY KEY, note_id TEXT NOT NULL, mime TEXT NOT NULL,
    size INTEGER NOT NULL, sha256 TEXT NOT NULL, local_path TEXT)''',
];

class Note {
  final String id;
  final String? folderId;
  final String title;
  final String? snippet;
  final bool pinned;
  final DateTime updatedAt;

  const Note({
    required this.id,
    this.folderId,
    required this.title,
    this.snippet,
    this.pinned = false,
    required this.updatedAt,
  });
}
