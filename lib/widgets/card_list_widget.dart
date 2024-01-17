import 'package:flutter/material.dart';
import 'package:shopify/models/cart.dart';
import 'package:shopify/widgets/cart_item_widget.dart';
import 'package:shopify/widgets/order_item.dart';

Widget buildCatList(Cart cartData, BuildContext pageContext,bool isFromCart) {
    return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: cartData.items?.length,
                          itemBuilder: (context, index) {
                            //===========================================================
                            String productId =
                                cartData.items![index].productId!;
                            //===========================================================
                            Map<String, dynamic>? selectedVarints =
                                cartData.items![index].selectedVarints;
                            //===========================================================

                            return isFromCart?
                            buildCartItem(context, productId, cartData, selectedVarints, index, pageContext)
                         :
                          buildOrderItem(context, productId, cartData, selectedVarints, index, pageContext);

                          });
  }
