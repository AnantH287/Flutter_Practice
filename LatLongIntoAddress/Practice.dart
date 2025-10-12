import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:geocoding/geocoding.dart';

class Practice extends StatefulWidget {
  const Practice({super.key});

  @override
  State<Practice> createState() => _PracticeState();
}

class _PracticeState extends State<Practice> {


  final position = GeoPoint(latitude: 8.9782764, longitude: 77.4185584);



  Future<String> _latAndLongToAddress (GeoPoint pos)async{

    try{
      final placemark = await placemarkFromCoordinates(pos.latitude, pos.longitude);

      if(placemark.isNotEmpty){
        final place = placemark.first;
        print("Placee ${place}");
        return "${place.locality}, ${place.street}";
      } else {
        return "Error";
      }
    }
    catch(e){
      return "Error is ${e}";
    }
  }

  final List<Map<String, dynamic>> positions = [
    {"name": "Point 1", "position": GeoPoint(latitude: 8.9825, longitude: 77.4221)},
    {"name": "Point 2", "position": GeoPoint(latitude: 8.9731, longitude: 77.4150)},
    {"name": "Point 3", "position": GeoPoint(latitude: 8.9768, longitude: 77.4239)},
    {"name": "Point 4", "position": GeoPoint(latitude: 8.9812, longitude: 77.4183)},
    {"name": "Point 5", "position": GeoPoint(latitude: 8.9705, longitude: 77.4207)},
    {"name": "Point 6", "position": GeoPoint(latitude: 8.9840, longitude: 77.4162)},
    {"name": "Point 7", "position": GeoPoint(latitude: 8.9753, longitude: 77.4251)},
    {"name": "Point 8", "position": GeoPoint(latitude: 8.9798, longitude: 77.4125)},
    {"name": "Point 9", "position": GeoPoint(latitude: 8.9727, longitude: 77.4172)},
    {"name": "Point 10", "position": GeoPoint(latitude: 8.9855, longitude: 77.4218)},
  ];
  Future<List<Map<String,String>>> _latAndLongToAddress1(List<Map<String, dynamic>> positions) async {
    List<Map<String, String>> addresses = [];

    for (var raw in positions) {
      try {
        final geo = raw["position"] as GeoPoint;
        final placemarks = await placemarkFromCoordinates(geo.latitude, geo.longitude);

        if (placemarks.isNotEmpty) {
          final place = placemarks.first;
          addresses.add({
            "name": raw["name"] as String? ?? "",
            "position": "${place.locality ?? ""}, ${place.street ?? ""}",
          });
        } else {
          addresses.add({
            "name": raw["name"] as String? ?? "",
            "position": "Unknown location",
          });
        }
      } catch (e) {
        addresses.add({
          "name": raw["name"] as String? ?? "",
          "position": "Error: $e",
        });
      }
    }

    return addresses;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("practice jjj"),
      ),
      body: Center(
        child: Container(
          width: 300,
          height: 200,
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black45,
                    blurRadius: 10
                )
              ]
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: FutureBuilder<List<Map<String,String>>>(
                  future: _latAndLongToAddress1(positions),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text("Error: ${snapshot.error}"));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text("No addresses found"));
                    } else {
                      final addresses = snapshot.data!;
                      return ListView.builder(
                        itemCount: addresses.length,
                        itemBuilder: (context, index) {
                          final address = addresses[index];
                          return ListTile(
                            title: Text(address["name"] ?? ""),
                            subtitle: Text(address["position"] ?? ""),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}
