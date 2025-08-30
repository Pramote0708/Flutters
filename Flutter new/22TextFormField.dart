//Text Form Field
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
