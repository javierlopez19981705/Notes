import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:notepad/src/Utils/custom_colors.dart';
import 'package:notepad/src/models/note_model.dart';
import 'package:notepad/src/pages/create_note.dart';
import 'package:notepad/src/pages/home_page.dart';
import 'package:notepad/src/pages/update_note.dart';
import 'package:notepad/src/providers/cards_provider.dart';
import 'package:notepad/src/providers/create_note_provider.dart';
import 'package:notepad/src/providers/update_note_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter<NoteModel>(NoteModelAdapter());
  await Hive.openBox<NoteModel>('notes');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  final ThemeData theme = ThemeData();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CardsProviders()),
        ChangeNotifierProvider(create: (_) => CreateNoteProvider()),
        ChangeNotifierProvider(create: (_) => UpdateNoteProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: theme.copyWith(
          colorScheme: theme.colorScheme.copyWith(
            secondary: primaryColor,
          ),
        ),
        routes: {
          'create_note': (_) => CreateNotePage(),
          'update_note': (_) => UpdateNote(),
        },
        home: HomePage(),
      ),
    );
  }
}
