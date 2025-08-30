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
class/ Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text("สวัสดีตอนเช้า");
 }//Widget
}//Home