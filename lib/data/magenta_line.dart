import '../models/metro_graph.dart';

import '../models/graph_instance.dart';
void populateMagentaLine() {
  final magentaLineStations = [
    "Shivaji Stadium",
    "Ramakrishna Ashram Marg",
     "Pitampura",
    "Peera Garhi",
    "Janakpuri West",
    "Dabri Mor",
    "Dashrath Puri",
    "Palam",
    "Sadar Bazar Cantonment",
    "Terminal 1-IGI Airport",
    "Shankar Vihar",
    "Vasant Vihar",
    "Munirka",
    "RK Puram",
    "IIT Delhi",
    "Hauz Khas",
    "Panchsheel Park",
    "Chirag Delhi",
    "Greater Kailash",
    "Nehru Enclave",
    "Kalkaji Mandir",
    "Okhla NSIC",
    "Sukhdev Vihar",
    "Jamia Millia Islamia",
    "Okhla Vihar",
    "Jasola Vihar Shaheen Bagh",
    "Kalindi Kunj",
    "Okhla Bird Sanctuary",
    "Botanical Garden",
  ];

  for (int i = 0; i < magentaLineStations.length - 1; i++) {
    metroGraph.addEdge(magentaLineStations[i], magentaLineStations[i + 1], 10,'Magenta');
  }
}
