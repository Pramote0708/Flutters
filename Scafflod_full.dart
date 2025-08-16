import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Full Scaffold Example',
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0; // เก็บ index ของ bottom navigation

  // เนื้อหาของแต่ละหน้า
  static const List<Widget> _pages = [
    Center(child: Text('หน้าแรก', style: TextStyle(fontSize: 24))),
    Center(child: Text('ค้นหา', style: TextStyle(fontSize: 24))),
    Center(child: Text('ตั้งค่า', style: TextStyle(fontSize: 24))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // แถบด้านบน
      appBar: AppBar(
        title: const Text('Scaffold ครบทุกฟีเจอร์'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              print("กดค้นหา");
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              print("เมนูเพิ่มเติม");
            },
          ),
        ],
      ),

      // เนื้อหาหลัก
      body: _pages[_selectedIndex],

      // ปุ่มลอย
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("กดปุ่มลอย");
        },
        backgroundColor: Colors.red,
        child: const Icon(Icons.add),
      ),

      // แถบเมนูล่าง
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "หน้าแรก"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "ค้นหา"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "ตั้งค่า"),
        ],
      ),

      // เมนูด้านซ้าย
      drawer: Drawer(
        child: ListView(
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text('คุณ Flutter'),
              accountEmail: Text('flutter@example.com'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 40),
              ),
              decoration: BoxDecoration(color: Colors.blue),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('หน้าแรก'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('ตั้งค่า'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),

      // เมนูด้านขวา
      endDrawer: Drawer(
        child: ListView(
          children: const [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.green),
              child: Text('เมนูด้านขวา', style: TextStyle(color: Colors.white)),
            ),
            ListTile(
              title: Text('ตัวเลือก A'),
            ),
            ListTile(
              title: Text('ตัวเลือก B'),
            ),
          ],
        ),
      ),

      // สีพื้นหลังของ Scaffold
      backgroundColor: Colors.grey[200],
    );
  }
}