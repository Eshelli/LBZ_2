import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset('assets/image/libozzle_gif.gif',fit: BoxFit.cover,height: 600,width: double.infinity,)),
    );
  }
}
