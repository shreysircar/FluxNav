import '../models/metro_graph.dart';

import '../models/graph_instance.dart';

void populateRedLine() {
  final redLineStations = [
    "Rithala",
    "Rohini West",
    "Rohini East",
    "Pitampura",
    "Kohat Enclave",
    "Netaji Subhash Place",
    "Keshav Puram",
    "Kanhaiya Nagar",
    "Inder Lok",
    "Shastri Nagar",
    "Pratap Nagar",
    "Pul Bangash",
    "Tis Hazari",
    "Kashmere Gate",
    "Shastri Park",
    "Seelampur",
    "Welcome",
    "Shahdara",
    "Mansarovar Park",
    "Jhilmil",
    "Dilshad Garden",
    "Shahid Nagar",
    "Raj Bagh",
    "Rajendra Nagar",
    "Shyam Park",
    "Mohannagar",
    "Arthala",
    "Hindon River",
    "Shaheed Sthal",
  ];

  for (int i = 0; i < redLineStations.length - 1; i++) {
    metroGraph.addEdge(redLineStations[i], redLineStations[i + 1], 10,'Red');
  }
}
