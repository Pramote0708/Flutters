import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AreaCalculatorData>(
          create: (BuildContext context) => AreaCalculatorData(),
        ),
        ChangeNotifierProvider<VolumeCalculatorData>(
          create: (BuildContext context) => VolumeCalculatorData(),
        ),
      ],
      builder: (BuildContext context, Widget? child) => const MyApp(),
    ),
  );
}

class AreaCalculatorData extends ChangeNotifier {
  double _length;
  double _width;
  double _squareMeters;
  int _wholeRai;
  int _wholeNgan;
  double _remainingSquareWa;

  AreaCalculatorData()
      : _length = 0.0,
        _width = 0.0,
        _squareMeters = 0.0,
        _wholeRai = 0,
        _wholeNgan = 0,
        _remainingSquareWa = 0.0;

  double get length => _length;
  double get width => _width;
  double get squareMeters => _squareMeters;
  int get wholeRai => _wholeRai;
  int get wholeNgan => _wholeNgan;
  double get remainingSquareWa => _remainingSquareWa;

  void setLength(String value) {
    _length = double.tryParse(value) ?? 0.0;
    calculateArea(); // Calculate immediately on change
  }

  void setWidth(String value) {
    _width = double.tryParse(value) ?? 0.0;
    calculateArea(); // Calculate immediately on change
  }

  void calculateArea() {
    _squareMeters = _length * _width;

    final double totalSquareWa = _squareMeters / 4.0;

    _wholeRai = (totalSquareWa / 400).truncate();

    final double squareWaAfterRai = totalSquareWa % 400;

    _wholeNgan = (squareWaAfterRai / 100).truncate();

    _remainingSquareWa = squareWaAfterRai % 100;

    notifyListeners();
  }
}

class VolumeCalculatorData extends ChangeNotifier {
  double _length;
  double _width;
  double _height;
  double _volume;

  VolumeCalculatorData()
      : _length = 0.0,
        _width = 0.0,
        _height = 0.0,
        _volume = 0.0;

  double get length => _length;
  double get width => _width;
  double get height => _height;
  double get volume => _volume;

  void setLength(String value) {
    _length = double.tryParse(value) ?? 0.0;
    calculateVolume();
  }

  void setWidth(String value) {
    _width = double.tryParse(value) ?? 0.0;
    calculateVolume();
  }

  void setHeight(String value) {
    _height = double.tryParse(value) ?? 0.0;
    calculateVolume();
  }

  void calculateVolume() {
    _volume = _length * _width * _height;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App คำนวณ',
      debugShowCheckedModeBanner: false,
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
  int _selectedIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = <Widget>[
      HomePageContent(onNavigate: _onItemTapped), // Index 0: หน้าแรก
      const AreaCalculatorPage(), // Index 1: เครื่องคิดเลขพื้นที่
      const VolumeCalculatorPage(), // Index 2: เครื่องคิดเลขปริมาตร (New)
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App คำนวณ'),
        backgroundColor: Colors.blue,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // Action for more options button
            },
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "หน้าแรก"),
          BottomNavigationBarItem(
              icon: Icon(Icons.calculate), label: "พื้นที่"),
          BottomNavigationBarItem(
              icon: Icon(Icons.view_in_ar), label: "ปริมาตร"), // New
        ],
        type: BottomNavigationBarType.fixed,
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
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
                _onItemTapped(0);
              },
            ),
            ListTile(
              leading: const Icon(Icons.calculate),
              title: const Text('เครื่องคิดเลขพื้นที่'),
              onTap: () {
                Navigator.pop(context);
                _onItemTapped(1);
              },
            ),
            ListTile(
              leading: const Icon(Icons.view_in_ar), // New icon for volume
              title: const Text('เครื่องคิดเลขปริมาตร'), // New drawer item
              onTap: () {
                Navigator.pop(context);
                _onItemTapped(2);
              },
            ),
          ],
        ),
      ),
      endDrawer: Drawer(
        child: ListView(
          children: const <Widget>[
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
      backgroundColor: Colors.grey[200],
    );
  }
}

class HomePageContent extends StatelessWidget {
  final ValueChanged<int> onNavigate;

  const HomePageContent({super.key, required this.onNavigate});

  Widget _buildCalculatorAppButton(
      BuildContext context, IconData icon, String title, String description,
      VoidCallback onTap) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: <Widget>[
              Icon(icon, size: 48, color: Colors.blueAccent),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey[600],
                          ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 20, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'เลือกเครื่องมือคำนวณ',
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
          ),
          _buildCalculatorAppButton(
            context,
            Icons.square_foot,
            'คำนวณหาพื้นที่',
            'คำนวณพื้นที่เป็นตารางเมตร, ไร่, งาน, ตารางวา',
            () => onNavigate(1), // Navigates to AreaCalculatorPage
          ),
          _buildCalculatorAppButton(
            context,
            Icons.view_in_ar,
            'คำนวณหาปริมาตร',
            'คำนวณปริมาตรของรูปทรงเรขาคณิตต่างๆ',
            () => onNavigate(2), // Navigates to VolumeCalculatorPage
          ),
          // Add more calculator app buttons here if needed
        ],
      ),
    );
  }
}

class AreaCalculatorPage extends StatefulWidget {
  const AreaCalculatorPage({super.key});

  @override
  State<AreaCalculatorPage> createState() => _AreaCalculatorPageState();
}

class _AreaCalculatorPageState extends State<AreaCalculatorPage> {
  final TextEditingController _lengthController = TextEditingController();
  final TextEditingController _widthController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final AreaCalculatorData calculatorData =
          Provider.of<AreaCalculatorData>(context, listen: false);
      _lengthController.text =
          calculatorData.length == 0.0 ? '' : calculatorData.length.toString();
      _widthController.text =
          calculatorData.width == 0.0 ? '' : calculatorData.width.toString();
    });
  }

  @override
  void dispose() {
    _lengthController.dispose();
    _widthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final NumberFormat numberFormatter = NumberFormat('#,##0.00');

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<AreaCalculatorData>(
          builder: (BuildContext context, AreaCalculatorData calculatorData,
              Widget? child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    'คำนวณหาพื้นที่',
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
                TextField(
                  controller: _lengthController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: 'ความยาว (เมตร)',
                    hintText: 'ป้อนความยาว',
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.square_foot),
                  ),
                  onChanged: (String value) {
                    calculatorData.setLength(value);
                  },
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: _widthController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: 'ความกว้าง (เมตร)',
                    hintText: 'ป้อนความกว้าง',
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.square_foot),
                  ),
                  onChanged: (String value) {
                    calculatorData.setWidth(value);
                  },
                ),
                const SizedBox(height: 24.0),
                Card(
                  elevation: 4,
                  margin: EdgeInsets.zero,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          'ผลลัพธ์:',
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent),
                        ),
                        const Divider(height: 16, thickness: 1),
                        Text(
                          'พื้นที่ : ${numberFormatter.format(calculatorData.squareMeters)} ตารางเมตร',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          'พื้นที่ : ${calculatorData.wholeRai} ไร่ ${calculatorData.wholeNgan} งาน ${calculatorData.remainingSquareWa.toStringAsFixed(2)} ตารางวา',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class VolumeCalculatorPage extends StatefulWidget {
  const VolumeCalculatorPage({super.key});

  @override
  State<VolumeCalculatorPage> createState() => _VolumeCalculatorPageState();
}

class _VolumeCalculatorPageState extends State<VolumeCalculatorPage> {
  final TextEditingController _lengthController = TextEditingController();
  final TextEditingController _widthController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final VolumeCalculatorData calculatorData =
          Provider.of<VolumeCalculatorData>(context, listen: false);
      _lengthController.text =
          calculatorData.length == 0.0 ? '' : calculatorData.length.toString();
      _widthController.text =
          calculatorData.width == 0.0 ? '' : calculatorData.width.toString();
      _heightController.text =
          calculatorData.height == 0.0 ? '' : calculatorData.height.toString();
    });
  }

  @override
  void dispose() {
    _lengthController.dispose();
    _widthController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final NumberFormat numberFormatter = NumberFormat('#,##0.00');

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<VolumeCalculatorData>(
          builder: (BuildContext context, VolumeCalculatorData calculatorData,
              Widget? child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    'คำนวณหาปริมาตร',
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
                TextField(
                  controller: _lengthController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: 'ความยาว (เมตร)',
                    hintText: 'ป้อนความยาว',
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.linear_scale),
                  ),
                  onChanged: (String value) {
                    calculatorData.setLength(value);
                  },
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: _widthController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: 'ความกว้าง (เมตร)',
                    hintText: 'ป้อนความกว้าง',
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.linear_scale),
                  ),
                  onChanged: (String value) {
                    calculatorData.setWidth(value);
                  },
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: _heightController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: 'ความสูง (เมตร)',
                    hintText: 'ป้อนความสูง',
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.linear_scale),
                  ),
                  onChanged: (String value) {
                    calculatorData.setHeight(value);
                  },
                ),
                const SizedBox(height: 24.0),
                Card(
                  elevation: 4,
                  margin: EdgeInsets.zero,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          'ผลลัพธ์:',
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal),
                        ),
                        const Divider(height: 16, thickness: 1),
                        Text(
                          'ปริมาตร : ${numberFormatter.format(calculatorData.volume)} ลูกบาศก์เมตร',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}