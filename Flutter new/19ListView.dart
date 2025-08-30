import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      title: "My Title",
      home: Scaffold(
        appBar: AppBar(
          title: const Text("My App"),
          backgroundColor: Colors.blue,
          centerTitle: true,
        ),
        body: const Item(),
      ),
    ),
  );
}

class Item extends StatefulWidget {
  const Item({super.key});
  
  @override
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> {
  List data = ["สมชาย", "ก้อง", "ชาลี", "โจโจ้", "ลูกน้ำ"];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context,index){
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.orange,
          ),//decoration
          margin: const EdgeInsets.symmetric(horizontal: 2,vertical: 5),
          padding: EdgeInsets.all(40),
          child: Text(
            data[index],
            style: const TextStyle(fontSize:30,fontWeight:FontWeight.bold),
          ),//Text
        );//Container
      },//itemBuilder
    ); //ListView.builder
  }
}
