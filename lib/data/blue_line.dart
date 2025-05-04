import '../models/metro_graph.dart';

import '../models/graph_instance.dart';

void populateBlueLine() {
  final blueLineStations = [
    "   Dwarka Sec-21 ",
    " Dwarka Sec-8 ",
    "Dwarka Sec-9 ",
    "Dwarka Sec-10 ",
    "   Dwarka Sec-11 ",
    "Dwarka Sec-12 ",
    "Dwarka Sec-13 ",
    "    Dwarka Sec-14 ",
    " Dwarka ",
    " Dwarka Mor ",
    "Nawada ",
    " Uttam Nagar West ",
    " Uttam Nagar East",
    " Janakpuri West",
    " Janakpuri East ",
    " Tilak Nagar",
    " Subhash Nagar",
    " Tagore Garden",
    " Rajouri Garden ",
    " Ramesh Nagar",
    " Moti Nagar",
    " Kirti Nagar",
    "Shadipur",
    " Patel Nagar",
    "Rajendra Place ",
    "Karol Bagh",
    "Jhandewalan ",
    "Ramakrishna Ashram Marg",
    "Rajiv Chowk",
    "Barakhamba Road",
    "Mandi House",
    "Pragati Maidan ",
    "Indraprastha ",
    "Yamuna Bank ",
    "Akshardham ",
    "Mayur Vihar-I ",
    "Mayur Vihar Ext ",
    "New Ashok Nagar",
    "Noida Sec-15",
    "Noida Sec-16 ",
    "Noida Sec-18",
    "Botanical Garden ",
    " Golf Course ",
    " Noida City Centre",
  ];

  for (int i = 0; i < blueLineStations.length - 1; i++) {
    metroGraph.addEdge(blueLineStations[i], blueLineStations[i + 1], 10,'Blue');
  }
}
