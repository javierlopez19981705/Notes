import 'package:flutter/material.dart';
import 'package:notepad/src/models/note_model.dart';

class CardNote extends StatelessWidget {
  const CardNote({required this.note});

  final NoteModel note;

  @override
  Widget build(BuildContext context) {
    final titleStyle = TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );
    final bodyStyle = TextStyle(
      fontSize: 16,
      color: Colors.white,
    );

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color.fromRGBO(note.r, note.g, note.b, 1),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(this.note.title, style: titleStyle),
          Expanded(
            child: Text(
              this.note.body,
              style: bodyStyle,
              overflow: TextOverflow.fade,
            ),
          ),
          Text(this.note.dateCreated.split(' ')[0], style: bodyStyle),
        ],
      ),
    );
  }
}
