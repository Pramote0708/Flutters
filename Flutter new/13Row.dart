import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      title: "My Title",
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Scaffold"),
          backgroundColor: Colors.blue,
        ), //AppBar
        body: const Home(),
      ), //Scaffold
    ), //MaterialApp
  ); //runApp
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          color: Colors.orange,
          padding: const EdgeInsets.all(20),
          child: const Text(
            "Lek1",
            style: TextStyle(fontSize: 30, letterSpacing: 3), //TextStyle
          ), //Text
        ), //Container1
        Container(
          color: Colors.orange,
          padding: const EdgeInsets.all(20),
          child: const Text(
            "Lek2",
            style: TextStyle(fontSize: 30, letterSpacing: 3), //TextStyle
          ), //Text
        ), //Container2
        Container(
          color: Colors.orange,
          padding: const EdgeInsets.all(20),
          child: const Text(
            "Lek3",
            style: TextStyle(fontSize: 30, letterSpacing: 3), //TextStyle
          ), //Text
        ), //Container3
      ], //children
    ); //Column
  } //Widget
} //Home
