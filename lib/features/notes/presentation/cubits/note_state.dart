import 'package:bloc_sm/features/notes/domain/entities/note.dart';

abstract class NoteState {}

class NoteInitial extends NoteState {}

class NotesLoading extends NoteState {}

class NotesLoaded extends NoteState {
  List<Note> notes;
  NotesLoaded(this.notes);
}

class NotesError extends NoteState {
  String message;
  NotesError(this.message);
}