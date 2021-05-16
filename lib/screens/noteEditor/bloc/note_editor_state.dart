part of 'note_editor_bloc.dart';

abstract class NoteEditorState extends Equatable {
  const NoteEditorState();

  @override
  List<Object?> get props => [];
}

class NoteEditorInitial extends NoteEditorState {}

class NoteEditorData extends NoteEditorState {
  NoteEditorData(this.note);
  final Note note;
  @override
  List<Object?> get props => [note];
}

class NoteEditorError extends NoteEditorState {
  NoteEditorError({this.error});
  final String? error;
  @override
  List<Object?> get props => [error];
}
