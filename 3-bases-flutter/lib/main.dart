import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Compteur());
  }
}

class Compteur extends StatefulWidget {
  @override
  _CompteurState createState() => _CompteurState();
}

class _CompteurState extends State<Compteur> {
  int i = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('MyApp')),
      body: Text('i = $i'),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            i++;
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
