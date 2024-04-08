import 'package:flutter/material.dart';
import 'models/vki.dart';
import 'data/data.dart';
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VKI Hesaplama',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainScreen(),
    );
  }
}
class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentScreenIndex = 0;
  late VKI userVKI;

  @override
  Widget build(BuildContext context) {
    Widget currentScreen;
    switch (currentScreenIndex) {
      case 0:
        currentScreen = WelcomeScreen(
          onStartPressed: () {
            setState(() {
              currentScreenIndex = 1;
            });
          },
        );
        break;
      case 1:
        currentScreen = QuestionsScreen(
        );
        break;
      case 2:
        currentScreen = ResultScreen(
          age: userVKI.age,
          height: userVKI.height,
          weight: userVKI.weight,
          vki: userVKI.vkiHesapla(),
        );
        break;
      default:
        currentScreen = WelcomeScreen(
          onStartPressed: () {
            setState(() {
              currentScreenIndex = 1;
            });
          },
        );
    }

    return Scaffold(
      body: currentScreen,
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  final VoidCallback onStartPressed;

  WelcomeScreen({required this.onStartPressed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png',
              width: 150,
              height: 150,
            ),
            Text(
              'Hoşgeldiniz',
              style: TextStyle(fontSize: 24),
            ),
            ElevatedButton(
              onPressed: onStartPressed,
              child: Text('Başlat'),
            ),
          ],
        ),
      ),
    );
  }
}
class QuestionsScreen extends StatefulWidget {
  @override
  _QuestionsScreenState createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  int age = 0;
  double height = 0;
  double weight = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bilgi Girişi'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.1), BlendMode.dstATop),
            image: AssetImage('assets/resim.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Yaşınız: $age'),
              Slider(
                value: age.toDouble(),
                onChanged: (newValue) {
                  setState(() {
                    age = newValue.round();
                  });
                },
                min: 0,
                max: 100,
                divisions: 100,
              ),
              Text('Boy (cm): ${height.toStringAsFixed(1)}'),
              Slider(
                value: height,
                onChanged: (newValue) {
                  setState(() {
                    height = newValue;
                  });
                },
                min: 0,
                max: 300,
                divisions: 300,
              ),
              Text('Kilo (kg): ${weight.toStringAsFixed(1)}'),
              Slider(
                value: weight,
                onChanged: (newValue) {
                  setState(() {
                    weight = newValue;
                  });
                },
                min: 0,
                max: 300,
                divisions: 300,
              ),
              ElevatedButton(
                onPressed: () {
                  VKI userVKI = VKI(age: age, height: height, weight: weight);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResultScreen(
                        age: userVKI.age,
                        height: userVKI.height,
                        weight: userVKI.weight,
                        vki: userVKI.vkiHesapla(),
                      ),
                    ),
                  );
                },
                child: Text('Hesapla'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class ResultScreen extends StatelessWidget {
  final int age;
  final double height;
  final double weight;
  final double vki;

  ResultScreen({
    required this.age,
    required this.height,
    required this.weight,
    required this.vki,
  });

  @override
  Widget build(BuildContext context) {
    String? sonuc = findVKIAraligi(vki,age);
    return Scaffold(
      appBar: AppBar(
        title: Text('Sonuçlar'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.1), BlendMode.dstATop),
            image: AssetImage('assets/results.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Yaş : $age',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),),
              Text('Boy : $height cm',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),),
              Text('Kilo : $weight kg',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),),
              Text('VKİ : ${vki.toStringAsFixed(1)}',
                style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              ),
              Text(
                "Kullanıcı VKI değerine göre :"+sonuc.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 23,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}