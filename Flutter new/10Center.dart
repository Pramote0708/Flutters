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
    return Center(
      child: Container(
      color: Colors.orange,
      margin: const EdgeInsets.symmetric(horizontal:20,vertical:30),
      padding: const EdgeInsets.all(20),
      child: const Text(
        "Lek",
        style: TextStyle(
          fontSize: 30,
          letterSpacing:3
        ),//TextStyle
      ),//Text
    ),//Container
   );//Center
 }//Widget
}//Home