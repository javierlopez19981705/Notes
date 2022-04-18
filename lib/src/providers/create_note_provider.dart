import 'dart:math';

import 'package:flutter/material.dart';
import 'package:notepad/src/models/note_model.dart';

class CreateNoteProvider extends ChangeNotifier {
  bool initialColor = false;
  late Color _color;
  late NoteModel model = new NoteModel();

  Color get color => this._color;

  set color(Color color) {
    this._color = color;
    notifyListeners();
  }

  reset() {
    final r = Random().nextInt(255);
    final g = Random().nextInt(255);
    final b = Random().nextInt(255);
    this.color = Color.fromRGBO(r, g, b, 1);
  }
}
