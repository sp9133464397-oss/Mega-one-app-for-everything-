import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:battery_plus/battery_plus.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(MegaApp());
}

class MegaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MegaHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MegaHome extends StatefulWidget {
  @override
  _MegaHomeState createState() => _MegaHomeState();
}

class _MegaHomeState extends State<MegaHome> {
  String prediction = "Loading BOSS...";
  final Battery _battery = Battery();

  @override
  void initState() {
    super.initState();
    getMegaPrediction();
  }

  Future<void> getMegaPrediction() async {
    DateTime now = DateTime.now();
    int hour = now.hour;
    String day = DateFormat('EEEE').format(now);
    int batteryLevel = await _battery.batteryLevel;
    bool atHome = await _checkIfAtHome();
    bool isWeekend = (day == 'Saturday' || day == 'Sunday');

    String newPrediction;
    
    // SCENE 1: MONDAY MORNING + INTLO + BATTERY LOW
    if (day == 'Monday' && hour >= 7 && hour < 9 && atHome && batteryLevel < 30) {
      newPrediction = "BOSS MONDAY ALERT 😭\nBattery $batteryLevel% undi. Charger pett ra\n9AM ki office meeting undi\nOla book chesana? Traffic ekkuva\nCoffee thagi ready avvu ☕";
    }
    // SCENE 2: FRIDAY NIGHT + BAYATA UNNAV
    else if (day == 'Friday' && hour >= 19 && !atHome) {
      newPrediction = "BOSS FRIDAY NIGHT 🔥\nBayata unnav. Friends tho unnav anukunta\nCab book cheyyana intiki velladaniki?\nRope salary padindi kada 💰";
    }
    // SCENE 3: SUNDAY AFTERNOON + INTLO + BATTERY FULL
    else if (day == 'Sunday' && hour >= 13 && hour < 16 && atHome && batteryLevel > 80) {
      newPrediction = "BOSS SUNDAY CHILL 😎\nBattery full. Intlo unnav. Perfect!\nMovie chudava? Leda MEGA-OS code cheddama?\nAmma tho time spend chey BOSS ❤️";
    }
    // SCENE 4: RATRIPUTA 1AM + BATTERY LOW
    else if (hour >= 1 && hour < 5 && batteryLevel < 20) {
      newPrediction = "BOSS 1AM AYINDI 😱\nInka nidra poledu? Battery $batteryLevel%\nHealth debba tintadi BOSS\nPhone charge pettuko 😴";
    }
    // DEFAULT
    else {
      String locationText = atHome ? "Intlo unnav" : "Bayata unnav";
      newPrediction = "BOSS LIVE STATUS 📊\nTime: ${DateFormat('hh:mm a').format(now)}\nDay: $day\n$locationText\nBattery: $batteryLevel%\n\n${isWeekend ? 'Chill cheyyi' : 'Task finish chey'} BOSS 🚀";
    }
    
    setState(() {
      prediction = newPrediction;
    });
  }

  Future<bool> _checkIfAtHome() async {
    try {
      Position pos = await Geolocator.getCurrentPosition();
      double homeLat = 17.3850; 
      double homeLong = 78.4867;
      double distance = Geolocator.distanceBetween(pos.latitude, pos.longitude, homeLat, homeLong);
      return distance < 100;
    } catch (e) {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MEGA-OS BOSS DILEEP 👑"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                prediction,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: getMegaPrediction,
                child: Text("REFRESH PREDICTION 🔄"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
