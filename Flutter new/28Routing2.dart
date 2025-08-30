import 'package:flutter/material.dart';

void main() {
  runApp(const Item());
}

class Item extends StatefulWidget {
  const Item({super.key});

  @override
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My App",
      home: Scaffold(
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
                    ), //decoration
                    margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
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
              ), //ListView.builder
            ), //Expanded
            SizedBox(
              width: 100,
              height: 100,
              // Wrap IconButton with Builder to get a context that is a descendant of MaterialApp's Navigator.
              child: Builder(
                builder: (BuildContext innerContext) {
                  return IconButton(
                    icon: const Icon(Icons.add, size: 40, color: Colors.blue),
                    onPressed: () {
                      Navigator.push<void>(
                        innerContext, // Use the innerContext from Builder
                        MaterialPageRoute<void>(builder: (BuildContext ctx) => const AddForm()),
                      ).then((_) {
                        // This setState forces a rebuild of Item after AddForm is popped,
                        // ensuring the updated data list is displayed.
                        setState(() {});
                      });
                    },
                  );
                },
              ), //IconButton
            ), //SizedBox
          ],
        ), //Column
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

List<Person> data = <Person>[
  Person(name: "ก้อง", age: 30, job: Job.doctor),
  Person(name: "โจโจ", age: 25, job: Job.teacher),
];

class AddForm extends StatefulWidget {
  const AddForm({super.key});

  @override
  State<AddForm> createState() => _AddFormState();
}

class _AddFormState extends State<AddForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _name = "";
  int _age = 20;
  Job _job = Job.police;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("เพิ่มข้อมูลบุคคล"), // Changed title for clarity
        backgroundColor: Colors.blue,
        centerTitle: true,
      ), //AppBar
      body: Padding(
        padding: const EdgeInsets.all(20), // Increased padding for better layout
        child: Form(
          key: _formKey,
          child: SingleChildScrollView( // Added SingleChildScrollView to prevent overflow
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  maxLength: 20,
                  decoration: const InputDecoration(
                    label: Text("ชื่อ", style: TextStyle(fontSize: 20)),
                    border: OutlineInputBorder(), // Added border for better look
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
                ), //TextFormField
                const SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    label: Text("อายุ", style: TextStyle(fontSize: 20)),
                    border: OutlineInputBorder(), // Added border
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
                ), //TextFormField
                const SizedBox(height: 20),
                DropdownButtonFormField<Job>(
                  value: _job,
                  decoration: const InputDecoration(
                    label: Text("อาชีพ", style: TextStyle(fontSize: 20)),
                    border: OutlineInputBorder(), // Added border
                  ),
                  items: Job.values.map<DropdownMenuItem<Job>>((Job jobItem) {
                    return DropdownMenuItem<Job>(
                      value: jobItem,
                      child: Text(jobItem.title),
                    ); //DropdownMenuItem
                  }).toList(),
                  onChanged: (Job? value) {
                    setState(() {
                      _job = value!;
                    });
                  },
                ), //DropdownButtonFormField
                const SizedBox(height: 30),
                FilledButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      data.add(Person(name: _name, age: _age, job: _job));
                      Navigator.pop(context);
                    }
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: const Text('บันทึก', style: TextStyle(fontSize: 20)),
                ), //FilledButton
                const SizedBox(height: 10),
                OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context); // Allow user to cancel and go back
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    side: const BorderSide(color: Colors.blue),
                  ),
                  child: const Text('ยกเลิก', style: TextStyle(fontSize: 20)),
                ), //OutlinedButton
              ],
            ), //Column
          ), //SingleChildScrollView
        ), //Form
      ), //Padding
    ); //Scaffold
  }
}