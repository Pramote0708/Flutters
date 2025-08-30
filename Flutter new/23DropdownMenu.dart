//Dropdown Menu
import 'package:flutter/material.dart';

void main() {
  runApp(const AddForm());
}

class AddForm extends StatefulWidget {
  const AddForm({super.key});

  @override
  State<AddForm> createState() => _AddFormState();
}

class _AddFormState extends State<AddForm> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My App",
      home: Scaffold(
        appBar: AppBar(
          title: const Text("My App"),
          backgroundColor: Colors.blue,
          centerTitle: true,
        ), //AppBar
        body: Padding(
          padding: const EdgeInsets.all(5),
          child: Form(
            child: Column(
              children: [
                TextFormField(
                  maxLength: 20,
                  decoration: const InputDecoration(
                    label: Text("ชื่อ", style: TextStyle(fontSize: 20)),
                  ),
                ), //TextFormField
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    label: Text("อายุ", style: TextStyle(fontSize: 20)),
                  ),
                ), //TextFormField
                const SizedBox(height: 20),
                DropdownButtonFormField(
                  decoration: const InputDecoration(
                    label: Text("อาชีพ", style: TextStyle(fontSize: 20)),
                  ),
                  items: Job.values.map((key) {
                    return DropdownMenuItem(
                      value: key,
                      child: Text(key.title),
                    ); //DropdownMenuItem
                  }).toList(),
                  onChanged: (value) {
                    print(value);
                  },
                ), //DropdownButtonFormField
                FilledButton(
                  onPressed: () {},
                  style: FilledButton.styleFrom(backgroundColor: Colors.blue),
                  child: const Text('บันทึก', style: TextStyle(fontSize: 20)),
                ), //FilledButton
              ],
            ), //Column
          ), //Form
        ), //Padding
      ), //Scaffold
    ); //MaterialApp
  }
}

enum Job {
  doctor(
    title: "หมอ",
    imageUrl: "https://cdn-icons-png.flaticon.com/512/3774/3774299.png",
    color: Colors.green,
  ),
  teacher(
    title: "ครู",
    imageUrl: "https://cdn-icons-png.flaticon.com/512/2784/2784445.png",
    color: Colors.purple,
  ),
  nurse(
    title: "พยาบาล",
    imageUrl: "https://cdn-icons-png.flaticon.com/512/3209/3209008.png",
    color: Colors.pink,
  ),
  police(
    title: "ตำรวจ",
    imageUrl: "https://cdn-icons-png.flaticon.com/512/2716/2716553.png",
    color: Colors.blue,
  );

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
