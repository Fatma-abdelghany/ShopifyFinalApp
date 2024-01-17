import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopify/pages/BoardingScreens/on_board_screens.dart';
import 'package:shopify/pages/auth/register_tab_pages.dart';
import 'package:shopify/services/prefrences.service.dart';
import 'package:shopify/services/push_notification.dart';

import 'navPages/master_page.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  StreamSubscription<User?>? _listener;
  bool? firstOpen;

  @override
  void initState() {
    checkFirstOpen();
    super.initState();
  }

  void checkFirstOpen() async {
    await Future.delayed(const Duration(seconds: 2));

    // Initialize PreferenceUtils instance.
    await PreferenceService.init();
    firstOpen = PreferenceService.getPrefsInstance!.getBool("firstOpened");

    debugPrint('******************initScreen ${firstOpen}');
    if (firstOpen == null) {
      if (context.mounted) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const OnBoardScreen()));
      }
    } else {
      checkUser();
    }
  }

  void checkUser() async {
    _listener = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (_) => const RegisterTabPages()));
      } else {
        PushNotificationService.checkNotificationOnKilledApp();
        PushNotificationService.init();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const MasterPage()));
      }
    });
  }

  @override
  void dispose() {
    _listener?.cancel();
    super.dispose();
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/Logo.png"),
            const CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}
