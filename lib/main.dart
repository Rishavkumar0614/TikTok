import 'package:get/get.dart';
import 'package:tiktok/commons.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tiktok/utils/responsive_layout.dart';
import 'package:tiktok/controllers/auth_controller.dart';
import 'package:tiktok/views/screens/mobile/onboarding_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) {
    Get.put(AuthController());
  });
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'TikTok',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor,
      ),
      debugShowCheckedModeBanner: false,
      home: const ResponsiveLayout(
        mobileScreenLayout: MobileOnBoardingScreen(),
      ),
    );
  }
}
