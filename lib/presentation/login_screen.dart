import 'package:flutter/material.dart';
import 'package:untitled4/main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var _globalKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _globalKey,
        child: Container(
          child: Column(
            children: [
              TextFormField(
                controller: emailController,
                maxLines: 1,
                decoration: InputDecoration(
                  labelText: 'Please enter email address',
                  enabledBorder: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 40),
              TextFormField(
                controller: passwordController,
                maxLines: 1,
                decoration: InputDecoration(
                  labelText: 'Please enter password',
                  enabledBorder: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  goRouter.go('/home');
                },
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
