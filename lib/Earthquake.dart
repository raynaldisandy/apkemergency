import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';

class EarthquakePage extends StatefulWidget {
  const EarthquakePage({super.key});

  @override
  State<EarthquakePage> createState() => _EarthquakePageState();
}

class _EarthquakePageState extends State<EarthquakePage> {
  bool isEmergency = false;

  void toggleSOS() {
    setState(() {
      isEmergency = !isEmergency;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: (isEmergency == true) ? Color.fromARGB(255, 218, 21, 21) : Colors.white,
      appBar: AppBar(
        title: const Text(
          'EARTHQUAKE',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color.fromARGB(255, 218, 21, 21),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           GestureDetector(
              onTap: toggleSOS,
              child: AvatarGlow(
                startDelay: const Duration(milliseconds: 1000),
                endRadius: 180,
                glowColor: Colors.black,
                child: Material(
                  elevation: 300,
                  shape: CircleBorder(),
                  color: Colors.transparent,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: InteractiveViewer(
                      child: Image.asset(
                        (isEmergency == true)
                          ? 'assets/icons/sos1.png'
                          : 'assets/icons/sos.png',
                        height: 200,
                      ),
                    ),
                    radius: 100,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.all(50.0),
                child: Text((isEmergency == true)
                    ? 'Tetap standby, kami saat ini sedang meminta bantuan terdekat.'
                    : 'Setelah menekan tombol SOS, kami akan menghubungi kantor BNPB dan Basarnas terdekat.',
                  style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EmergencyButton extends StatelessWidget {
  const EmergencyButton({super.key, required this.imageSrc, this.onTap});
  final String imageSrc;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    const buttonSize = Size(380, 380);

    return SizedBox.fromSize(
      size: buttonSize,
      child: ClipOval(
        child: Material(
          color: Theme.of(context).colorScheme.surface, // use theme color
          child: InkWell(
            splashColor: Theme.of(context).colorScheme.error, // use theme color
            onTap: onTap ?? () {}, // button pressed
            child: Image.asset(
              imageSrc,
              fit: BoxFit.cover,
            ), // load icon from asset
          ),
        ),
      ),
    );
  }
}