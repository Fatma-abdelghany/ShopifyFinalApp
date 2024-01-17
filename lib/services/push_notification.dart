import 'dart:convert';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:shopify/firebase_options.dart';
import 'package:shopify/models/notification.dart';
import 'package:shopify/pages/navPages/notification_page.dart';
import 'package:shopify/providers/forget_password_provider.dart';
import 'package:shopify/providers/notification_provider.dart';
import 'package:shopify/services/prefrences.service.dart';
import 'package:shopify/utils/constants/colors_constants.dart';
import 'package:shopify/utils/constants/strings_constants.dart';
import 'package:uuid/uuid.dart';

class PushNotificationService {
  static FirebaseMessaging? fcm;
  static bool _isInialized = false;
  static bool _isTokenInit = false;

  static int _tries = 0;

  static Future init() async {
    if (_isInialized) {
      await _sendToken();
      return;
    }
    fcm = FirebaseMessaging.instance;
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      // Forground Notification
      handleOnNotificationReceived(message, isForground: true);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      // App Background Not killed Notification
      handleOnNotificationReceived(message);
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    try {
      await _sendToken();
      _isInialized = true;
    } catch (e) {
      print(
          '>>>>>>Exeption while doing operations in push notification init${e.toString()}');
      _isInialized = true;
      if (_tries <= 20) {
        init();
        _tries++;
      }
    }
  }

  /// used when the user logout
  static void onPushNotificationClosed() {
    _isTokenInit = false;
  }

  

  static Future<void> _sendToken() async {
    if (_isTokenInit) return;
    var userToken = await fcm?.getToken();
//============================ setUserTokenInSharedpreference =====================
    await PreferenceService.getPrefsInstance!.setString("userToken", userToken!);

    await FirebaseFirestore.instance
        .collection('tokens')
        .doc(FirebaseAuth.instance.currentUser?.email)
        .set({"token": userToken});
    // end of update user data
    debugPrint(
        '||||||||||||||||||||||||||||||||||||||||||||||||||| New Token : ${userToken}');
    _isTokenInit = true;
  }

  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    debugPrint('A bg message just showed up :  ${message.messageId}');
  }

  static void handleOnNotificationReceived(RemoteMessage message,
      {bool isForground = false}) async {
    //DateTime now = DateTime.now();
    // String formattedDate = DateFormat('kk:mm:ss \n EEE d MMM').format(now);

    RemoteNotification? notification = message.notification;
    addNotification(notification);

    var payLoad;
    print(
        '>>>>>>>>>>>>>>>>>>>>>>>> notification recieved ${message.data['payload']}');
    if (message.data['payload'] != null) {
      payLoad = jsonDecode(message.data['payload']);
      try {
        switch (payLoad["type"].toString()) {}
      } catch (e) {
        print('error ${e}');
      }
    }
    if (notification != null) {
      if (isForground) {
        showSimpleNotification(
          Text(message.notification!.title!,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w300,
                color: ColorsConstants.greyTxtColor,
              )),
          leading: CircleAvatar(
            backgroundColor:
                Colors.primaries[Random().nextInt(Colors.primaries.length)],
            child: Image.asset("assets/images/notif_icon.png"),
          ),

          // subtitle: Text(message.notification!.body!),
          // trailing:Text(time,style: const TextStyle(
          //                 fontSize: 10,
          //                 color: Color(0xff515c6f),
          //               )) ,
          background: ColorsConstants.bgColor,
          duration: const Duration(seconds: 12),
        );
      }
    }
  }

  static void addNotification(RemoteNotification? notification)async {
    NotificationData notificationModel = NotificationData();
    notificationModel.title = notification?.title;
    var userToken=    await PreferenceService.getPrefsInstance!.getString("userToken");

    notificationModel.userToken = userToken;
    final now = DateTime.now();
    notificationModel.createdAt =
        DateTime.fromMillisecondsSinceEpoch(now.millisecondsSinceEpoch);

    Provider.of<NotificationProvider>(
            StringsConstants.navigatorKey.currentState!.context,
            listen: false)
        .addNotification(
            context: StringsConstants.navigatorKey.currentState!.context,
            notifcation: notificationModel);
  }

  static void handleOnNotificationClicked(dynamic payLoad) async {
    try {
      switch (payLoad["type"].toString()) {}
      Navigator.push(StringsConstants.navigatorKey.currentState!.context,
          MaterialPageRoute(builder: (context) => NotificatonPage()));
    } catch (e) {
      print('error ${e}');
    }
  }

  static void checkNotificationOnKilledApp() async {
    RemoteMessage? message =
        await FirebaseMessaging.instance.getInitialMessage();
    if (message != null) {
      handleOnNotificationReceived(message);
    }
  }
}
