part of 'notes_list_bloc.dart';

abstract class NotesListState extends Equatable {
  const NotesListState();

  @override
  List<Object?> get props => [];
}

class NotesListInitial extends NotesListState {}

class NotesListData extends NotesListState {
  NotesListData({
    required this.notes,
  });
  final List<Note> notes;
  @override
  List<Object?> get props => [notes];
}

class NotesListError extends NotesListState {}
