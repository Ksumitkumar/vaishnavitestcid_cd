import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled4/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), () {
      goRouter.go('/login');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FittedBox(
          child: Container(
            child: Image.asset('asset/images/logo.jpeg'),
            width: 100,
            height: 100,
          ),
        ),
      ),
    );
  }
}
