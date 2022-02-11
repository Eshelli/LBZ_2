import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:lbz/Screens/login/main_login_screen.dart';
import 'package:lbz/shared/network/remote/dio_helper.dart';
import 'package:lbz/shared/components/constans.dart';
import 'package:lbz/Screens/home_screen.dart';
import 'package:lbz/shared/network/local/cache_helper.dart';
import 'package:lbz/shared/styles/colors.dart';
import 'package:lbz/splash.dart';
import 'package:overlay_support/overlay_support.dart';
import 'all_controllers.dart';
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print(message.notification!.title);
  print(message.data);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // var tok = await FirebaseMessaging.instance.getToken();
  // print(tok);
  //
  // FirebaseMessaging.onMessage.listen((event) {
  //   print(event.notification!.title);
  //   print(event.data);
  // });
  //
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  //
  // FirebaseMessaging.onMessageOpenedApp.listen((event) {
  //   print(event.notification!.title);
  //   print(event.data);
  // });

  await CacheHelper.init();
  token = await CacheHelper.getData(key: 'token');
  lang = await CacheHelper.getData(key: 'lang') ?? 'ar';
  Stripe.publishableKey = 'pk_test_51KDQFjKZkUlOvSwdbW9emSWKDGoKH4W3LaAVFvh2mStmIoWgjBbOuM536h9YeVecXi6DGYW47QYv5PgQSQ1Wmpz800LJcSpt7N';
  // print(token);
  DioHelper.init();
  Widget startWidget;

  if (token != null) {
    startWidget = HomeScreen();
  } else {
    startWidget = const MainLoginScreen();
  }
  runApp(MyApp(startWidget));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  MyApp(this.startWidget);

  @override
  Widget build(BuildContext context) {
    Get.put(ALlControllers());
    return OverlaySupport(
      child: GetMaterialApp(
        title: 'Libozzle',
        debugShowCheckedModeBanner: false,
        initialBinding: ALlControllers(),
        theme: ThemeData(
          bottomAppBarTheme: const BottomAppBarTheme(color: Colors.white),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            titleTextStyle: TextStyle(color: blackDefaultColor),
            iconTheme: IconThemeData(color: blackDefaultColor),
          ),
          textTheme: const TextTheme(
              subtitle1: TextStyle(color: blackDefaultColor, fontSize: 24),
              subtitle2: TextStyle(color: blackDefaultColor, fontSize: 18)),
          primarySwatch: Colors.blueGrey,
          iconTheme: const IconThemeData(color: redDefaultColor, size: 25),
          fontFamily: 'Somar',
        ),
        home: AnimatedSplashScreen(
            duration: 4000,
            splash: SplashScreen(),
            nextScreen: Directionality(
                textDirection:
                    lang == 'ar' ? TextDirection.rtl : TextDirection.ltr,
                child: startWidget),
            backgroundColor: Colors.white.withOpacity(.99)),
      ),
    );
  }
}
