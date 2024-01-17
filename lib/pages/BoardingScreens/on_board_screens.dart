import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shopify/pages/navPages/master_page.dart';
import 'package:shopify/pages/auth/register_tab_pages.dart';
import 'package:shopify/services/prefrences.service.dart';
import 'package:shopify/utils/constants/colors_constants.dart';
import 'package:shopify/utils/constants/strings_constants.dart';

class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({super.key});

  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  StreamSubscription<User?>? _listener;

  var pageDecoration = const PageDecoration(
    titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
    bodyTextStyle: TextStyle(fontSize: 19.0),
    pageColor: Colors.amber,
    imagePadding: EdgeInsets.zero,
  );

  void checkUser() async {
    _listener = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (_) => const RegisterTabPages()));
      } else {
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

  void _onIntroEnd(context) {
    checkUser();
  }

  @override
  void initState() {
    setInSharedpreference();
    super.initState();
  }

  setInSharedpreference() async {
    
        await PreferenceService.getPrefsInstance!.setBool("firstOpened", true);
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: StringsConstants.intro1Title,
          body: StringsConstants.intro1desc,
          image: buildImage("assets/images/intro_1.png"),
          //getPageDecoration, a method to customise the page style
          decoration: getPageDecoration(),
        ),
        PageViewModel(
          title: StringsConstants.intro2Title,
          body: StringsConstants.intro2desc,
          image: buildImage("assets/images/intro_2.png"),
          //getPageDecoration, a method to customise the page style
          decoration: getPageDecoration(),
        ),
        PageViewModel(
          title: StringsConstants.intro3Title,
          body: StringsConstants.intro3desc,
          image: buildImage("assets/images/intro_3.png"),
          //getPageDecoration, a method to customise the page style
          decoration: getPageDecoration(),
        ),
      ],
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context),
      showSkipButton: true,
      showDoneButton: true,
      showNextButton: false,

      skip:  Text('Skip', style: TextStyle(fontWeight: FontWeight.w600,color: ColorsConstants.badgeColor)),
      done:  Text('Done', style: TextStyle(fontWeight: FontWeight.w600,color: ColorsConstants.badgeColor)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      dotsDecorator: getDotsDecorator(),
      showBackButton: false,

       dotsContainerDecorator: getDotsContainer(),
    );
  }

//widget to add the image on screen
  Widget buildImage(String imagePath) {
    return Center(
        child: Image.asset(
      imagePath,
      width: 450.w,
      height: 250.h,
    ));
  }

  //method to customise the page style
  PageDecoration getPageDecoration() {
    return const PageDecoration(
      imageFlex: 2,
      imagePadding: EdgeInsets.only(top: 120),
      pageColor: Colors.white,
      bodyPadding: EdgeInsets.only(top: 8, left: 20, right: 20),
      titlePadding: EdgeInsets.only(top: 50),
      bodyTextStyle: TextStyle(color: Colors.black54, fontSize: 15),
    );
  }

  //method to customize the dots style
  DotsDecorator getDotsDecorator() {
    return DotsDecorator(
      spacing: const EdgeInsets.symmetric(horizontal: 2),
      activeColor: ColorsConstants.badgeColor,
      color: ColorsConstants.greyTxtColor,
      activeSize: const Size(12, 5),
      activeShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
    );
  }

  getDotsContainer() {
    return  const ShapeDecoration(
      color: Colors.white,
      shape:  RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
    );
  }
}
