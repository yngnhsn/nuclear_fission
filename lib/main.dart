import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const NukeApp());
}

class NukeApp extends StatelessWidget {
  const NukeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nükleer Simülatör',
      theme: ThemeData.dark(),
      home: const ReactorDashboard(),
    );
  }
}

class ReactorDashboard extends StatefulWidget {
  const ReactorDashboard({super.key});

  @override
  State<ReactorDashboard> createState() => _ReactorDashboardState();
}

class _ReactorDashboardState extends State<ReactorDashboard> {

  double sicaklik = 500.0;
  double kontrolCubuguSeviyesi = 50.0;
  double uretilenGuc = 0.0;
  Timer? reaktorTimer;
  bool reaktorEridi = false;

  @override
  void initState() {
    super.initState();
    reaktorTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!reaktorEridi) {
        setState(() {
          double isiUretimi = (100.0 - kontrolCubuguSeviyesi) * 1.5;
          double sogutma = 60.0;

          sicaklik = sicaklik + (isiUretimi - sogutma);

          if (sicaklik < 20.0) {
            sicaklik = 20.0;
          }

          if (sicaklik > 300.0 && sicaklik < 1000.0) {
            uretilenGuc = (sicaklik - 300) * 2;
          } else if (sicaklik >= 1000.0) {
            uretilenGuc = 0.0;
          } else {
            uretilenGuc = 0.0;
          }

          if (sicaklik > 1200.0) {
            reaktorEridi = true;
            uretilenGuc = 0.0;
            reaktorTimer?.cancel();
          }
        });
      }
    });
  }

  @override
  void dispose() {
    reaktorTimer?.cancel();
    super.dispose();
  }

  void scramMekanizmasi() {
    setState(() {
      kontrolCubuguSeviyesi = 100.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reaktör Kontrol Paneli ☢️"),
        backgroundColor: reaktorEridi ? Colors.red : Colors.red[900],
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              reaktorEridi ? "DURUM: REAKTÖR ERİDİ!" : "DURUM: AKTİF",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: reaktorEridi ? Colors.red : Colors.green,
              ),
            ),
            const SizedBox(height: 30),
            Text(
              "Çekirdek Sıcaklığı: ${sicaklik.toInt()} °C",
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: sicaklik / 1200.0,
              backgroundColor: Colors.grey[800],
              color: sicaklik > 900 ? Colors.red : (sicaklik > 600 ? Colors.orange : Colors.green),
              minHeight: 20,
            ),
            const SizedBox(height: 40),
            Text(
              "Üretilen Güç: ${uretilenGuc.toInt()} MW",
              style: const TextStyle(fontSize: 24, color: Colors.blueAccent),
            ),
            const SizedBox(height: 40),
            Text(
              "Kontrol Çubukları: %${kontrolCubuguSeviyesi.toInt()}",
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
            Slider(
              value: kontrolCubuguSeviyesi,
              min: 0,
              max: 100,
              activeColor: Colors.amber,
              inactiveColor: Colors.grey,
              onChanged: reaktorEridi ? null : (deger) {
                setState(() {
                  kontrolCubuguSeviyesi = deger;
                });
              },
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: reaktorEridi ? null : scramMekanizmasi,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              ),
              child: const Text(
                "SCRAM (ACİL DURUM FRENİ)",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}