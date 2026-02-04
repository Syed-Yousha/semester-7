
import '../entities/note.dart';
import '../repositories/note_repository.dart';

class UpdateNoteUseCase {
  final NoteRepository noteRepo;

  UpdateNoteUseCase(this.noteRepo);

  Future<void> call(Note note) async {
    await noteRepo.updateNote(note);
  }
}
