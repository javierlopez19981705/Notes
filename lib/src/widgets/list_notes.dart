import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notepad/src/models/note_model.dart';
import 'package:notepad/src/providers/update_note_provider.dart';
import 'package:notepad/src/widgets/card_note.dart';
import 'package:provider/provider.dart';

class ListNotes extends StatelessWidget {
  final box = Hive.box<NoteModel>('notes');

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return ValueListenableBuilder(
      valueListenable: box.listenable(),
      builder: (BuildContext context, Box<dynamic> value, Widget? child) {
        return Padding(
          padding: EdgeInsets.only(top: 10, left: 10, right: 10),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300,
                childAspectRatio: (1000 / height),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),
            physics: BouncingScrollPhysics(),
            itemCount: value.length,
            itemBuilder: (c, i) {
              final note = box.getAt((value.length - 1) - i);
              return GestureDetector(
                child: CardNote(note: note!),
                onTap: () {
                  Navigator.pushNamed(context, 'update_note', arguments: {
                    'index': i,
                    'note': note,
                  });
                  final provider =
                      Provider.of<UpdateNoteProvider>(context, listen: false);
                  provider.note = note;
                  provider.colorInit = Color.fromRGBO(
                    provider.note.r,
                    provider.note.g,
                    provider.note.b,
                    1,
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
