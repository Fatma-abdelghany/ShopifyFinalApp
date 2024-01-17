import 'package:flutter/material.dart';
import 'package:shopify/utils/constants/colors_constants.dart';


class ProductAppBarEx {
  static PreferredSizeWidget get getAppBar => AppBar(
    centerTitle: true,
    leading: IconButton(
        onPressed: () {},
        icon: Image.asset('assets/images/back.png')
    ),
    title: Column(
      children: [
        const Text("Faux Sued Ankle Boots"),
        //Text("Faux Sued Ankle Boots"),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("\$49.99"),
            const SizedBox(width: 15,),

            Container(
              padding:const EdgeInsets.symmetric(horizontal: 5) ,
              width: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: const Color(0xffFF6969)
              ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Image.asset('assets/images/star.png'),
                const SizedBox(width: 5,),
                const Text("\$4.9"),

              ],
            )),
          ],
        ),

      ],
    ),

    actions: [
      Stack(
        children: [
          IconButton(
              onPressed: () {},
              icon: Image.asset('assets/images/Cart.png')
          ),

          Positioned(
              bottom: 6,
              child: Badge(
                backgroundColor: ColorsConstants.badgeColor,
                label: const Text('5'),
              ))
        ],
      ),

    ],
  );
}
