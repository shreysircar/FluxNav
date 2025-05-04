# 🚇 FluxNav

A cross-platform **Flutter application** for navigating the **Delhi Metro** system using graph algorithms. Metro Navigator helps users find the **shortest routes**, **least interchange paths**, and **nearby stations** with the help of real-world metro data and Google Maps integration.

---

## 📱 Features

- 🔎 **Shortest Route Finder** using Dijkstra's algorithm
- 🔁 **Minimum Interchange Finder** using a modified graph search
- 📍 **Nearby Metro Stations** using Google Maps & Places API
- 🗺️ Visual and intuitive UI with Bottom Navigation
- 🎯 Built with scalable architecture using custom graph structures

---

## 🧠 Core Logic

- **Graph Representation**: Stations as nodes, connections as edges
- **Dijkstra’s Algorithm**: Optimized with PriorityQueue (Dart collections)
- **Custom Edge Metadata**: Stores distance and line color to handle interchanges
- **Dual Route Output**: Returns both shortest path by distance and by number of interchanges

---

## 🧰 Tech Stack

| Technology      | Usage                          |
|-----------------|---------------------------------|
| Flutter         | App UI & state management       |
| Dart            | Core logic & algorithms         |
| Google Maps API | Map visualization               |
| Places API      | Nearby station lookup           |
| DMRC Data       | Metro lines (Blue, Yellow, etc) |

---
