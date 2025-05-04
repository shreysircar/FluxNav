/*
import 'package:flutter/material.dart';
import '../algorithms/dijkstra.dart';
import '../models/connection.dart';
import '../models/graph_instance.dart';

class ShortestPathScreen extends StatefulWidget {
  @override
  _ShortestPathScreenState createState() => _ShortestPathScreenState();
}

class _ShortestPathScreenState extends State<ShortestPathScreen> {
  final _graph = metroGraph;
  String? _sourceLine;
  String? _destinationLine;
  String? _startStation;
  String? _endStation;

  List<String> _sourceStations = [];
  List<String> _destinationStations = [];

  List<String> _shortestPath = [];
  List<String> _linesTaken = [];
  int? _totalDistance;
  int _interchanges = 0;

  final Map<String, Color> lineColors = {
    'Blue': Colors.blue,
    'Yellow': Colors.yellow.shade700,
    'Red': Colors.red,
    'Green': Colors.green,
    'Pink': Colors.pink,
    'Magenta': Colors.purple,
    'Orange': Colors.orange,
    'Violet': Colors.deepPurple,
    'Grey': Colors.grey,
    'Aqua': Colors.cyan,
  };

  void _onSourceLineChanged(String? line) {
    if (line == null) return;
    final stations = _graph.getStationsByLine(line);
    setState(() {
      _sourceLine = line;
      _sourceStations = stations.toSet().toList()..sort();
      _startStation = null;
    });
  }

  void _onDestinationLineChanged(String? line) {
    if (line == null) return;
    final stations = _graph.getStationsByLine(line);
    setState(() {
      _destinationLine = line;
      _destinationStations = stations.toSet().toList()..sort();
      _endStation = null;
    });
  }

  void _calculateShortestPath() {
    if (_startStation == null || _endStation == null) return;

    final result = dijkstra(_graph, _startStation!);
    final distances = result['distances'] as Map<String, int>;
    final previous = result['previous'] as Map<String, String?>;
    final path = getPath(previous, _startStation!, _endStation!);

    List<String> lines = [];
    List<String> lineTransitions = [];

    for (int i = 0; i < path.length - 1; i++) {
      final from = path[i];
      final to = path[i + 1];
      final connections = _graph.getConnections(from);
      if (connections != null) {
        final connection = connections.firstWhere(
              (conn) => conn.station == to,
          orElse: () => Connection('', 0, ''),
        );
        if (connection.line.isNotEmpty) {
          lines.add(connection.line);
          if (lineTransitions.isEmpty || lineTransitions.last != connection.line) {
            lineTransitions.add(connection.line);
          }
        }
      }
    }

    setState(() {
      _shortestPath = path;
      _linesTaken = lines;
      _totalDistance = distances[_endStation];
      _interchanges = lineTransitions.length - 1;
    });
  }

  Color _getLineColor(String lineName) {
    return lineColors[lineName] ?? Colors.black;
  }

  Widget _buildFormattedPath(List<String> path) {
    List<InlineSpan> spans = [];

    for (int i = 0; i < path.length; i++) {
      final station = path[i];
      String lineColor = '';

      if (i < path.length - 1) {
        final connections = _graph.getConnections(station);
        if (connections != null) {
          final conn = connections.firstWhere(
                (c) => c.station == path[i + 1],
            orElse: () => Connection('', 0, ''),
          );
          lineColor = conn.line;
        }
      }

      spans.add(
        WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Text(
              station,
              style: TextStyle(
                color: _getLineColor(lineColor),
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
        ),
      );

      if (i < path.length - 1) {
        spans.add(
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: Text(
                '→',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        );
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: RichText(text: TextSpan(children: spans)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Metro Navigator')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: _sourceLine,
              hint: Text("Select Source Line"),
              items: _graph.getAvailableLines().map((line) {
                return DropdownMenuItem(value: line, child: Text(line));
              }).toList(),
              onChanged: _onSourceLineChanged,
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _startStation,
              hint: Text("Select Source Station"),
              items: _sourceStations.map((station) {
                return DropdownMenuItem(value: station, child: Text(station));
              }).toList(),
              onChanged: (value) {
                setState(() => _startStation = value);
              },
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _destinationLine,
              hint: Text("Select Destination Line"),
              items: _graph.getAvailableLines().map((line) {
                return DropdownMenuItem(value: line, child: Text(line));
              }).toList(),
              onChanged: _onDestinationLineChanged,
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _endStation,
              hint: Text("Select Destination Station"),
              items: _destinationStations.map((station) {
                return DropdownMenuItem(value: station, child: Text(station));
              }).toList(),
              onChanged: (value) {
                setState(() => _endStation = value);
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateShortestPath,
              child: Text('Find Shortest Path'),
            ),
            SizedBox(height: 30),
            if (_shortestPath.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Shortest Route:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  _buildFormattedPath(_shortestPath),
                  SizedBox(height: 10),
                  Text(
                    'Total Distance: $_totalDistance units',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Interchanges: $_interchanges',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Lines Taken:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _linesTaken
                        .toSet()
                        .map((line) => Chip(
                      label: Text(
                        line,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      backgroundColor: _getLineColor(line),
                    ))
                        .toList(),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
*/import 'package:flutter/material.dart';
import '../algorithms/dijkstra.dart';
import '../models/connection.dart';
import '../models/graph_instance.dart';

class ShortestPathScreen extends StatefulWidget {
  @override
  _ShortestPathScreenState createState() => _ShortestPathScreenState();
}

class _ShortestPathScreenState extends State<ShortestPathScreen> {
  final _graph = metroGraph;
  String? _sourceLine;
  String? _destinationLine;
  String? _startStation;
  String? _endStation;

  List<String> _sourceStations = [];
  List<String> _destinationStations = [];

  List<String> _shortestPath = [];
  List<String> _linesTaken = [];
  int? _totalDistance;
  int _interchanges = 0;

  final Map<String, Color> lineColors = {
    'Blue': Colors.blue,
    'Yellow': Colors.yellow.shade700,
    'Red': Colors.red,
    'Green': Colors.green,
    'Pink': Colors.pink.shade200,
    'Magenta': Colors.pink.shade400,
    'Orange': Colors.deepOrange,
    'Violet': Colors.deepPurple,
    'Grey': Colors.grey,
    'Aqua': Colors.cyan,
  };

  void _onSourceLineChanged(String? line) {
    if (line == null) return;
    final stations = _graph.getStationsByLine(line);
    setState(() {
      _sourceLine = line;
      _sourceStations = stations.toSet().toList()..sort();
      _startStation = null;
    });
  }

  void _onDestinationLineChanged(String? line) {
    if (line == null) return;
    final stations = _graph.getStationsByLine(line);
    setState(() {
      _destinationLine = line;
      _destinationStations = stations.toSet().toList()..sort();
      _endStation = null;
    });
  }

  void _calculateShortestPath() {
    if (_startStation == null || _endStation == null) return;

    final result = dijkstra(_graph, _startStation!, prioritizeChanges: false);
    final distances = result['distances'] as Map<String, int>;
    final previous = result['previous'] as Map<String, String?>;
    final path = getPath(previous, _startStation!, _endStation!);

    List<String> lines = [];
    List<String> lineTransitions = [];

    for (int i = 0; i < path.length - 1; i++) {
      final from = path[i];
      final to = path[i + 1];
      final connections = _graph.getConnections(from);
      if (connections != null) {
        final connection = connections.firstWhere(
              (conn) => conn.station == to,
          orElse: () => Connection('', 0, ''),
        );
        if (connection.line.isNotEmpty) {
          lines.add(connection.line);
          if (lineTransitions.isEmpty || lineTransitions.last != connection.line) {
            lineTransitions.add(connection.line);
          }
        }
      }
    }

    setState(() {
      _shortestPath = path;
      _linesTaken = lines;
      _totalDistance = distances[_endStation];
      _interchanges = lineTransitions.length - 1;
    });
  }

  Color _getLineColor(String lineName) {
    return lineColors[lineName] ?? Colors.black;
  }

  Widget _buildFormattedPath(List<String> path) {
    List<InlineSpan> spans = [];

    for (int i = 0; i < path.length; i++) {
      final station = path[i];
      String lineColor = '';

      if (i < path.length - 1) {
        final connections = _graph.getConnections(station);
        if (connections != null) {
          final conn = connections.firstWhere(
                (c) => c.station == path[i + 1],
            orElse: () => Connection('', 0, ''),
          );
          lineColor = conn.line;
        }
      }

      spans.add(
        WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Text(
              station,
              style: TextStyle(
                color: _getLineColor(lineColor),
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
        ),
      );

      if (i < path.length - 1) {
        spans.add(
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: Text(
                '→',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        );
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: RichText(text: TextSpan(children: spans)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Metro Navigator')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: _sourceLine,
              hint: Text("Select Source Line"),
              items: _graph.getAvailableLines().map((line) {
                return DropdownMenuItem(value: line, child: Text(line));
              }).toList(),
              onChanged: _onSourceLineChanged,
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _startStation,
              hint: Text("Select Source Station"),
              items: _sourceStations.map((station) {
                return DropdownMenuItem(value: station, child: Text(station));
              }).toList(),
              onChanged: (value) {
                setState(() => _startStation = value);
              },
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _destinationLine,
              hint: Text("Select Destination Line"),
              items: _graph.getAvailableLines().map((line) {
                return DropdownMenuItem(value: line, child: Text(line));
              }).toList(),
              onChanged: _onDestinationLineChanged,
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _endStation,
              hint: Text("Select Destination Station"),
              items: _destinationStations.map((station) {
                return DropdownMenuItem(value: station, child: Text(station));
              }).toList(),
              onChanged: (value) {
                setState(() => _endStation = value);
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateShortestPath,
              child: Text('Find Shortest Path'),
            ),
            SizedBox(height: 30),
            if (_shortestPath.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Shortest Route:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  _buildFormattedPath(_shortestPath),
                  SizedBox(height: 10),
                  Text(
                    'Total Distance: $_totalDistance units',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Interchanges: $_interchanges',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Lines Taken:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _linesTaken
                        .toSet()
                        .map((line) => Chip(
                      label: Text(
                        line,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      backgroundColor: _getLineColor(line),
                    ))
                        .toList(),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
