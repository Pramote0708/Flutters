import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scaffold Features',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomePage(),
    );
  }
}

// Data model for a movie
class Movie {
  final String title;
  final int year;
  final String imageUrl;

  const Movie({
    required this.title,
    required this.year,
    required this.imageUrl,
  });
}

// Widget to display a single movie card
class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({
    required this.movie,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                movie.imageUrl,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) => Container(
                  height: 180,
                  color: Colors.grey[300],
                  child: const Center(
                    child: Icon(Icons.broken_image, color: Colors.grey),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12.0),
            Text(
              movie.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              'ปี: ${movie.year}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget for the "หน้า 2" page displaying movies
class MoviePage extends StatelessWidget {
  final List<Movie> movies;

  const MoviePage({
    required this.movies,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) {
      return const Center(
        child: Text(
          'ไม่มีข้อมูลหนังใหม่ปี 2025',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      );
    }
    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (BuildContext context, int index) {
        return MovieCard(movie: movies[index]);
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // Sample movie data for 2025
  final List<Movie> _newMovies2025 = const <Movie>[
    Movie(
      title: 'การผจญภัยของเจน (ภาค 2)',
      year: 2025,
      imageUrl: 'https://www.gstatic.com/flutter-onestack-prototype/genui/example_1.jpg',
    ),
    Movie(
      title: 'รหัสลับแห่งกาลเวลา',
      year: 2025,
      imageUrl: 'https://www.gstatic.com/flutter-onestack-prototype/genui/example_1.jpg',
    ),
    Movie(
      title: 'เงาในความมืด',
      year: 2025,
      imageUrl: 'https://www.gstatic.com/flutter-onestack-prototype/genui/example_1.jpg',
    ),
  ];

  late final List<Widget> _pages;

  _HomePageState() {
    _pages = <Widget>[
      const Center(child: Text('หน้าแรก', style: TextStyle(fontSize: 24))),
      const Center(child: Text('ค้นหา', style: TextStyle(fontSize: 24))),
      const Center(child: Text('ตั้งค่า', style: TextStyle(fontSize: 24))),
      MoviePage(movies: _newMovies2025), // หน้า 2 แสดงหนังใหม่ปี 2025
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scaffold Features'),
        backgroundColor: Colors.blue,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // ignore: avoid_print
              print("Search pressed");
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // ignore: avoid_print
              print("More options pressed");
            },
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // ignore: avoid_print
          print("Floating action button pressed");
        },
        backgroundColor: Colors.red,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "หน้าแรก"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "ค้นหา"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "ตั้งค่า"),
          BottomNavigationBarItem(icon: Icon(Icons.movie), label: "หนังใหม่ 2025"), // เปลี่ยน icon และ label ให้เข้ากับเนื้อหา
        ],
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const UserAccountsDrawerHeader(
              accountName: Text('คุณ Flutter'),
              accountEmail: Text('flutter@example.com'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage('https://www.gstatic.com/flutter-onestack-prototype/genui/example_1.jpg'),
                backgroundColor: Colors.white, // Fallback background color if image fails to load
              ),
              decoration: BoxDecoration(color: Colors.blue),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('หน้าแรก'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedIndex = 0;
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('ตั้งค่า'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedIndex = 2;
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.movie),
              title: const Text('หนังใหม่ปี 2025'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedIndex = 3;
                });
              },
            ),
          ],
        ),
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.green),
              child: Text('เมนูด้านขวา', style: TextStyle(color: Colors.white, fontSize: 20)),
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
      backgroundColor: Colors.grey[100],
    );
  }
}
