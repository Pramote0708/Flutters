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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children:[
        Image.network(
          "https://storage.googleapis.com/cms-storage-bucket/a9d6ce81aee44ae017ee.png",
          width:150,
          height:150,
        ),//Image.network
      ],//children
    ); //Column
  } //Widget
} //Home
