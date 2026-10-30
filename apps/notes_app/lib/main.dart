import 'package:flutter/cupertino.dart';

void main() => runApp(const OwnNotesApp());

const notesYellow = Color(0xFFE3B500);

class OwnNotesApp extends StatelessWidget {
  const OwnNotesApp({super.key});

  @override
  Widget build(BuildContext context) => const CupertinoApp(
        title: 'OwnNotes',
        theme: CupertinoThemeData(primaryColor: notesYellow),
        home: Shell(),
      );
}

/// >= 1100: sidebar | list | editor. 700-1100: list | editor. < 700: stack.
class Shell extends StatelessWidget {
  const Shell({super.key});

  @override
  Widget build(BuildContext context) => LayoutBuilder(builder: (context, c) {
        if (c.maxWidth < 700) return const NoteList();
        return Row(children: [
          if (c.maxWidth >= 1100) const SizedBox(width: 240, child: Sidebar()),
          const SizedBox(width: 320, child: NoteList()),
          const Expanded(child: Editor()),
        ]);
      });
}

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) => const CupertinoPageScaffold(
        backgroundColor: CupertinoColors.systemGroupedBackground,
        child: SafeArea(
          child: Column(children: [
            CupertinoListTile(leading: Icon(CupertinoIcons.folder), title: Text('All Notes')),
            Spacer(),
            Padding(
              padding: EdgeInsets.all(12),
              child: Row(children: [
                Icon(CupertinoIcons.cloud, size: 16, color: CupertinoColors.systemGrey),
                SizedBox(width: 6),
                Text('Not synced', style: TextStyle(fontSize: 12, color: CupertinoColors.systemGrey)),
              ]),
            ),
          ]),
        ),
      );
}

class NoteList extends StatelessWidget {
  const NoteList({super.key});

  @override
  Widget build(BuildContext context) => const CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(middle: Text('Notes')),
        child: Center(
          child: Text('No Notes', style: TextStyle(color: CupertinoColors.systemGrey)),
        ),
      );
}

class Editor extends StatelessWidget {
  const Editor({super.key});

  @override
  Widget build(BuildContext context) => const CupertinoPageScaffold(
        child: Center(
          child: Text('Select a note', style: TextStyle(color: CupertinoColors.systemGrey)),
        ),
      );
}
