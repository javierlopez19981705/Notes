import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notepad/src/models/note_model.dart';
// import 'package:notepad/src/widgets/card_note.dart';

class CardsProviders extends ChangeNotifier {
  final box = Hive.box<NoteModel>('notes');

  saveNote({required NoteModel note}) async {
    final newModel = new NoteModel(
        title: note.title,
        body: note.body,
        dateCreated: note.dateCreated,
        r: note.r,
        g: note.g,
        b: note.b);

    this.box.put(newModel.dateCreated, newModel);
  }

  updateNote({required NoteModel note}) {
    final newModel = new NoteModel(
        title: note.title,
        body: note.body,
        dateCreated: note.dateCreated,
        r: note.r,
        g: note.g,
        b: note.b);
    this.box.put(newModel.dateCreated, newModel);
  }

  removeNote({required String key}) {
    this.box.delete(key);
  }
}
