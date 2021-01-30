import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/constants/constants.dart';
import 'view/home/model/todo_model.dart';
import 'view/home/view/home_page.dart';

Future<void> main() async {
  await Hive.initFlutter();
 Hive.registerAdapter(TodoAdapter());
  await Hive.openBox<Todo>(Constants.TODO_CONTS);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo with Hive',
      home: HomePage(),
    );
  }
}
