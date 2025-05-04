import '../models/metro_graph.dart';

import '../models/graph_instance.dart';

void populateOrangeLine() {
  final orangeLineStations = [
    "New Delhi",
    "Shivaji Stadium",
    "Dhaula Kuan",
    "Delhi Aerocity",
    "Airport",
    "Dwarka Sec-21",
  ];

  for (int i = 0; i < orangeLineStations.length - 1; i++) {
    metroGraph.addEdge(orangeLineStations[i], orangeLineStations[i + 1], 10,'Orange');
  }
}
