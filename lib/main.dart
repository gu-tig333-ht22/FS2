import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'main_page.dart';
import 'model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: ((context) => MyState()),
      child: MaterialApp(
        title: 'ToDo App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.grey,
        ),
        home: MyHomePage(),
      ),
    );
  }
}
