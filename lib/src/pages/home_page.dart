import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notepad/src/Utils/custom_colors.dart';
import 'package:notepad/src/providers/create_note_provider.dart';
import 'package:notepad/src/widgets/list_notes.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListNotes(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final provider =
              Provider.of<CreateNoteProvider>(context, listen: false);
          provider.reset();
          Navigator.pushNamed(context, 'create_note');
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }
}
