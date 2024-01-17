import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:shopify/pages/splash.dart';
import 'package:shopify/providers/ads_provider.dart';
import 'package:shopify/providers/app_auth_provider.dart';
import 'package:shopify/providers/cart_provider.dart';
import 'package:shopify/providers/category_provider.dart';
import 'package:shopify/providers/forget_password_provider.dart';
import 'package:shopify/providers/home_provider.dart';
import 'package:shopify/providers/notification_provider.dart';
import 'package:shopify/providers/product_provider.dart';
import 'package:shopify/providers/signup_provider.dart';
import 'package:shopify/services/prefrences.service.dart';
import 'package:shopify/utils/constants/strings_constants.dart';
import 'package:shopify/utils/constants/theme_constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  PreferenceService.init();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => AppAuthProvider()),
    ChangeNotifierProvider(create: (_) => ForgetPasswordProvider()),
    ChangeNotifierProvider(create: (_) => SignUpProvider()),
    Provider(create: (_) => ProductProvider()),
    ChangeNotifierProvider(create: (_) => HomeProvider()),
    ChangeNotifierProvider(create: (_) => CategoryProvider()),
    Provider(create: (_) => AdsProvider()),
    Provider(create: (_) => CartProvider()),
    Provider(create: (_) => NotificationProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    

    StringsConstants.satusBarColor();

    return OverlaySupport.global(
      child: ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, child) {
            return MaterialApp(
               navigatorKey: StringsConstants.navigatorKey, // GlobalKey()

              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              theme: ThemeConstants.themeData,
              home: const Splash(),
              // home: const CartPage(),
            );
          }),
    );
  }
}
