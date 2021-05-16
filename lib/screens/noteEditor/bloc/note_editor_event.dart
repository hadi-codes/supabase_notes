part of 'note_editor_bloc.dart';

abstract class NoteEditorEvent extends Equatable {
  const NoteEditorEvent();
}

class NoteEditorInit extends NoteEditorEvent {
  const NoteEditorInit({this.note, this.isNewNote = true});
  final Note? note;
  final bool isNewNote;
  @override
  List<Object?> get props => [note];
}

class NoteTitleChanged extends NoteEditorEvent {
  const NoteTitleChanged(this.title);
  final String title;

  @override
  List<Object?> get props => [title];
}

class NoteBodyChanged extends NoteEditorEvent {
  const NoteBodyChanged(this.body);
  final String body;

  @override
  List<Object?> get props => [body];
}

class NoteEditorSave extends NoteEditorEvent {
  const NoteEditorSave(this.note);
  final Note note;

  @override
  List<Object?> get props => [note];
}

class NoteEditorDelete extends NoteEditorEvent {
  @override
  List<Object?> get props => [];
}
