import 'package:flutter/material.dart';

void main() {
  runApp(
      MaterialApp(
      title: "My Title", 
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Scaffold"),
          backgroundColor: Colors.blue,
        ),//AppBar
        body: const Home(),
      ),//Scaffold
    )//MaterialApp
  );//runApp
}
class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange,
      margin: const EdgeInsets.fromLTRB(5,10,20,30),
    );//Container
 }//Widget
}//Home