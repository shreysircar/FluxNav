import '../models/metro_graph.dart';

import '../models/graph_instance.dart';

void populateVioletLine() {
  final violetLineStations = [
    "Kashmere Gate",
    "Lal Qila",
    "Jama Masjid",
    "Delhi Gate",
    "ITO",
    "Mandi House",
    "Janpath",
    "Central Secretariat",
    "Khan Market",
    "Jawaharlal Nehru Stadium",
    "Jangpura",
    "Lajpat Nagar",
    "Moolchand",
    "Kailash Colony",
    "Nehru Place",
    "Kalkaji Mandir",
    "Govind Puri",
    "Harkesh Nagar Okhla",
    "Jasola Apollo",
    "Sarita Vihar",
    "Mohan Estate",
    "Tughlakabad",
    "Badarpur Border",
    "Sarai",
    "NHPC Chowk",
    "Mewala Maharajpur",
    "Sector 28",
    "Badkal Mor",
    "Old Faridabad",
    "Neelam Chowk Ajronda",
    "Bata Chowk",
    "Escorts Mujesar",
    "Sant Surdas Sihi",
    "Raja Nahar Singh",
  ];

  for (int i = 0; i < violetLineStations.length - 1; i++) {
    metroGraph.addEdge(violetLineStations[i], violetLineStations[i + 1], 10,'Violet');
  }
}
