import 'package:flutter/material.dart';
import 'package:shopify/pages/navPages/notification_page.dart';
import 'package:shopify/utils/constants/colors_constants.dart';
import 'package:shopify/utils/constants/theme_constants.dart';
import 'package:shopify/widgets/cart_badge.dart';


class AppBarEx {
  static PreferredSizeWidget getAppBar(BuildContext context) => AppBar(
        backgroundColor: ColorsConstants.bgColor,
        elevation: 0,
        actions: [
          const Stack(
            children: [
              CartBadgeWidget(),
            ],
          ),
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                context, MaterialPageRoute(builder: (_) => NotificatonPage()));
                },
                icon: Icon(
                  Icons.notifications_outlined,
                  color: ColorsConstants.iconColor,
                ),
              ),
              Positioned(
                  bottom: 10,
                  child: Badge(
                    backgroundColor: ColorsConstants.badgeColor,
                    label: const Text('5'),
                  ))
            ],
          ),
        ],
      );

  static PreferredSizeWidget getAppBarTitle(BuildContext context, String appBarTitle) => AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: ColorsConstants.bgColor,
        iconTheme: ThemeConstants.themeData.iconTheme,
        title: Text(appBarTitle,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: ColorsConstants.greyTxtColor,
            )),
      );

      static PreferredSizeWidget getAppBarWithClosedIcon(BuildContext context) => AppBar(
        backgroundColor: ColorsConstants.bgColor,
        automaticallyImplyLeading: false,
        
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.close,
                color: ColorsConstants.badgeColor,
              ))
        ],
      );

}
