
import '../entities/note.dart';
import '../repositories/note_repository.dart';

class AddNoteUseCase {
  final NoteRepository noteRepo;

  AddNoteUseCase(this.noteRepo);

  Future<void> call(Note note) async {
    await noteRepo.createNote(note);
  }
}
