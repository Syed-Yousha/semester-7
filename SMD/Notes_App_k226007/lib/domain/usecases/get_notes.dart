
import '../entities/note.dart';
import '../repositories/note_repository.dart';

class FetchNotesUseCase {
  final NoteRepository noteRepo;

  FetchNotesUseCase(this.noteRepo);

  Future<List<Note>> call() async {
    return await noteRepo.getNotes();
  }
}
