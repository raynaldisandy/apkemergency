import 'package:flutter/material.dart';

class FirePage extends StatefulWidget {
  const FirePage({super.key});

  @override
  State<FirePage> createState() => _FirePageState();
}

class _FirePageState extends State<FirePage> {
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
          'FIRE',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color.fromARGB(255, 218, 21, 21),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            EmergencyButton(
              imageSrc: (isEmergency == true)
                  ? 'assets/icons/sos1.png'
                  : 'assets/icons/sos.png', // TODO: GANTI INI YAK
              onTap: () => toggleSOS(),
            ),
            const SizedBox(
              height: 20,
            ),
             Center(
              child: Padding(
                padding: EdgeInsets.all(50.0),
                child: Text((isEmergency == true)
                  ? 'Tetap standby, kami saat ini sedang meminta bantuan terdekat.'
                  : 'Setelah menekan tombol SOS, kami akan menghubungi kantor pemadam kebakaran terdekat.',
                  style: TextStyle(color: Colors.black,fontSize: 20, fontWeight: FontWeight.bold),
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