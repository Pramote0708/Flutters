//21 Enum
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
            color: data[index].job.color,
          ), //decoration
          margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
          padding: const EdgeInsets.all(20),
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
                    "อาย ${data[index].age} ปี,อาชีพ : ${data[index].job.title}",
                    style: const TextStyle(fontSize: 20), // Text
                  ),
                ],
              ), //Column
              Image.network(
                data[index].job.imageUrl,
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

enum Job {
  doctor(
      title: "หมอ",
      imageUrl: "https://cdn-icons-png.flaticon.com/512/3774/3774299.png",
      color: Colors.green),
  teacher(
      title: "ครู",
      imageUrl: "https://cdn-icons-png.flaticon.com/512/2784/2784445.png",
      color: Colors.purple),
  nurse(
      title: "พยาบาล",
      imageUrl: "https://cdn-icons-png.flaticon.com/512/3209/3209008.png",
      color: Colors.pink),
  police(
      title: "ตำรวจ",
      imageUrl: "https://cdn-icons-png.flaticon.com/512/2716/2716553.png",
      color: Colors.blue);

  const Job({required this.title, required this.imageUrl, required this.color});
  final String title;
  final String imageUrl;
  final Color color;
}

class Person {
  Person({required this.name, required this.age, required this.job});
  String name;
  int age;
  Job job;
}

List<Person> data = [
  Person(name: "ก้อง", age: 30, job: Job.doctor),
  Person(name: "โจโจ", age: 25, job: Job.teacher),
  Person(name: "เจน", age: 28, job: Job.nurse),
  Person(name: "ชาลี", age: 30, job: Job.police),
  Person(name: "ลูกน้ำ", age: 18, job: Job.teacher),
];