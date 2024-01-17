import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:shopify/pages/navPages/cart_page.dart';
import 'package:shopify/providers/cart_provider.dart';

class CartBadgeWidget extends StatelessWidget {
  const CartBadgeWidget({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => CartPage()));
          //  openCartPage(context);
          },
          icon: const Icon(
            LineIcons.shoppingCart,
            color: Color(0xff727c8e),
            size: 30,
          ),
        ),
        Positioned(
            bottom: 6,
            child: StreamBuilder(
                stream: Provider.of<CartProvider>(context).cartStream,
                builder: (ctx, aSnapShot) {

                  if (aSnapShot.connectionState == ConnectionState.waiting) {
                      return buildBadgeWidget(0);
                    }

                    if (aSnapShot.hasError) {
                      return const Center(
                        child: Text('Error While Getting Data'),
                      );
                    }
                  if (aSnapShot.hasData && aSnapShot.data!.exists) {
                  

                    int quantity = 0;


                    for (Map<String, dynamic> item
                        in aSnapShot.data?.data()?['items']) {
                      quantity += (item['quantity'] as int);
                    }

                    return buildBadgeWidget(quantity);
                  }

                  //return const SizedBox.shrink();
                  return buildBadgeWidget(0);
                })),
      ],
    );
  }

  Badge buildBadgeWidget(int quantity) {
    return Badge(
                    smallSize: 15,
                    backgroundColor: const Color(0xffff6969),
                    label: Text(
                      '$quantity',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 10),
                    ),
                  );
  }
  
  void openCartPage(BuildContext context) {
    Navigator.push(
                context, MaterialPageRoute(builder: (_) => CartPage()));
  }


 
}
