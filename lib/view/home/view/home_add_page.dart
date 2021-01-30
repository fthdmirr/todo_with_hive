import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_with_hive/core/constants/constants.dart';
import 'package:todo_with_hive/view/home/model/todo_model.dart';

class TodoAddPage extends StatefulWidget {
  @override
  _TodoAddPageState createState() => _TodoAddPageState();
}

class _TodoAddPageState extends State<TodoAddPage> {
  TextEditingController title = TextEditingController();
  TextEditingController note = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildContainer(context),
    );
  }

  Container buildContainer(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: title,
              decoration: InputDecoration(hintText: "Task"),
              onSaved: (newValue) => title.text = newValue,
            ),
            TextFormField(
              controller: note,
              decoration: InputDecoration(hintText: "note"),
              onSaved: (newValue) => note.text = newValue,
            ),
            RaisedButton(
              child: Text("ADD"),
              onPressed: () => _addItems(title.text, note.text, context),
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() => AppBar(
        title: Text("Add Todo"),
      );

  _addItems(String task, String note, BuildContext context) {
    Box<Todo> hiveTodo = Hive.box<Todo>(Constants.TODO_CONTS);
    hiveTodo.add(Todo(task: task, note: note));
    Navigator.pop(context);
  }
}
