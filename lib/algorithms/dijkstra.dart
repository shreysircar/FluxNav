/*
import 'package:collection/collection.dart';
import '../models/metro_graph.dart';

// Returns both distance and previous station maps
Map<String, dynamic> dijkstra(MetroGraph graph, String start) {
  final Map<String, int> distances = {};
  final Map<String, String?> previous = {};
  final priorityQueue = PriorityQueue<MapEntry<String, int>>(
        (a, b) => a.value.compareTo(b.value),
  );

  for (var station in graph.getStations()) {
    distances[station] = double.maxFinite.toInt();
    previous[station] = null;
  }

  distances[start] = 0;
  priorityQueue.add(MapEntry(start, 0));

  while (priorityQueue.isNotEmpty) {
    final current = priorityQueue.removeFirst().key;
    final currentDistance = distances[current]!;

    final connections = graph.getConnections(current);
    if (connections == null) continue;

    for (var connection in connections) {
      final neighbor = connection.station;
      final newDist = currentDistance + connection.distance;

      if (newDist < distances[neighbor]!) {
        distances[neighbor] = newDist;
        previous[neighbor] = current;
        priorityQueue.add(MapEntry(neighbor, newDist));
      }
    }
  }

  return {
    'distances': distances,
    'previous': previous,
  };
}

// Reconstructs shortest path from 'previous' map
List<String> getPath(Map<String, String?> previous, String start, String end) {
  List<String> path = [];
  String? current = end;

  while (current != null && current != start) {
    path.insert(0, current);
    current = previous[current];
  }

  if (current == start) {
    path.insert(0, start);
  }

  return path;
}
*/
import 'package:collection/collection.dart';
import '../models/metro_graph.dart';

Map<String, dynamic> dijkstra(MetroGraph graph, String start, {bool prioritizeChanges = false}) {
  final Map<String, int> distances = {};
  final Map<String, String?> previous = {};
  final Map<String, int> lineChanges = {};
  final Map<String, String?> currentLine = {}; // To track line used to reach each station

  final priorityQueue = PriorityQueue<MapEntry<String, int>>(
        (a, b) => a.value.compareTo(b.value),
  );

  for (var station in graph.getStations()) {
    distances[station] = double.maxFinite.toInt();
    previous[station] = null;
    lineChanges[station] = 0;
    currentLine[station] = null;
  }

  distances[start] = 0;
  priorityQueue.add(MapEntry(start, 0));

  while (priorityQueue.isNotEmpty) {
    final current = priorityQueue.removeFirst().key;
    final currentDistance = distances[current]!;
    final currentChanges = lineChanges[current]!;
    final usedLine = currentLine[current];

    final connections = graph.getConnections(current);
    if (connections == null) continue;

    for (var connection in connections) {
      final neighbor = connection.station;
      final line = connection.line;

      final newDist = currentDistance + connection.distance;
      final newChanges = usedLine == null || usedLine == line ? currentChanges : currentChanges + 1;

      if (prioritizeChanges) {
        if (newDist < distances[neighbor]! ||
            (newDist == distances[neighbor]! && newChanges < lineChanges[neighbor]!)) {
          distances[neighbor] = newDist;
          previous[neighbor] = current;
          lineChanges[neighbor] = newChanges;
          currentLine[neighbor] = line;
          priorityQueue.add(MapEntry(neighbor, newDist));
        }
      } else {
        if (newDist < distances[neighbor]!) {
          distances[neighbor] = newDist;
          previous[neighbor] = current;
          currentLine[neighbor] = line;
          priorityQueue.add(MapEntry(neighbor, newDist));
        }
      }
    }
  }

  return {
    'distances': distances,
    'previous': previous,
    'lineChanges': lineChanges,
  };
}

List<String> getPath(Map<String, String?> previous, String start, String end) {
  List<String> path = [];
  String? current = end;

  while (current != null && current != start) {
    path.insert(0, current);
    current = previous[current];
  }

  if (current == start) {
    path.insert(0, start);
  }

  return path;
}
