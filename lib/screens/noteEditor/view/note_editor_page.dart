import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_notes/models/models.dart';
import '../bloc/note_editor_bloc.dart';
import '../view/note_editor_view.dart';

class NoteEditorPage extends StatelessWidget {
  const NoteEditorPage({Key? key, this.note}) : super(key: key);
  final Note? note;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NoteEditorBloc()
        ..add(
            NoteEditorInit(note: note, isNewNote: note == null ? true : false)),
      child: const NoteEditorView(),
    );
  }
}
