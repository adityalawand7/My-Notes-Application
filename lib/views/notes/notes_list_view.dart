import 'package:flutter/material.dart';
import 'package:mynotes/services/cloud/cloud_note.dart';
import 'package:mynotes/utilities/dialogs/delete_dialog.dart';

typedef NoteCallBack = void Function(CloudNote note);

class NotesListView extends StatelessWidget {
  final Iterable<CloudNote> notes;
  final NoteCallBack onDeleteNote;
  final NoteCallBack onTap;

  const NotesListView({
    super.key,
    required this.notes,
    required this.onDeleteNote,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (context, index) {
        final note = notes.elementAt(index);
        // return Padding(
        //   padding: const EdgeInsets.all(10.0),
        //   child: ListTile(
        //     onTap: () {
        //       onTap(note);
        //     },
        //     title: Text(
        //       note.text,
        //       maxLines: 1,
        //       softWrap: true,
        //       overflow: TextOverflow.ellipsis,
        //     ),
        //     trailing: IconButton(onPressed: () async{
        //       final shouldDelete = await showDeleteDialog(context);
        //       if(shouldDelete){
        //         onDeleteNote(note);
        //       }
        //     },
        //     icon: const Icon(Icons.delete)
        //     ),
        //   ),
        // );
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey, // Choose your border color
                width: 1.0, // Adjust the border width as needed
              ),
              borderRadius: BorderRadius.circular(
                  8.0), // Adjust the border radius as needed
            ),
            child: ListTile(
              onTap: () {
                onTap(note);
              },
              title: Text(
                note.text,
                maxLines: 1,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: IconButton(
                onPressed: () async {
                  final shouldDelete = await showDeleteDialog(context);
                  if (shouldDelete) {
                    onDeleteNote(note);
                  }
                },
                icon: const Icon(Icons.delete),
              ),
            ),
          ),
        );
      },
    );
  }
}
