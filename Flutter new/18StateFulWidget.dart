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
  int quantity = 10;
  void addquantity() {
    setState(() {
      quantity += 1;
    });
  }

  void subtractquamtity() {
    setState(() {
      quantity = quantity <= 0 ? 0 : quantity - 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "$quantity",
            style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          OutlinedButton(
            onPressed: () {
              addquantity();
            },
            child: const Text(
              "+",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 20),
          OutlinedButton(
            onPressed: () {
              subtractquamtity();
            },
            child: const Text(
              "-",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ), //Column
    ); //Center
  }
}
