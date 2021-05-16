import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart' as gets;
import 'package:rxdart/rxdart.dart';

import 'package:supabase_notes/api/api.dart';
import 'package:supabase_notes/models/models.dart';
import 'package:supabase_notes/utils/locator.dart';

part 'note_editor_event.dart';
part 'note_editor_state.dart';

class NoteEditorBloc extends Bloc<NoteEditorEvent, NoteEditorState> {
  NoteEditorBloc({NotesRepo? notesRepo})
      : _notes = notesRepo ?? locator.get<NotesRepo>(),
        super(NoteEditorInitial());
  final NotesRepo _notes;

  @override
  Stream<Transition<NoteEditorEvent, NoteEditorState>> transformEvents(
      Stream<NoteEditorEvent> events,
      TransitionFunction<NoteEditorEvent, NoteEditorState> transitionFn) {
    final nonDebounceStream = events.where(
        (event) => event is! NoteTitleChanged && event is! NoteBodyChanged);

    final debounceStream = events
        .where((event) => event is NoteTitleChanged || event is NoteBodyChanged)
        .debounceTime(const Duration(milliseconds: 300));
    return super.transformEvents(
      MergeStream([nonDebounceStream, debounceStream]),
      transitionFn,
    );
  }

  @override
  Stream<NoteEditorState> mapEventToState(
    NoteEditorEvent event,
  ) async* {
    if (event is NoteEditorInit) {
      yield* _mapNoteEditorInitToState(event);
    } else if (event is NoteTitleChanged) {
      yield* _mapNoteTitleChangedToState(event);
    } else if (event is NoteBodyChanged) {
      yield* _mapNoteBodyChangedState(event);
    } else if (event is NoteEditorSave) {
      yield* _mapNoteEditorSaveToState(event);
    } else if (event is NoteEditorDelete) {
      yield* _mapNoteEditorDeleteToState();
    }
  }

  Stream<NoteEditorState> _mapNoteEditorInitToState(
      NoteEditorInit event) async* {
    try {
      if (event.note != null)
        yield NoteEditorData(event.note!);
      else {
        final newNote = await _notes.insert(Note.empty());
        yield NoteEditorData(newNote);
      }
    } on NotesRepoError catch (err) {
      yield NoteEditorError(error: err.message);
    }
  }

  Stream<NoteEditorState> _mapNoteTitleChangedToState(
      NoteTitleChanged event) async* {
    try {
      final note = (state as NoteEditorData).note.copyWith(title: event.title);
      yield NoteEditorData(note);
      await _notes.update(note);
    } catch (_) {
      yield NoteEditorError();
    }
  }

  Stream<NoteEditorState> _mapNoteBodyChangedState(
      NoteBodyChanged event) async* {
    try {
      final note = (state as NoteEditorData).note.copyWith(body: event.body);
      yield NoteEditorData(note);
      await _notes.update(note);
    } catch (_) {
      yield NoteEditorError();
    }
  }

  Stream<NoteEditorState> _mapNoteEditorSaveToState(
      NoteEditorSave event) async* {
    try {
      final note = event.note;
      if (note.body == null && note.title == null)
        await _notes.delete(note);
      else
        await _notes.update(note);
    } catch (_) {
      yield NoteEditorError();
    }
  }

  Stream<NoteEditorState> _mapNoteEditorDeleteToState() async* {
    try {
      final note = (state as NoteEditorData).note;
      gets.Get.back();
      await _notes.delete(note);
    } catch (_) {
      yield NoteEditorError();
    }
  }
}
