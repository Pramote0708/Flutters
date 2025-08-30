//20 Data Models
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
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.orange,
          ), //decoration
          margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
          padding: const EdgeInsets.all(40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data[index].name,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ), //Text (for name)
                  Text(
                    "อาย ${data[index].age} ปี,อาชีพ : ${data[index].job}",
                    style: const TextStyle(fontSize: 20), // Text
                  ),
                ],
              ), //Column
              Image.network(
                "https://storage.googleapis.com/cms-storage-bucket/a9d6ce81aee44ae017ee.png",
                width: 60,
                height: 60,
              ), //Image.network
            ],
          ), //Row
        ); //Container
      }, //itemBuilder
    ); //ListView.builder
  }
}

class Person {
  Person({required this.name, required this.age, required this.job});
  String name;
  int age;
  String job;
}

List<Person> data = [
  Person(name: "ก้อง", age: 30, job: "หมอ"),
  Person(name: "โจโจ", age: 25, job: "ครู"),
  Person(name: "เจน", age: 28, job: "พยาบาล"),
  Person(name: "ชาลี", age: 30, job: "ตำรวจ")
];
