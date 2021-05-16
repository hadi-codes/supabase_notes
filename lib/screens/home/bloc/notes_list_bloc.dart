import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase/supabase.dart';
import 'package:supabase_notes/api/api.dart';
import 'package:supabase_notes/models/models.dart';
import 'package:supabase_notes/utils/utils.dart';

part 'notes_list_event.dart';
part 'notes_list_state.dart';

class NotesListBloc extends Bloc<NotesListEvent, NotesListState> {
  NotesListBloc({NotesRepo? notesRepo})
      : _notes = notesRepo ?? locator.get<NotesRepo>(),
        super(NotesListInitial());
  final NotesRepo _notes;
  RealtimeSubscription? subscription;
  @override
  Stream<NotesListState> mapEventToState(
    NotesListEvent event,
  ) async* {
    if (event is NotesListInit) {
      yield* _mapNotesListInitToState(event);
    } else if (event is NotesListFetch) {
      yield* _mapNotesListFetchToState(event);
    } else if (event is NotesListLoad) {
      yield* _mapNotesListLoadToState(event);
    } else if (event is NotesListInsert) {
      yield* _mapNotesListInsertState(event);
    } else if (event is NotesListUpdate) {
      yield* _mapNotesListUpdateToState(event);
    } else if (event is NotesListDelete) {
      yield* _mapNotesListDeleteToState(event);
    }
  }

  Stream<NotesListState> _mapNotesListInitToState(NotesListInit event) async* {
    add(NotesListFetch());
    final userId = _notes.supabaseClient.auth.currentUser!.id;
    _notes.supabaseClient.from('notes').on(SupabaseEventTypes.all, (payload) {
      print('${payload.eventType} new : ${payload.newRecord}'
          ' old:${payload.oldRecord}');
      switch (payload.eventType) {
        case 'INSERT':
          final note = Note.fromMap(payload.newRecord);
          if (note.user_id == userId) add(NotesListInsert(note));
          break;
        case 'UPDATE':
          final note = Note.fromMap(payload.newRecord);
          if (note.user_id == userId) add(NotesListUpdate(note));
          break;
        case 'DELETE':
          final note = Note.fromMap(payload.oldRecord);
          add(NotesListDelete(note));
          break;
        default:
      }
    }).subscribe();
  }

  Stream<NotesListState> _mapNotesListFetchToState(
      NotesListFetch event) async* {
    try {
      final notes = await _notes.fetch();
      add(NotesListLoad(notes));
    } on NotesRepoError {
      yield NotesListError();
    }
  }

  Stream<NotesListState> _mapNotesListLoadToState(NotesListLoad event) async* {
    yield NotesListData(notes: event.notes);
  }

  Stream<NotesListState> _mapNotesListInsertState(
      NotesListInsert event) async* {
    final notes = List<Note>.from((state as NotesListData).notes)
      ..add(event.note);
    yield NotesListData(notes: notes);
  }

  Stream<NotesListState> _mapNotesListUpdateToState(
      NotesListUpdate event) async* {
    final notes = List<Note>.from((state as NotesListData).notes);
    notes[notes.indexWhere((note) => note.id == event.note.id)] = event.note;
    yield NotesListData(notes: notes);
  }

  Stream<NotesListState> _mapNotesListDeleteToState(
      NotesListDelete event) async* {
    final notes = List<Note>.from((state as NotesListData).notes)
      ..removeWhere((note) => note.id == event.note.id);
    yield NotesListData(notes: notes);
  }
}
