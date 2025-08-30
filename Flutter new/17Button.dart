import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      title: "My Tittel",
      home: Scaffold(
        appBar: AppBar(
          title: const Text("My App"),
          backgroundColor: Colors.blue,
          centerTitle: true,
        ),
        body: const Home(),
      ),
    ),
  );
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            onPressed: () {
              print("Button Click");
            },
            child: const Text(
              "Text",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ), //textButton
          const SizedBox(height: 10),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Colors.brown,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              print("Button Click");
            },
            child: const Text(
              "Filled",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ), //filledButton
          const SizedBox(height: 10),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: const BorderSide(
                color: Colors.red,
                width: 2,
              ),
            ),
            onPressed: () {
              print("Button Click");
            },
            child: const Text(
              "OutLined",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ), //OutLinedButton
          const SizedBox(height: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              //backgroundColor: Colors.black,
              foregroundColor: Colors.brown,
            ),
            onPressed: () {
              print("Button Click");
            },
            child: const Text(
              "Elevated",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ) //ElevatedButton
        ],
      ), //Column
    ); //Center
  }
}