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
        body: Text("สวัสดีครับผม"),
      ),//Scaffold
    )//MaterialApp
  );//runApp
}
