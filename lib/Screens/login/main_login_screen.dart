import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lbz/Screens/login/login_screen.dart';
import 'package:lbz/Screens/login/register_screen.dart';
import 'package:lbz/assets/flaticon_icons.dart';
import 'package:lbz/shared/styles/colors.dart';

import '../home_screen.dart';

class MainLoginScreen extends StatelessWidget {
  const MainLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: InkWell(
                onTap: () {
                  Get.off(HomeScreen());
                },
                borderRadius: BorderRadius.circular(30),
                splashColor: Colors.grey.shade400,
                child: const Icon(
                  FlatIcon.close,
                  color: Colors.grey,
                  size: 35,
                )),
          ),
        ],
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Image(
              image: AssetImage(
                'assets/image/lbz.png',
              ),
              fit: BoxFit.contain,
              height: 60,
              width: 150,
            ),
            const Image(
              image: AssetImage(
                'assets/image/register.png',
              ),
              fit: BoxFit.fill,
              height: 180,
              width: 200,
            ),
            const Text('Login to Libozzle',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
            const SizedBox(height: 15,),
            SizedBox(
                height: 50,
                child: button('Continue with Email', FlatIcon.email,null,
                    axis: MainAxisAlignment.start,
                    fontSize: 25,
                    clr: Colors.grey,onPress: (){
                      Get.to(LoginScreen());
                    })),
            const SizedBox(height: 10,),
            SizedBox(
                height: 50,
                child: button('Continue with Facebook', null,'assets/image/facebook_1.png',
                    axis: MainAxisAlignment.start,
                    fontSize: 25,
                    clr: Colors.grey,onPress: (){})),
            const SizedBox(height: 10,),
            SizedBox(
                height: 50,
                child: button(
                    'Continue with Google', null,'assets/image/google-symbol.png',
                    axis: MainAxisAlignment.start,
                    fontSize: 25,
                    clr: Colors.grey,onPress: (){})
            ),
            TextButton(onPressed: (){Get.to(RegisterScreen());}, child: const Text('Don\'t have an account? Create one',style: TextStyle(color: redDefaultColor,fontSize: 20),))
          ],
        ),
      ),
    );
  }
  Widget button(String text, IconData? icon,String? image,
      {MainAxisAlignment axis = MainAxisAlignment.center,
      double fontSize = 18,
      Color iconColor = redDefaultColor,
      Color clr = redDefaultColor,
      Color color = Colors.white,
      onPress}) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 4),
      child: MaterialButton(
        onPressed: onPress,
        splashColor: clr,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: clr)),
        color: color,
        child: Row(
          mainAxisAlignment: axis,
          children: [
            if(icon !=null)
              Icon(
              icon,
              color: iconColor,
              size: 30,
            ),
            if(image !=null)
             Image.asset(image,height: 30,width: 30,),
            const SizedBox(
              width: 10,
            ),
            Text(text,
                style: TextStyle(fontSize: fontSize, color: Colors.black)),
          ],
        ),
      ),
    );
  }
}
