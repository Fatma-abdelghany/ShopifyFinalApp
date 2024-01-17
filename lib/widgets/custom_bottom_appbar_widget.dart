import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shopify/providers/cart_provider.dart';
import 'package:shopify/utils/constants/colors_constants.dart';
import 'package:shopify/utils/constants/strings_constants.dart';
import 'package:shopify/widgets/custom_button_widget.dart';

class BottomAppBarWidget extends StatelessWidget {
  const BottomAppBarWidget({super.key, required this.onBuyTapped, required this.isFromCart});
  final Function()? onBuyTapped;
  final bool isFromCart;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        color: ColorsConstants.bgColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 60.h,
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    StringsConstants.total,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w300,
                      color: ColorsConstants.greyTxtColor,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  ValueListenableBuilder(
                      valueListenable: Provider.of<CartProvider>(
                        context,
                      ).totalNotifier,
                      builder: (context, value, __) {
                        return Text(
                          '\$ ${num.parse(value.toStringAsFixed(3))}',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                            color: ColorsConstants.greyTxtColor,
                          ),
                        );
                      }),
                   SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    StringsConstants.freeShipping,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w300,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
            CustomButtonWidget(
                text: isFromCart?StringsConstants.checkOut.toUpperCase():StringsConstants.orderNow.toUpperCase(),
                iconColor: ColorsConstants.buttonColor,
                btnIcon: Icons.arrow_forward_ios_outlined,
                iconBgColor: Colors.white,
                txtColor: Colors.white,
                bgColor: ColorsConstants.buttonColor,
                onBtnPressed: onBuyTapped)
          ],
        ));
  }
}
