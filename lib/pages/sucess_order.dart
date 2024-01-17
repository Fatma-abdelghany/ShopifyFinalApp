import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopify/pages/navPages/master_page.dart';
import 'package:shopify/pages/navPages/order_status_page.dart';
import 'package:shopify/utils/constants/colors_constants.dart';
import 'package:shopify/utils/constants/strings_constants.dart';
import 'package:shopify/widgets/app_bar_ex.widget.dart';
import 'package:shopify/widgets/custom_button_widget.dart';

class SuccessOrderPage extends StatelessWidget {
  const SuccessOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConstants.bgColor,
            appBar:AppBarEx.getAppBarWithClosedIcon(context),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                  width: 100.h,
                  height: 100.h,
                  decoration: const BoxDecoration(
            shape: BoxShape.circle,
                    color:Colors.white,
                  ),
                  child: Center(
                    child: 
                          Icon(
                            Icons.check,
                            color: ColorsConstants.badgeColor,
                            size: 50,
                          )
                       
                  ),
                  ),
                  SizedBox(height: 15.h,),
                Text(
                        StringsConstants.orderPlaced,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: ColorsConstants.greyTxtColor,
                        ),
                      ),
                                        SizedBox(height: 10.h,),

                      Text(
                        StringsConstants.orderPlacedSuccessfully
                  ,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w300,
                    color: Colors.grey[700],
                  ),
                ),
                      Text(
                        StringsConstants.orderPlacedSuccessfullyDetails
                  ,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w300,
                    color: Colors.grey[700],
                  ),
                ),
                                  SizedBox(height: 25.h,),

                CustomButtonWidget(
                text: StringsConstants.orderStatus.toUpperCase(),
                iconColor: ColorsConstants.buttonColor,
                btnIcon: Icons.arrow_forward_ios_outlined,
                iconBgColor: Colors.white,
                txtColor: Colors.white,
                bgColor: ColorsConstants.buttonColor,
                onBtnPressed:(){
                  Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const MasterPage()));
                } )
                ],
              ),
            ),

    );
  }
}