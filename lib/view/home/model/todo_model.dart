import 'package:hive/hive.dart';
part 'todo_model.g.dart';

@HiveType(typeId: 0)
class Todo extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  bool complete;
  @HiveField(2)
  String note;
  @HiveField(3)
  String task;

  Todo({this.complete = false, this.note = '', this.task});
}