import 'package:circle_color_picker_view/circle_color_picker_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notepad/src/models/note_model.dart';
import 'package:notepad/src/providers/cards_provider.dart';
import 'package:notepad/src/providers/update_note_provider.dart';
import 'package:provider/provider.dart';

class UpdateNote extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final NoteModel note = arguments['note'];
    final color = Provider.of<UpdateNoteProvider>(context).color;

    // SystemChrome.setSystemUIOverlayStyle(
    //   SystemUiOverlayStyle(
    //     systemNavigationBarColor: color,
    //     statusBarColor: color,
    //   ),
    // );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color,
        actions: [
          IconButton(
            onPressed: () {
              final provider = Provider.of<CardsProviders>(
                context,
                listen: false,
              );
              provider.removeNote(key: note.dateCreated);
              Navigator.pop(context);
            },
            icon: Icon(Icons.delete),
          ),
          IconButton(
            onPressed: () {
              this._showDialog(context: context);
            },
            icon: Icon(Icons.color_lens),
          )
        ],
      ),
      floatingActionButton: this._saveNote(context: context),
      body: this._body(context: context),
    );
  }

  Widget _body({required BuildContext context}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Form(
        key: this._formKey,
        child: SafeArea(
          child: Column(
            children: [
              this._title(context: context),
              SizedBox(height: 20),
              this._bodyNote(context: context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _title({required BuildContext context}) {
    final provider = Provider.of<UpdateNoteProvider>(context, listen: false);
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(25.0),
          borderSide: BorderSide(color: provider.color),
        ),
        hoverColor: provider.color,
        focusColor: provider.color,
        filled: true,
        hintStyle: TextStyle(color: Colors.grey[800]),
        hintText: "Titulo",
        labelText: 'Titulo',
        fillColor: Colors.white70,
        labelStyle: TextStyle(color: provider.color),
      ),
      cursorColor: provider.color,
      initialValue: provider.note.title,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'No puede quedar vacio';
        }
        return null;
      },
      onSaved: (value) {
        provider.note.title = value!;
      },
    );
  }

  Widget _bodyNote({required BuildContext context}) {
    final provider = Provider.of<UpdateNoteProvider>(context, listen: false);
    return Expanded(
      child: TextFormField(
        scrollPhysics: BouncingScrollPhysics(),
        maxLines: null,
        expands: true,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          filled: true,
          hintStyle: TextStyle(color: Colors.grey[800]),
          hintText: "Nota",
          labelText: 'Nota',
          fillColor: Colors.white70,
          alignLabelWithHint: true,
          focusedBorder: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(15),
            borderSide: BorderSide(color: provider.color),
          ),
          labelStyle: TextStyle(color: provider.color),
        ),
        cursorColor: provider.color,
        textAlignVertical: TextAlignVertical.top,
        initialValue: provider.note.body,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'No puede quedar vacio';
          }
          return null;
        },
        onSaved: (value) {
          provider.note.body = value!;
        },
      ),
    );
  }

  Widget _saveNote({required BuildContext context}) {
    final provider = Provider.of<UpdateNoteProvider>(context);
    return FloatingActionButton(
      onPressed: () async {
        if (this._formKey.currentState!.validate()) {
          final providerNote =
              Provider.of<CardsProviders>(context, listen: false);
          this._formKey.currentState?.save();
          provider.note.r = provider.color.red;
          provider.note.g = provider.color.green;
          provider.note.b = provider.color.blue;
          await providerNote.saveNote(note: provider.note);
          Navigator.pop(context);
        }
      },
      child: Icon(Icons.save),
      backgroundColor: provider.color,
    );
  }

  _showDialog({required BuildContext context}) {
    final provider = Provider.of<UpdateNoteProvider>(context, listen: false);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Elije un nuevo color'),
          content: SingleChildScrollView(
            child: ColorPickerView(
              initialColor: provider.color,
              colorListener: (color) {
                provider.color = color;
              },
            ),
          ),
        );
      },
    );
  }
}
