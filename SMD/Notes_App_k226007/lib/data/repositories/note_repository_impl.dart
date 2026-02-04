
import '../../domain/entities/note.dart';
import '../../domain/repositories/note_repository.dart';
import '../datasources/note_datasource.dart';
import '../models/note_model.dart';

class NoteRepositoryImpl implements NoteRepository {
  final NoteDataSource noteSource;

  NoteRepositoryImpl({required this.noteSource});

  @override
  Future<List<Note>> getNotes() async {
    try {
      final fetchedModels = await noteSource.fetchNotes();
      return fetchedModels.map((model) => model.toEntity()).toList();
    } catch (err) {
      throw Exception('Could not retrieve notes: $err');
    }
  }

  @override
  Future<Note> getNote(int id) async {
    try {
      final allModels = await noteSource.fetchNotes();
      final foundModel = allModels.firstWhere(
        (item) => item.id == id,
        orElse: () => throw Exception('Note not found'),
      );
      return foundModel.toEntity();
    } catch (err) {
      throw Exception('Could not retrieve note: $err');
    }
  }

  @override
  Future<Note> createNote(Note note) async {
    try {
      final modelToAdd = NoteModel.fromEntity(note);
      final addedModel = await noteSource.addNote(modelToAdd);
      return addedModel.toEntity();
    } catch (err) {
      throw Exception('Could not create note: $err');
    }
  }

  @override
  Future<Note> updateNote(Note note) async {
    try {
      final modelToUpdate = NoteModel.fromEntity(note);
      final updatedModel = await noteSource.updateNote(modelToUpdate);
      return updatedModel.toEntity();
    } catch (err) {
      throw Exception('Could not update note: $err');
    }
  }

  @override
  Future<void> deleteNote(int id) async {
    try {
      await noteSource.deleteNote(id);
    } catch (err) {
      throw Exception('Could not delete note: $err');
    }
  }
}
