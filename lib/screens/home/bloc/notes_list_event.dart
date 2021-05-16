part of 'notes_list_bloc.dart';

abstract class NotesListEvent extends Equatable {
  const NotesListEvent();

  @override
  List<Object?> get props => [];
}

class NotesListInit extends NotesListEvent {}

class NotesListFetch extends NotesListEvent {
  NotesListFetch({
    this.from = 0,
    this.to = 9,
  });
  final int from;
  final int to;
  @override
  List<Object?> get props => [from, to];
}

class NotesListLoad extends NotesListEvent {
  NotesListLoad(this.notes);
  final List<Note> notes;
  @override
  List<Object?> get props => [notes];
}

class NotesListInsert extends NotesListEvent {
  NotesListInsert(this.note);
  final Note note;
  @override
  List<Object?> get props => [note];
}

class NotesListUpdate extends NotesListEvent {
  NotesListUpdate(this.note);
  final Note note;
  @override
  List<Object?> get props => [note];
}

class NotesListDelete extends NotesListEvent {
  NotesListDelete(this.note);
  final Note note;
  @override
  List<Object?> get props => [note];
}
