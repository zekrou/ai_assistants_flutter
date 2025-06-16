import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ChatScreen.dart';
import 'SportPlanner.dart';

class HomeSelector extends StatelessWidget {
  const HomeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Choisissez votre Assistant IA"),
        backgroundColor: Colors.deepOrangeAccent,
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Raouf AI
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SportPlannerBot()),
                  );
                },
                child: Column(
                  children: [
                    Image.asset("assets/sport.png", width: 100, height: 100),
                    const SizedBox(height: 8),
                    const Text(
                      "Raouf AI",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "Assistant spécialisé dans le sport et la musculation",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // L'Boudi AI
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Chatscreen()),
                  );
                },
                child: Column(
                  children: [
                    Image.asset("assets/NDT1.png", width: 100, height: 100),
                    const SizedBox(height: 8),
                    const Text(
                      "L'Boudi AI",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "Conseiller expert en gestion et management",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

