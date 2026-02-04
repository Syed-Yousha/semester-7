
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'presentation/screens/splash_screen.dart';
import 'presentation/bloc/auth/auth_bloc.dart';
import 'presentation/bloc/notes/notes_bloc.dart';
import 'data/repositories/note_repository_impl.dart';
import 'data/datasources/note_datasource.dart';


void main() {
  final notesSource = NoteDataSource();
  final notesRepo = NoteRepositoryImpl(noteSource: notesSource);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (_) => AuthBloc()),
        BlocProvider<NotesBloc>(create: (_) => NotesBloc(repository: notesRepo)),
      ],
      child: const MyNotesApp(),
    ),
  );
}


class MyNotesApp extends StatelessWidget {
  const MyNotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notes Application',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: const SplashScreen(),
    );
  }
}

