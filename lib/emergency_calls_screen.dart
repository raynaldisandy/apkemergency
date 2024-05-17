import 'package:flutter/material.dart';
import 'Crime.dart';
import 'Fire.dart';
import 'Earthquake.dart';
import 'Accident.dart';
import 'UGD.dart';
import "Flood.dart";
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';


class EmergencyCallsScreen extends StatefulWidget {
  const EmergencyCallsScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _EmergencyCallsScreenState createState() => _EmergencyCallsScreenState();
}

class _EmergencyCallsScreenState extends State<EmergencyCallsScreen> {
  MapController mapController = MapController();
  Position? currentPosition;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    Position position = Position(
      latitude: -6.2088, // Koordinat latitude Jakarta
      longitude: 106.8456, // Koordinat longitude Jakarta
      timestamp: DateTime.now(),
      accuracy: 0,
      altitude: 0,
      heading: 0,
      headingAccuracy: 0,
      speed: 0,
      speedAccuracy: 0,
      altitudeAccuracy: 0,
    );

    setState(() {
      currentPosition = position;
    });
  }

  final List<String> emergencyTypesList = [
    'CRIME',
    'FIRE',
    'ACCIDENT',
    'EARTHQUAKE',
    'FLOOD',
    'UGD',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'Emergency Calls',
          style: TextStyle(
            color: Color.fromARGB(255, 255, 0, 0),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(193, 241, 96, 96),
                Color.fromARGB(179, 255, 255, 255)
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
              children: [
                EmergencyTypesGrid(emergencyTypesList),
                const SizedBox(height: 5),
                const LocationRow(),
                // Add an image at the bottom
                Container(
                  height: 300,
                  child: FlutterMap(
                    mapController: mapController,
                    options: MapOptions(
                      center: LatLng(
                        currentPosition?.latitude ?? 0,
                        currentPosition?.longitude ?? 0,
                      ),
                      zoom: 13.0,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.example.app',
                      ),
                      MarkerLayer(
                        markers: [
                          Marker(
                            point: LatLng(
                              currentPosition?.latitude ?? 0,
                              currentPosition?.longitude ?? 0,
                            ),
                            width: 80,
                            height: 80,
                            child: const Icon(
                              Icons.location_on,
                              color: Colors.red,
                              size: 40.0,
                            ),
                          ),
                        ],
                      ),
                      CircleLayer(
                        circles: [
                          CircleMarker(
                            point: LatLng(
                              currentPosition?.latitude ?? 0,
                              currentPosition?.longitude ?? 0,
                            ),
                            radius: 1000,
                            useRadiusInMeter: true,
                            color: Colors.red.withOpacity(0.3),
                            borderColor: Colors.black,
                            borderStrokeWidth: 2,
                          ),
                        ],
                      ),
                      const RichAttributionWidget(
                        attributions: [
                          TextSourceAttribution(
                            'OpenStreetMap contributors'
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: MediaQuery.of(context).viewInsets.bottom,
      ),
    );
  }
}

class EmergencyTypesGrid extends StatelessWidget {
  final List<String> emergencyTypesList;

  const EmergencyTypesGrid(this.emergencyTypesList, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.count(
        shrinkWrap: true,
        crossAxisCount: 3,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: emergencyTypesList.map((emergencyType) {
          return InkWell(
            onTap: () {
              // Navigate to the specific emergency page based on the emergencyType
              switch (emergencyType) {
                case 'CRIME':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CrimePage()),
                  );
                  break;
                case 'FIRE':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const FirePage()),
                  );
                  break;
                case 'ACCIDENT':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AccidentPage()),
                  );
                  break;
                case 'EARTHQUAKE':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const EarthquakePage()),
                  );
                  break;
                case 'FLOOD':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const FloodPage()),
                  );
                  break;
                case 'UGD':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const UgdPage()),
                  );
                  break;
                default:
                  break;
              }
            },
            child: emergencyTypeButton(context, emergencyType),
          );
        }).toList(),
      ),
    );
  }

  Widget emergencyTypeButton(BuildContext context, String emergencyType) {
    final iconMap = {
    'CRIME': 'assets/icons/weapon.png',
    'FIRE': 'assets/icons/fire.png',
    'ACCIDENT': 'assets/icons/accident.png',
    'EARTHQUAKE': 'assets/icons/earthquake.png',
    'FLOOD': 'assets/icons/flood.png',
    'UGD': 'assets/icons/risks.png',
  };

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 25,
                child: Image.asset(
                  iconMap[emergencyType]!,
                  color: emergencyType == 'FIRE' ? Colors.black : Colors.black,
                  width: 32,
                  height: 32,
                  // size: 32,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 5),
        Text(
          emergencyType,
          style: TextStyle(
            color: emergencyType == 'FIRE' ? Colors.black : Colors.black,
          ),
        ),
      ],
    );
  }
}

class LocationRow extends StatelessWidget {
  const LocationRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Row(
            children: [
              Icon(Icons.location_on, color: Colors.red),
              SizedBox(width: 8),
              Text(
                'Where is the emergency?',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {},
              child: const Row(
                children: [
                  Text(
                    'Select Location',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 13),
                  )
                  ,
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}