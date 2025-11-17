import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(SolarSystemApp());
}

class SolarSystemApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'النظام الشمسي',
      theme: ThemeData.dark(),
      home: SolarSystemPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SolarSystemPage extends StatefulWidget {
  @override
  _SolarSystemPageState createState() => _SolarSystemPageState();
}

class _SolarSystemPageState extends State<SolarSystemPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final List<Planet> planets = [
    Planet(
        name: 'عطارد', image: 'assets/mercury.png', radius: 40, distance: 60),
    Planet(
        name: 'الزهرة', image: 'assets/venus.png', radius: 50, distance: 100),
    Planet(name: 'الأرض', image: 'assets/earth.png', radius: 50, distance: 140),
    Planet(name: 'المريخ', image: 'assets/mars.png', radius: 45, distance: 180),
    Planet(
        name: 'المشتري',
        image: 'assets/jupiter.png',
        radius: 70,
        distance: 240),
    Planet(name: 'زحل', image: 'assets/saturn.png', radius: 65, distance: 300),
    Planet(
        name: 'أورانوس', image: 'assets/uranus.png', radius: 60, distance: 360),
    Planet(
        name: 'نبتون', image: 'assets/neptune.png', radius: 60, distance: 420),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 60),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'assets/star.gif',
                  width: double.infinity,
                  height: double.infinity,
                ),
                // الشمس
                Image.asset(
                  'assets/sun.png',
                  width: 100,
                  height: 100,
                ),
                // الكواكب
                for (int i = 0; i < planets.length; i++)
                  Transform.rotate(
                    angle: _controller.value * 2 * pi * (1 + i * 0.1),
                    child: Transform.translate(
                      offset: Offset(planets[i].distance.toDouble(), 0),
                      child: GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PlanetDetailPage(planet: planets[i]),
                          ),
                        ),
                        child: Image.asset(
                          planets[i].image,
                          width: planets[i].radius.toDouble(),
                          height: planets[i].radius.toDouble(),
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class PlanetDetailPage extends StatelessWidget {
  final Planet planet;
  PlanetDetailPage({required this.planet});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text(planet.name)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              planet.image,
              width: 150,
              height: 150,
            ),
            SizedBox(height: 20),
            Text(
              'اسم الكوكب: ${planet.name}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              'ترتيبه من الشمس: ${planet.getOrder()}',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class Planet {
  final String name;
  final String image;
  final int radius;
  final int distance;

  Planet(
      {required this.name,
      required this.image,
      required this.radius,
      required this.distance});

  int getOrder() {
    switch (name) {
      case 'عطارد':
        return 1;
      case 'الزهرة':
        return 2;
      case 'الأرض':
        return 3;
      case 'المريخ':
        return 4;
      case 'المشتري':
        return 5;
      case 'زحل':
        return 6;
      case 'أورانوس':
        return 7;
      case 'نبتون':
        return 8;
      default:
        return 0;
    }
  }
}
