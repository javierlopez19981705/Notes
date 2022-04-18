import 'package:flutter/material.dart';
import 'package:notepad/src/models/note_model.dart';

class UpdateNoteProvider extends ChangeNotifier {
  late NoteModel note;
  late Color colorInit;

  Color get color => this.colorInit;

  set color(Color color) {
    this.colorInit = color;
    notifyListeners();
  }
}
