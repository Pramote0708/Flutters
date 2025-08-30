import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My App",
      home: const ItemListScreen(),
    );
  }
}

class ItemListScreen extends StatefulWidget {
  const ItemListScreen({super.key});

  @override
  State<ItemListScreen> createState() => _ItemListScreenState();
}

class _ItemListScreenState extends State<ItemListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My App"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: data[index].job.color,
                  ),
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
                          ),
                          Text(
                            "อาย ${data[index].age} ปี,อาชีพ : ${data[index].job.title}",
                            style: const TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      Image.network(
                        data[index].job.imageUrl,
                        width: 60,
                        height: 60,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          SizedBox(
            width: 100,
            height: 100,
            child: IconButton(
              icon: const Icon(Icons.add, size: 40, color: Colors.blue),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<AddFormScreen>(builder: (BuildContext ctx) => const AddFormScreen()),
                ).then((_) {
                  // This callback is executed when AddFormScreen is popped
                  // Trigger a rebuild of ItemListScreen to reflect updated data
                  setState(() {});
                });
              },
            ),
          ),
        ],
      ),
    );
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
];

class AddFormScreen extends StatefulWidget {
  const AddFormScreen({super.key});

  @override
  State<AddFormScreen> createState() => _AddFormScreenState();
}

class _AddFormScreenState extends State<AddFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _name = "";
  int _age = 20;
  Job _job = Job.police;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My App"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                maxLength: 20,
                decoration: const InputDecoration(
                  label: Text("ชื่อ", style: TextStyle(fontSize: 20)),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "กรุณาป้อนชื่อของคุณ";
                  }
                  return null;
                },
                onSaved: (String? value) {
                  _name = value!;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  label: Text("อายุ", style: TextStyle(fontSize: 20)),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "กรุณาป้อนอายุของคุณ";
                  }
                  if (int.tryParse(value) == null) {
                    return "กรุณาป้อนอายุเป็นตัวเลข";
                  }
                  return null;
                },
                onSaved: (String? value) {
                  _age = int.parse(value!);
                },
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<Job>(
                value: _job,
                decoration: const InputDecoration(
                  label: Text("อาชีพ", style: TextStyle(fontSize: 20)),
                ),
                items: Job.values.map<DropdownMenuItem<Job>>((Job key) {
                  return DropdownMenuItem<Job>(
                    value: key,
                    child: Text(key.title),
                  );
                }).toList(),
                onChanged: (Job? value) {
                  setState(() {
                    _job = value!;
                  });
                },
              ),
              FilledButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    data.add(Person(name: _name, age: _age, job: _job));
                    _formKey.currentState!.reset();
                    Navigator.pop(context); // Go back to the previous screen
                  }
                },
                style: FilledButton.styleFrom(backgroundColor: Colors.blue),
                child: const Text('บันทึก', style: TextStyle(fontSize: 20)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}