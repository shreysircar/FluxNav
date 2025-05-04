/*import 'package:flutter/material.dart';
import '../screens/signin_screen.dart'; // Import the SignInScreen
import '../screens/shortest_path_screen.dart';
import 'data/blue_line.dart';
import 'data/green_line.dart';
import 'data/magenta_line.dart';
import 'data/orange_line.dart';
import 'data/red_line.dart';
import 'data/violet_line.dart';
import 'data/yellow_line.dart';
import 'models/graph_instance.dart';
import '../screens/nearby_stations_screen.dart'; // Import NearbyStationsScreen

void main() {
  populateBlueLine();
  populateGreenLine();
  populateMagentaLine();
  populateOrangeLine();
  populateRedLine();
  populateVioletLine();
  populateYellowLine();

  metroGraph.addCommonStationConnections();

  runApp(MyApp());
}


// Custom theme colors
final ThemeData fluxNavTheme = ThemeData(
  primaryColor: const Color(0xFF1565C0), // Deep Blue
  scaffoldBackgroundColor: const Color(0xFFF1F6FB),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF1565C0),
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF1565C0),
    foregroundColor: Colors.white,
    elevation: 2,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: Color(0xFF1565C0),
    unselectedItemColor: Colors.grey,
    selectedIconTheme: IconThemeData(size: 28),
    unselectedIconTheme: IconThemeData(size: 24),
  ),
  fontFamily: 'Roboto',
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FluxNav',
      debugShowCheckedModeBanner: false,
      theme: fluxNavTheme,
      initialRoute: '/', // SplashScreen route
      routes: {
        '/': (context) => SplashScreen(), // SplashScreen
        '/signin': (context) => SignInScreen(), // SignIn Screen
        '/main': (context) => FluxNavScaffold(), // Main screen after sign-in
      },
    );
  }
}

// Main scaffold with navigation
class FluxNavScaffold extends StatefulWidget {
  @override
  State<FluxNavScaffold> createState() => _FluxNavScaffoldState();
}

class _FluxNavScaffoldState extends State<FluxNavScaffold> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    PlaceholderWidget(title: "Home"),
    NearbyStationsScreen(), // Replaced the "Settings" screen with NearbyStationsScreen
    ShortestPathScreen(), // Replace old Dashboard
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.location_on), label: 'Nearby Stations'), // Updated label
          BottomNavigationBarItem(icon: Icon(Icons.navigation_sharp), label: 'Shortest Path'),
        ],
      ),
    );
  }
}

// Reusable placeholder widget for pages like Home and Settings
class PlaceholderWidget extends StatelessWidget {
  final String title;

  const PlaceholderWidget({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text(title, style: TextStyle(fontSize: 22))),
    );
  }
}

// Splash Screen
class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Mimicking a delay before going to the SignIn screen
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/signin'); // Go to SignIn screen after splash
    });

    return Scaffold(
      backgroundColor: Color(0xFF1565C0),
      body: Center(
        child: Text(
          'FluxNav',
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
*/
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import '../screens/signin_screen.dart'; // Import the SignInScreen
import '../screens/shortest_path_screen.dart';
import 'data/blue_line.dart';
import 'data/green_line.dart';
import 'data/magenta_line.dart';
import 'data/orange_line.dart';
import 'data/red_line.dart';
import 'data/violet_line.dart';
import 'data/yellow_line.dart';
import 'models/graph_instance.dart';
import '../screens/nearby_stations_screen.dart'; // Import NearbyStationsScreen


void main() async {
  // Ensure the .env file is loaded before running the app
  await dotenv.load();  // Load the .env file here

  // Print the API key to check if it's loaded correctly
  print('Loaded API Key: ${dotenv.env['GOOGLE_PLACES_API_KEY']}');

  populateBlueLine();
  populateGreenLine();
  populateMagentaLine();
  populateOrangeLine();
  populateRedLine();
  populateVioletLine();
  populateYellowLine();

  metroGraph.addCommonStationConnections();

  runApp(MyApp());
}

// Custom theme colors
final ThemeData fluxNavTheme = ThemeData(
  primaryColor: const Color(0xFF1565C0), // Deep Blue
  scaffoldBackgroundColor: const Color(0xFFF1F6FB),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF1565C0),
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF1565C0),
    foregroundColor: Colors.white,
    elevation: 2,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: Color(0xFF1565C0),
    unselectedItemColor: Colors.grey,
    selectedIconTheme: IconThemeData(size: 28),
    unselectedIconTheme: IconThemeData(size: 24),
  ),
  fontFamily: 'Roboto',
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FluxNav',
      debugShowCheckedModeBanner: false,
      theme: fluxNavTheme,
      initialRoute: '/', // SplashScreen route
      routes: {
        '/': (context) => SplashScreen(), // SplashScreen
        '/signin': (context) => SignInScreen(), // SignIn Screen
        '/main': (context) => FluxNavScaffold(), // Main screen after sign-in
      },
    );
  }
}

// Main scaffold with navigation
class FluxNavScaffold extends StatefulWidget {
  @override
  State<FluxNavScaffold> createState() => _FluxNavScaffoldState();
}

class _FluxNavScaffoldState extends State<FluxNavScaffold> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(), // Updated Home Screen
    NearbyStationsScreen(), // Replaced the "Settings" screen with NearbyStationsScreen
    ShortestPathScreen(), // Replace old Dashboard
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.location_on), label: 'Nearby Stations'),
          BottomNavigationBarItem(icon: Icon(Icons.navigation_sharp), label: 'Shortest Path'),
        ],
      ),
    );
  }
}

// Home Screen - Main content
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome text
            Text(
              'Welcome to FluxNav!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1565C0),
              ),
            ),
            SizedBox(height: 20),

            // Detailed information about the app
            Text(
              'FluxNav is an advanced metro navigation app designed to help you navigate through urban metro systems seamlessly. With real-time information, the app offers optimized pathfinding features using algorithms like Dijkstra, allowing users to find the shortest and most efficient routes between stations. You can also explore nearby stations, check fare estimates, and more!',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 40),

            // Metro-related images (example: images of metro trains, maps, or stations)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/metro_train.jpg',
                  width: 170, // Adjust size as needed
                  height: 170,
                ),
                SizedBox(width: 20),
                Image.asset(
                  'assets/metro_map.jpeg',
                  width: 170,
                  height: 170,
                ),
              ],
            ),
            SizedBox(height: 40),

            // Additional app features or images (e.g., icons for each metro line or stations)
          ],
        ),
      ),
    );
  }
}

// Reusable placeholder widget for pages like Home and Settings
class PlaceholderWidget extends StatelessWidget {
  final String title;

  const PlaceholderWidget({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text(title, style: TextStyle(fontSize: 22))),
    );
  }
}

// Splash Screen
class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Mimicking a delay before going to the SignIn screen
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/signin'); // Go to SignIn screen after splash
    });

    return Scaffold(
      backgroundColor: Color(0xFF1565C0),
      body: Center(
        child: Text(
          'FluxNav',
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
