
import '../repositories/note_repository.dart';

class RemoveNoteUseCase {
  final NoteRepository noteRepo;

  RemoveNoteUseCase(this.noteRepo);

  Future<void> call(int id) async {
    await noteRepo.deleteNote(id);
  }
}
