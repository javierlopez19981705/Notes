import 'package:hive_flutter/hive_flutter.dart';

part 'note_model.g.dart';

@HiveType(typeId: 0)
class NoteModel extends HiveObject {
  NoteModel({
    this.title = '',
    this.body = '',
    this.dateCreated = '',
    this.r = 0,
    this.g = 0,
    this.b = 0,
  });

  @HiveField(0)
  String title;

  @HiveField(1)
  String body;

  @HiveField(2)
  String dateCreated;

  @HiveField(3)
  int r;

  @HiveField(4)
  int g;

  @HiveField(5)
  int b;
}
