import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shopify/pages/navPages/cart_page.dart';
import 'package:shopify/pages/navPages/categories.dart';
import 'package:shopify/pages/navPages/order_status_page.dart';
import 'package:shopify/pages/navPages/profile_page.dart';
import 'package:shopify/pages/products_page.dart';
import 'package:shopify/utils/constants/colors_constants.dart';

import '../../widgets/app_bar_ex.widget.dart';
import 'home_page.dart';

class MasterPage extends StatefulWidget {
  const MasterPage({
    super.key,
  });

  @override
  State<MasterPage> createState() => _MasterPageState();
}

class _MasterPageState extends State<MasterPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      HomePage(),
    
      ProfilePage(),

      OrderStatusPage()
    ];
    return Scaffold(
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        height: 50.h,
        onTap: (index) {
          _selectedIndex = index;
          setState(() {});
        },
        backgroundColor: Colors.black.withOpacity(.002),
        elevation: 0,
        gapLocation: GapLocation.none,
        notchSmoothness: NotchSmoothness.smoothEdge,
        leftCornerRadius: 15,
        rightCornerRadius: 15,
        activeIndex: _selectedIndex,
        itemCount: 3,
        tabBuilder: ((index, isActive) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                index == 0
                    ? LineIcons.home
                    :  index == 1
                            ? LineIcons.user
                            : LineIcons.shoppingCart,
                size: 25,
                color: isActive ? ColorsConstants.badgeColor : Colors.grey,
              ),
              Text(
                index == 0
                    ? 'Home'
                    : index == 1
                        ? 'Profile'
                            : 'Order',
                style: TextStyle(
                  color: isActive ? ColorsConstants.badgeColor : Colors.grey,
                ),
              )
            ],
          );
        }),
      ),
      appBar: AppBarEx.getAppBar(context),
      body: Column(
        children: <Widget>[pages[_selectedIndex]],
      ),
    );
  }
}
