/*
import 'connection.dart';

class MetroGraph {
  final Map<String, List<Connection>> _adjacencyList = {};

  // Add an edge between two stations with a given distance and line
  void addEdge(String from, String to, int distance, String line) {
    from = from.trim();
    to = to.trim();
    _adjacencyList.putIfAbsent(from, () => []);
    _adjacencyList.putIfAbsent(to, () => []);
    _adjacencyList[from]!.add(Connection(to, distance, line));
    _adjacencyList[to]!.add(Connection(from, distance, line)); // undirected
  }

  // Get all connections for a station
  List<Connection>? getConnections(String station) => _adjacencyList[station.trim()];

  // Get all stations (keys of the adjacency list)
  List<String> getStations() => _adjacencyList.keys.toList();

  // Get stations associated with a specific line
  List<String> getStationsByLine(String line) {
    List<String> stationsForLine = [];
    _adjacencyList.forEach((station, connections) {
      for (var connection in connections) {
        if (connection.line == line) {
          stationsForLine.add(station);
          break; // Add station only once
        }
      }
    });
    return stationsForLine;
  }

  // Get all available lines in the graph
  List<String> getAvailableLines() {
    Set<String> lines = {};
    _adjacencyList.forEach((station, connections) {
      for (var connection in connections) {
        lines.add(connection.line);
      }
    });
    return lines.toList();
  }

  // Add edges for common stations (interchange points) between lines
  void addCommonStationConnections() {
    const commonStations = {
      'Hauz Khas': ['Yellow', 'Magenta'],
      'Kalkaji Mandir': ['Yellow', 'Magenta'],
      'Botanical Garden': ['Blue', 'Magenta', 'Yellow'],
    };

    for (var station in commonStations.keys) {
      final lines = commonStations[station]!;
      for (int i = 0; i < lines.length; i++) {
        for (int j = i + 1; j < lines.length; j++) {
          // Connect same station across lines with a low cost to simulate interchange
          addEdge(station, station, 1, '${lines[i]}-${lines[j]}');
        }
      }
    }
  }
}
*/
import 'connection.dart';

class MetroGraph {
  final Map<String, List<Connection>> _adjacencyList = {};

  // Add an edge between two stations with a given distance and line
  void addEdge(String from, String to, int distance, String line) {
    from = from.trim();
    to = to.trim();
    _adjacencyList.putIfAbsent(from, () => []);
    _adjacencyList.putIfAbsent(to, () => []);
    _adjacencyList[from]!.add(Connection(to, distance, line));
    _adjacencyList[to]!.add(Connection(from, distance, line)); // undirected
  }

  // Get all connections for a station
  List<Connection>? getConnections(String station) => _adjacencyList[station.trim()];

  // Get all stations (keys of the adjacency list)
  List<String> getStations() => _adjacencyList.keys.toList();

  // Get stations associated with a specific line
  List<String> getStationsByLine(String line) {
    List<String> stationsForLine = [];
    _adjacencyList.forEach((station, connections) {
      for (var connection in connections) {
        if (connection.line == line) {
          stationsForLine.add(station);
          break; // Add station only once
        }
      }
    });
    return stationsForLine;
  }

  // Get all available lines in the graph
  List<String> getAvailableLines() {
    Set<String> lines = {};
    _adjacencyList.forEach((station, connections) {
      for (var connection in connections) {
        lines.add(connection.line);
      }
    });
    return lines.toList();
  }

  // Add edges for common stations (interchange points) between lines
  void addCommonStationConnections() {
    const commonStations = {
      'Hauz Khas': ['Yellow', 'Magenta'],
      'Kalkaji Mandir': ['Magenta','Violet'],
      'Botanical Garden': ['Blue', 'Magenta'],
      'Mandi House': ['Blue','Violet'],
      'Rajiv Chowk': ['Blue','Yellow'],
      'Inderlok': ['Blue','Red'],
      'Janakpuri West':['Blue','Magenta'],
      'Central Secretariat':['Yellow','Violet'],
      'Dwarka Sec-21':['Blue','Orange'],
      'New Delhi':['Yellow','Orange'],
      'Peera Garhi':['Green','Magenta'],
      'Pitampura':['Red','Magenta'],
      'Ramakrishna Ashram Marg':['Blue','Magenta'],
      "Shivaji Stadium":['Orange','Magenta']

    };

    for (var station in commonStations.keys) {
      final lines = commonStations[station]!;
      for (int i = 0; i < lines.length; i++) {
        for (int j = i + 1; j < lines.length; j++) {
          // Connect same station across lines with a low cost to simulate interchange
          addEdge(station, station, 1, '${lines[i]}-${lines[j]}');
        }
      }
    }
  }

  // Get all lines that pass through a given station
  Set<String> getLinesOfStation(String station) {
    final connections = getConnections(station) ?? [];
    return connections.map((c) => c.line).toSet();
  }

  // Get the line used between two connected stations
  String? getLineBetweenStations(String from, String to) {
    final connections = getConnections(from);
    if (connections == null) return null;
    for (final conn in connections) {
      if (conn.station == to) {
        return conn.line;
      }
    }
    return null;
  }
}
