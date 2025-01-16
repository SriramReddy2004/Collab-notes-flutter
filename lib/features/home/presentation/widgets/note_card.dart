import 'package:bloc_sm/features/notes/presentation/pages/notes_page.dart';
import 'package:flutter/material.dart';

class NoteCard extends StatelessWidget {

  final String text;
  final String route;
  final bool isOwn;
  final bool isWritable;

  const NoteCard({
    super.key,
    required this.text,
    required this.route,
    required this.isOwn,
    required this.isWritable
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => NotesPage(route: route, isOwn: isOwn, isWritable: isWritable, notesType: text)));
      },
      child: Container(
        width: double.infinity,
        height: (MediaQuery.sizeOf(context).height-140)/3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.inversePrimary,
              spreadRadius: -5,
              blurRadius: 10
            )
          ],
          color: Theme.of(context).colorScheme.secondary
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Theme.of(context).colorScheme.primary
            ),
          ),
        ),
      )
    );
  }
}