
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/note_model.dart';

class NoteDataSource {
  final List<NoteModel> _localNotes = [];

  Future<List<NoteModel>> fetchNotes() async {
    try {
      final apiResponse = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

      if (apiResponse.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(apiResponse.body);
        final fetchedNotes = jsonList.map((json) {
          return NoteModel(
            id: json['id'],
            title: json['title'],
            description: json['body'],
            createdAt: DateTime.now(),
          );
        }).toList();

        _localNotes.clear();
        _localNotes.addAll(fetchedNotes);

        return fetchedNotes;
      } else {
        throw Exception('Unable to fetch notes');
      }
    } catch (err) {
      throw Exception('Error fetching notes: $err');
    }
  }

  Future<NoteModel> addNote(NoteModel note) async {
    await Future.delayed(const Duration(seconds: 1));
    final createdNote = NoteModel(
      id: _localNotes.isEmpty ? 1 : (_localNotes.last.id ?? 0) + 1,
      title: note.title,
      description: note.description,
      createdAt: DateTime.now(),
    );
    _localNotes.add(createdNote);
    return createdNote;
  }

  Future<NoteModel> updateNote(NoteModel note) async {
    await Future.delayed(const Duration(seconds: 1));
    final idx = _localNotes.indexWhere((n) => n.id == note.id);
    if (idx == -1) throw Exception('Note not found');
    _localNotes[idx] = note;
    return note;
  }

  Future<void> deleteNote(int id) async {
    await Future.delayed(const Duration(seconds: 1));
    _localNotes.removeWhere((n) => n.id == id);
  }
}
