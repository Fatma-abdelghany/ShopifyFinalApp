import 'package:flutter/material.dart';

import 'colors_constants.dart';

class ThemeConstants{
  static ThemeData themeData = ThemeData(
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(
        color: ColorsConstants.badgeColor
      )
    ),

        
    fontFamily: 'NeusaNextStd',
    textTheme:  TextTheme(
        headlineLarge: TextStyle(
            color: ColorsConstants.headLineColor,
            fontSize: 30,
            fontWeight: FontWeight.w600),
      displayLarge: TextStyle(
          color: ColorsConstants.tabSelectedTxtColor,
          fontSize: 30,
          fontWeight: FontWeight.bold),
      displaySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w300,
          color: ColorsConstants.greyTxtColor),
      headlineSmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w300,
          color: ColorsConstants.buttonColor),

    ),


    tabBarTheme:TabBarTheme(
      labelColor: ColorsConstants.tabSelectedTxtColor,
      unselectedLabelColor: ColorsConstants.tabUnSelectedTxtColor,
      indicatorColor: Colors.transparent,

    ) ,
    



    colorScheme: ColorScheme.fromSeed(seedColor: Colors.purpleAccent),
   // useMaterial3: true,
  );

}