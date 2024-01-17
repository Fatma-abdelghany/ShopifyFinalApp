import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shopify/models/cart.dart';
import 'package:shopify/models/user.dart';
import 'package:shopify/pages/sucess_order.dart';
import 'package:shopify/providers/cart_provider.dart';
import 'package:shopify/providers/signup_provider.dart';
import 'package:shopify/utils/constants/colors_constants.dart';
import 'package:shopify/utils/constants/strings_constants.dart';
import 'package:shopify/widgets/app_bar_ex.widget.dart';
import 'package:shopify/widgets/card_list_widget.dart';
import 'package:shopify/widgets/custom_bottom_appbar_widget.dart';
import 'package:shopify/widgets/custom_divider.dart';
import 'package:shopify/widgets/grey_txt.dart';
import 'package:shopify/widgets/headline.widget.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext pageContext) {
    return Scaffold(
      appBar:AppBarEx.getAppBarWithClosedIcon(context),
       bottomNavigationBar: BottomAppBarWidget(
        isFromCart:false,
        onBuyTapped: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SuccessOrderPage(),));

          
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
            const HeadlineWidget(title: StringsConstants.checkOut),
            SizedBox(
              height: 10.h,
            ),
            Text(
              StringsConstants.shippingAddress.toUpperCase(),
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w300,
                color: ColorsConstants.greyTxtColor,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
//====================userData===========================

            buildUserData(),

            SizedBox(
              height: 10.h,
            ),
            Text(
              StringsConstants.items.toUpperCase(),
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w300,
                color: ColorsConstants.greyTxtColor,
              ),
            ),

 StreamBuilder(
                  stream: Provider.of<CartProvider>(context).cartStream,
                  builder: (ctx, aSnapShot) {
                    if (aSnapShot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (aSnapShot.hasError) {
                      return const Center(
                        child: Text('Error While Getting Data'),
                      );
                    }
                    if (aSnapShot.hasData) {
                      var cartData = Cart.fromJson(Map<String, dynamic>.from(
                          aSnapShot.data?.data() ?? {}));

                      if (cartData.items?.isEmpty ?? false) {
                        return const Center(
                          child: Text('No Data Found'),
                        );
                      } else {
                        return buildCatList(cartData, pageContext,false);
                      }
                    }
                    return const SizedBox.shrink();
                  }),


          ]),
        ),
      ),
    );
  }

  Consumer<SignUpProvider> buildUserData() {
    return Consumer<SignUpProvider>(
            builder: (context, signUpProvider, _) {
             

              return FutureBuilder(
                future: signUpProvider.getUserData(),
                builder: (context, snapshot) {
                  return Column(
                     crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                  Text("${snapshot.data?.name}",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: ColorsConstants.greyTxtColor,
                        )),  
                              
                             Row(
                               children: [
                                 Expanded(
                                   child: Text("${snapshot.data?.Adddress}",
                                                           style: TextStyle(
                                                             fontSize: 16.sp,
                                                             fontWeight: FontWeight.w300,
                                                             color: ColorsConstants.greyTxtColor,
                                                           )),
                                 ),
                        IconButton(
          icon: const Icon(
            Icons.keyboard_arrow_right,
            size: 24.0,
          ),
           color: ColorsConstants.greyIconColor,
          onPressed: (){},
        ),
                               ],
                             ),
                               Divider(),
                  ]);
                }
              );
            },
          );
  }
}
