import 'package:bloc_sm/features/auth/domain/entities/user.dart';
import 'package:bloc_sm/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:bloc_sm/features/notes/data/node_note_repository.dart';
import 'package:bloc_sm/features/notes/domain/repositories/note_repository.dart';
import 'package:bloc_sm/features/notes/presentation/cubits/note_cubit.dart';
import 'package:bloc_sm/features/notes/presentation/cubits/note_state.dart';
import 'package:bloc_sm/features/notes/presentation/widgets/note_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotesPage extends StatelessWidget {

  final String route;
  final bool isOwn;
  final bool isWritable;
  final String notesType;

  NotesPage({
    super.key,
    required this.route,
    required this.isOwn,
    required this.isWritable,
    required this.notesType
  });
  
  final NoteRepository noteRepository = NodeNoteRepository();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(notesType),
        centerTitle: true,
        foregroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: BlocProvider(
        create: (context) {
          final User? currentUser = context.read<AuthCubit>().currentUser;
          return NoteCubit(noteRepository)..getAllNotesOfaUserBasedonRoute(route, currentUser!.token);
        },
        child: BlocConsumer<NoteCubit, NoteState>(
          builder: (context, noteState) {
            if(noteState is NoteInitial || noteState is NotesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            else if(noteState is NotesLoaded) {
              return Padding(
                padding: const EdgeInsets.all(10),
                child: noteState.notes.isNotEmpty ? ListView(
                  children: [
                    for(int i=0;i<noteState.notes.length;i++)
                      NoteTile(note: noteState.notes[i], isOwn: isOwn, isWritable: isWritable)
                  ],
                ) :
                const Center(
                  child: Text("No notes"),
                ),
              );
            }
            return const Center(
              child: Text("Error loading notes"),
            );
          },
          listener: (context, noteState) {
            if(noteState is NotesError) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(noteState.message)));
            }
          }
        ),
      ),
    );
  }
}