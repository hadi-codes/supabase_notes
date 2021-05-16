import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_notes/theme/theme.dart';

import '../bloc/note_editor_bloc.dart';

class NoteEditorView extends StatelessWidget {
  const NoteEditorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
              icon: Icon(
                FeatherIcons.trash,
                color: AppTheme.red,
              ),
              onPressed: () =>
                  context.read<NoteEditorBloc>()..add(NoteEditorDelete()))
        ],
      ),
      body: BlocBuilder<NoteEditorBloc, NoteEditorState>(
        builder: (context, state) {
          if (state is NoteEditorInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NoteEditorData) {
            return WillPopScope(
              onWillPop: () async {
                context.read<NoteEditorBloc>()..add(NoteEditorSave(state.note));
                return true;
              },
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextFormField(
                        initialValue: state.note.title,
                        onChanged: (title) => context.read<NoteEditorBloc>()
                          ..add(NoteTitleChanged(title)),
                        style: Theme.of(context).textTheme.headline5,
                        decoration: const InputDecoration(
                          hintText: 'Title',
                          border: InputBorder.none,
                        ),
                      ),
                      TextFormField(
                        initialValue: state.note.body,
                        style: Theme.of(context).textTheme.bodyText1,
                        keyboardType: TextInputType.multiline,
                        maxLines: 225,
                        minLines: 1,
                        onChanged: (body) => context.read<NoteEditorBloc>()
                          ..add(NoteBodyChanged(body)),
                        decoration: const InputDecoration(
                          hintText: 'Note',
                          border: InputBorder.none,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const Center(
              child: Text('error'),
            );
          }
        },
      ),
    );
  }
}
