import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/note_repository.dart';
import 'notes_event.dart';
import 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final NoteRepository? repository;

  NotesBloc({this.repository}) : super(NotesInitial()) {
    on<FetchNotes>(_onFetchNotes);
    on<AddNoteEvent>(_onAddNote);
    on<UpdateNoteEvent>(_onUpdateNote);
    on<DeleteNoteEvent>(_onDeleteNote);
  }

  Future<void> _onFetchNotes(FetchNotes event, Emitter<NotesState> emit) async {
    emit(NotesLoading());
    try {
      if (repository == null) throw Exception('Repository not provided');
      final notes = await repository!.getNotes();
      emit(NotesLoaded(notes));
    } catch (e) {
      emit(NotesError('Failed to fetch notes: $e'));
    }
  }

  Future<void> _onAddNote(AddNoteEvent event, Emitter<NotesState> emit) async {
    emit(NotesLoading());
    try {
      if (repository == null) throw Exception('Repository not provided');
      await repository!.createNote(event.note);
      emit(const NotesSuccess('Note added successfully'));
      add(FetchNotes()); // refresh list
    } catch (e) {
      emit(NotesError('Failed to add note: $e'));
    }
  }

  Future<void> _onUpdateNote(UpdateNoteEvent event, Emitter<NotesState> emit) async {
    emit(NotesLoading());
    try {
      if (repository == null) throw Exception('Repository not provided');
      await repository!.updateNote(event.note);
      emit(const NotesSuccess('Note updated successfully'));
      add(FetchNotes()); // refresh list
    } catch (e) {
      emit(NotesError('Failed to update note: $e'));
    }
  }

  Future<void> _onDeleteNote(DeleteNoteEvent event, Emitter<NotesState> emit) async {
    emit(NotesLoading());
    try {
      if (repository == null) throw Exception('Repository not provided');
      await repository!.deleteNote(event.id);
      emit(const NotesSuccess('Note deleted successfully'));
      add(FetchNotes()); // refresh list
    } catch (e) {
      emit(NotesError('Failed to delete note: $e'));
    }
  }
}
