import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopify/models/cart.dart';
import 'package:shopify/providers/cart_provider.dart';
import 'package:shopify/utils/constants/colors_constants.dart';
import 'package:shopify/utils/constants/strings_constants.dart';
import 'package:shopify/widgets/add_address.dart';
import 'package:shopify/widgets/app_bar_ex.widget.dart';
import 'package:shopify/widgets/card_list_widget.dart';
import 'package:shopify/widgets/custom_bottom_appbar_widget.dart';
import 'package:shopify/widgets/headline.widget.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext pageContext) {
    return Scaffold(
      backgroundColor: ColorsConstants.bgColor,
      appBar: AppBarEx.getAppBarTitle(context, StringsConstants.cart),
      bottomNavigationBar: BottomAppBarWidget(
        isFromCart: true,
        onBuyTapped: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>AddAdress(),));

          
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(
            children: [
              const HeadlineWidget(title: StringsConstants.cart),
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
                        return buildCatList(cartData, pageContext,true);
                      }
                    }
                    return const SizedBox.shrink();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
