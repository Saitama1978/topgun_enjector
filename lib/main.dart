import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Color(0xFF101010),
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  runApp(const TopgunInjectorApp());
}

class TopgunInjectorApp extends StatelessWidget {
  const TopgunInjectorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Topgun Injector',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0D0D0D),
        colorScheme: const ColorScheme.dark(
          primary: Colors.deepOrangeAccent,
          surface: Color(0xFF181818),
          onSurface: Colors.white,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF121212),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        cardTheme: CardTheme(
          color: const Color(0xFF1A1A1A),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: Color(0xFF2A2A2A)),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF1E1E1E),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFF333333)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.deepOrangeAccent),
          ),
          hintStyle: const TextStyle(color: Colors.grey),
        ),
      ),
      home: const TopgunHomeScreen(),
    );
  }
}

class TopgunHomeScreen extends StatefulWidget {
  const TopgunHomeScreen({super.key});

  @override
  State<TopgunHomeScreen> createState() => _TopgunHomeScreenState();
}

class _TopgunHomeScreenState extends State<TopgunHomeScreen> {
  final TextEditingController _payloadController = TextEditingController();
  final TextEditingController _proxyController = TextEditingController();
  bool _isConnected = false;

  void _toggleConnection() {
    setState(() {
      _isConnected = !_isConnected;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: _isConnected ? Colors.green[900] : Colors.red[900],
        content: Text(
          _isConnected ? 'Topgun Engine Connected' : 'Topgun Engine Stopped',
          style: const TextStyle(color: Colors.white),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.flight_takeoff, color: Colors.deepOrangeAccent),
            SizedBox(width: 10),
            Text(
              'TOPGUN INJECTOR',
              style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAlignment.stretch,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.code, color: Colors.deepOrangeAccent, size: 20),
                          SizedBox(width: 8),
                          Text(
                            'HTTP Payload Config',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.deepOrangeAccent,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _payloadController,
                        maxLines: 3,
                        style: const TextStyle(fontFamily: 'monospace', fontSize: 13),
                        decoration: const InputDecoration(
                          hintText: 'CONNECT [host_port] [protocol]\r\nHost: bug.com\r\n...',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              TextField(
                controller: _proxyController,
                decoration: const InputDecoration(
                  labelText: 'Remote Proxy / SSH Host',
                  prefixIcon: Icon(Icons.dns, color: Colors.deepOrangeAccent),
                ),
              ),
              const Spacer(),

              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF181818),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: _isConnected ? Colors.green : Colors.redAccent,
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      _isConnected ? Icons.check_circle : Icons.error,
                      color: _isConnected ? Colors.green : Colors.redAccent,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      _isConnected ? 'SERVICE ACTIVE' : 'SERVICE STOPPED',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: _isConnected ? Colors.green : Colors.redAccent,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              SizedBox(
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isConnected ? Colors.red[700] : Colors.deepOrangeAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26),
                    ),
                  ),
                  onPressed: _toggleConnection,
                  child: Text(
                    _isConnected ? 'STOP TUNNEL' : 'START TUNNEL',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              const Center(
                child: Text(
                  'Developer: Renante Fullo',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
