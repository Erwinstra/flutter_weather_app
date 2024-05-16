import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../models/constant.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  Color? myColor = Colors.blue[200];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Constant myColor = Constant();

    return Scaffold(
      backgroundColor: myColor.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/welcome_animation.json'),
            SizedBox(height: size.height * 0.05),
            Ink(
              height: 65,
              width: size.width * 0.7,
              decoration: BoxDecoration(
                color: myColor.buttonColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/chooseLocations');
                },
                child: const Center(
                  child: Text(
                    'Get Started',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
