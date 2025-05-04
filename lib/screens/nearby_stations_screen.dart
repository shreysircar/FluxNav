/*import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

class NearbyStationsScreen extends StatefulWidget {
  @override
  _NearbyStationsScreenState createState() => _NearbyStationsScreenState();
}

class _NearbyStationsScreenState extends State<NearbyStationsScreen> {
  Position? _currentPosition;
  Map<String, double> _nearbyStations = {};
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _fetchLocationAndStations();
  }

  Future<void> _fetchLocationAndStations() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Show message to enable location services
      setState(() {
        _loading = false;
      });
      return;
    }

    // Check for location permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Handle case when permission is denied
        setState(() {
          _loading = false;
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Handle the case when permission is denied forever
      setState(() {
        _loading = false;
      });
      return;
    }

    // Get current position
    try {
      final Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        _currentPosition = position;
        _loading = false;
      });

      // Dummy coordinates for stations (replace with real ones if available)
      final Map<String, Map<String, double>> stationCoordinates = {
        'Hauz Khas': {'lat': 28.5494, 'lng': 77.2073},
        'Botanical Garden': {'lat': 28.5676, 'lng': 77.3260},
        'Rajiv Chowk': {'lat': 28.6328, 'lng': 77.2197},
        // Add more stations with coordinates
      };

      Map<String, double> distances = {};
      for (var entry in stationCoordinates.entries) {
        double distance = Geolocator.distanceBetween(
          position.latitude,
          position.longitude,
          entry.value['lat']!,
          entry.value['lng']!,
        );
        distances[entry.key] = distance;
      }

      // Sort by distance and take top 5
      var sorted = Map.fromEntries(distances.entries.toList()
        ..sort((a, b) => a.value.compareTo(b.value)));

      setState(() {
        _nearbyStations = Map.fromEntries(sorted.entries.take(5));
      });
    } catch (e) {
      // Handle case when location fetch fails
      print("Error fetching location: $e");
      setState(() {
        _loading = false;
      });
    }
  }

  void _launchMaps(String stationName) async {
    final Uri url = Uri.parse(
        "https://www.google.com/maps/search/?api=1&query=$stationName+Metro+Station");

    // Use launch() instead of launchUrl and canLaunch() instead of canLaunchUrl
    if (await canLaunch(url.toString())) {
      await launch(url.toString());
    } else {
      // Handle case where the URL can't be launched
      print('Could not launch $url');
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Nearby Metro Stations")),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : _currentPosition == null
          ? Center(child: Text("Location not available"))
          : ListView.builder(
        itemCount: _nearbyStations.length,
        itemBuilder: (context, index) {
          String station = _nearbyStations.keys.elementAt(index);
          double distance = _nearbyStations[station]! / 1000.0;
          return ListTile(
            title: Text(station),
            subtitle: Text("${distance.toStringAsFixed(2)} km away"),
            trailing: Icon(Icons.directions),
            onTap: () => _launchMaps(station),
          );
        },
      ),
    );
  }
}
*/
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';

class NearbyStationsScreen extends StatefulWidget {
  @override
  _NearbyStationsScreenState createState() => _NearbyStationsScreenState();
}

class _NearbyStationsScreenState extends State<NearbyStationsScreen> {
  Position? _currentPosition;
  List<dynamic> _nearbyStations = [];
  bool _loading = true;

  String? _googlePlacesApiKey;

  @override
  void initState() {
    super.initState();
    _initializeApp(); // Combine loading .env and fetching location
  }

  Future<void> _initializeApp() async {
    await dotenv.load();
    _googlePlacesApiKey = dotenv.env['GOOGLE_PLACES_API_KEY'];
    print("✅ API Key loaded: $_googlePlacesApiKey");

    await _fetchLocationAndStations();
  }

  Future<void> _fetchLocationAndStations() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print("❌ Location services are disabled.");
      setState(() => _loading = false);
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print("❌ Location permission denied.");
        setState(() => _loading = false);
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print("❌ Location permission denied forever.");
      setState(() => _loading = false);
      return;
    }

    try {
      final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _currentPosition = position;
        _loading = false;
      });

      print("📍 Current location: ${position.latitude}, ${position.longitude}");

      if (_googlePlacesApiKey != null) {
        await _fetchNearbyStations(position.latitude, position.longitude);
      } else {
        print("❌ API Key is null");
      }
    } catch (e) {
      print("❌ Error fetching location: $e");
      setState(() => _loading = false);
    }
  }

  Future<void> _fetchNearbyStations(double latitude, double longitude) async {
    String baseUrl =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$latitude,$longitude&radius=5000';

    String primaryUrl = '$baseUrl&type=subway_station&key=$_googlePlacesApiKey';
    String fallbackUrl = '$baseUrl&keyword=metro+station&key=$_googlePlacesApiKey';

    Future<void> tryFetch(String url, {bool isFallback = false}) async {
      print("🌐 Fetching stations from: $url");

      final response = await http.get(Uri.parse(url));
      print("📦 Response Status: ${response.statusCode}");
      print("📦 Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = data['results'];

        if (results != null && results.isNotEmpty) {
          print("✅ Found ${results.length} nearby stations.");
          setState(() {
            _nearbyStations = results;
          });
        } else if (!isFallback) {
          print("⚠️ No stations found with primary query. Trying fallback...");
          await tryFetch(fallbackUrl, isFallback: true);
        } else {
          print("🚫 Still no stations found after fallback.");
        }
      } else {
        print('❌ API Error: ${response.statusCode}');
      }
    }

    await tryFetch(primaryUrl);
  }


  void _launchMaps(String stationName) async {
    final Uri url = Uri.parse(
        "https://www.google.com/maps/search/?api=1&query=$stationName+Metro+Station");

    if (await canLaunch(url.toString())) {
      await launch(url.toString());
    } else {
      print('❌ Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Nearby Metro Stations")),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : _currentPosition == null
          ? Center(child: Text("📍 Location not available"))
          : _nearbyStations.isEmpty
          ? Center(child: Text("🚫 No nearby stations found"))
          : ListView.builder(
        itemCount: _nearbyStations.length,
        itemBuilder: (context, index) {
          final station = _nearbyStations[index];
          final stationName = station['name'];
          final distance = station['vicinity'];
          return ListTile(
            title: Text(stationName),
            subtitle: Text(distance ?? "Unknown"),
            trailing: Icon(Icons.directions),
            onTap: () => _launchMaps(stationName),
          );
        },
      ),
    );
  }
}
