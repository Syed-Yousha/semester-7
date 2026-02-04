import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/note.dart';
import '../bloc/notes/notes_bloc.dart';
import '../bloc/notes/notes_event.dart';
import '../bloc/notes/notes_state.dart';
import '../widgets/note_card.dart';
import '../widgets/note_form.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<NotesBloc>().add(FetchNotes());
  }

  void _openAddNoteDialog() {
    showDialog(
      context: context,
      builder: (_) => NoteForm(
        onSubmit: (title, description) {
          final newNote = Note(
            title: title,
            description: description,
            createdAt: DateTime.now(),
          );

          context.read<NotesBloc>().add(AddNoteEvent(newNote));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notes')),

      body: BlocConsumer<NotesBloc, NotesState>(
        listener: (context, state) {
          if (state is NotesError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }

          if (state is NotesSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },

        builder: (context, state) {
          if (state is NotesInitial || state is NotesLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is NotesLoaded) {
            final notes = state.notes;

            if (notes.isEmpty) {
              return const Center(child: Text('No notes yet.'));
            }

            return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = notes[index];

                return NoteCard(
                  note: note,
                  onDelete: () =>
                      context.read<NotesBloc>().add(DeleteNoteEvent(note.id!)),

                  onEdit: () {
                    showDialog(
                      context: context,
                      builder: (_) => NoteForm(
                        note: note,
                        onSubmit: (title, description) {
                          final updated = note.copyWith(
                            title: title,
                            description: description,
                          );

                          context
                              .read<NotesBloc>()
                              .add(UpdateNoteEvent(updated));
                        },
                      ),
                    );
                  },
                );
              },
            );
          }

          if (state is NotesError) {
            return Center(child: Text(state.message));
          }

          return const SizedBox.shrink();
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _openAddNoteDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
