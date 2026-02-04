import 'package:equatable/equatable.dart';
import '../../../domain/entities/note.dart';

abstract class NotesEvent extends Equatable {
  const NotesEvent();
  @override
  List<Object?> get props => [];
}

class FetchNotes extends NotesEvent {}

class AddNoteEvent extends NotesEvent {
  final Note note;
  const AddNoteEvent(this.note);

  @override
  List<Object?> get props => [note];
}

class UpdateNoteEvent extends NotesEvent {
  final Note note;
  const UpdateNoteEvent(this.note);

  @override
  List<Object?> get props => [note];
}

class DeleteNoteEvent extends NotesEvent {
  final int id;
  const DeleteNoteEvent(this.id);

  @override
  List<Object?> get props => [id];
}
