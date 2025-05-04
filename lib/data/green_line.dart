
import '../models/graph_instance.dart';


void populateGreenLine() {
  final greenLineStations = [
    "Brigadier Hoshiar Singh",
    "Bahadurgarh City",
    "Pandit Shree Ram Sharma",
    "Tikri Border",
    "Tikri Kalan",
    "Ghevra Metro Station",
    "Mundka Industrial Area",
    "Mundka",
    "Rajdhani Park",
    "Nangloi Railway Station",
    "Nangloi",
    "Surajmal Stadium",
    "Udyog Nagar",
    "Peera Garhi",
    "Paschim Vihar West",
    "Paschim Vihar East",
    "Madi Pur",
    "Shivaji Park",
    "Punjabi Bagh",
    "Ashok Park Main",
    "Inderlok",
  ];

  for (int i = 0; i < greenLineStations.length - 1; i++) {
    metroGraph.addEdge(greenLineStations[i], greenLineStations[i + 1], 10,'Green');
  }
}
