import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_with_hive/view/home/view/home_add_page.dart';
import '../../../core/constants/constants.dart';
import '../model/todo_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: buildFloatingActionButton(context),
      appBar: buildAppBar(context),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<Todo>(Constants.TODO_CONTS).listenable(),
        builder: (context, value, child) =>
            value.values.isEmpty ? buildEmptyTextCenter : buildTodoList(value),
      ),
    );
  }

  FloatingActionButton buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TodoAddPage(),
            )));
  }

  AppBar buildAppBar(BuildContext context) => AppBar(
        title: Text("Todo"),
      );

  Center get buildEmptyTextCenter =>
      Center(child: Text("You dont have any todo"));

  ListView buildTodoList(Box<Todo> value) => ListView.builder(
      itemCount: value.values.length,
      itemBuilder: (context, index) {
        Todo todos = value.getAt(index);
        return buildTodoCard(todos);
      });

  Widget buildTodoCard(Todo todos) {
    return Dismissible(
      background: Container(
        color: Colors.red,
      ),
      key: Key(todos.id.toString()),
      onDismissed: (direction) => todos.delete(),
      child: Card(
        child: ListTile(
            title: Text(todos.task),
            subtitle: Text(todos.note) ?? "",
            trailing: todos.complete
                ? Icon(Icons.check)
                : Icon(Icons.check_box_outline_blank),
            onTap: () {
              todos.complete = !todos.complete;
              todos.save();
            }),
      ),
    );
  }
}
