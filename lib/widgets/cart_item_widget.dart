import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopify/models/cart.dart';
import 'package:shopify/models/product.model.dart';
import 'package:shopify/providers/cart_provider.dart';
import 'package:shopify/providers/product_provider.dart';
import 'package:shopify/utils/constants/colors_constants.dart';

Widget buildCartItem(BuildContext context, String productId, Cart cartData, Map<String, dynamic>? selectedVarints, int index, BuildContext pageContext) {
    Product? product;

  
    return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FutureBuilder(
                                  future:
                                      Provider.of<ProductProvider>(context)
                                          .getProductById(
                                              productId: productId),
                                  builder: (context, snap) {

if (!snap.hasData) return const Center(child: CircularProgressIndicator());

 //if (snap.hasData) {
                                    if (snap.data != null) {
                                      //===========================================================
                                      product = snap.data;

                                      //===========================================================
                                      Provider.of<CartProvider>(context,
                                              listen: false)
                                          .onAddProductToProductsList(
                                               snap.data!, cartData);



                                               Provider.of<CartProvider>(
                                        context,
                                      ).calculateTotal(cartData);
                                    }

                                    return Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: 45,
                                          child: Image.network(
                                            product?.image ??
                                                "https://firebasestorage.googleapis.com/v0/b/shopify-7f8c4.appspot.com/o/Logo.png?alt=media&token=c761d2ed-96c1-4740-b369-f6745fcc0764",
                                            width: 70,
                                            height: 70,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 25,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  product?.name.toString() ??
                                                      "No name found",
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w500,
                                                    color: ColorsConstants
                                                        .greyTxtColor,
                                                  )),
                                              const SizedBox(
                                                height: 3,
                                              ),
                                              selectedVarints != null
                                                  ? Text(
                                                      '${selectedVarints.keys.map((e) => "$e: ${selectedVarints[e]}")}',
                                                      textAlign:
                                                          TextAlign.left,
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w200,
                                                        color: ColorsConstants
                                                            .greyTxtColor,
                                                      ),
                                                    )
                                                  : const SizedBox.shrink(),
                                              const SizedBox(
                                                height: 7,
                                              ),
                                              Text(
                                                '\$${product?.price ?? ""}',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w300,
                                                  color: ColorsConstants
                                                      .badgeColor,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 7,
                                              ),
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    height: 20,
                                                    width: 20,
                                                    child: FittedBox(
                                                      child:
                                                          FloatingActionButton(
                                                        heroTag: UniqueKey(),
                                                        backgroundColor:
                                                            ColorsConstants
                                                                .iconColor,
                                                        onPressed: () { Provider.of<CartProvider>(
                                                                  context,
                                                                  listen:
                                                                      false)
                                                              .onIncreaseItemQuantityInCart(
                                                                  context:
                                                                      context,
                                                                  itemId: cartData
                                                                      .items![
                                                                          index]
                                                                      .itemId!,
                                                                  cart:
                                                                      cartData);},
                                                        child: const Icon(
                                                          Icons.add,
                                                          size: 40,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 15,
                                                  ),
                                                  Text(
                                                    '${cartData.items![index].quantity}',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color: ColorsConstants
                                                          .iconColor,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 15,
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                    width: 20,
                                                    child: FittedBox(
                                                      child:
                                                          FloatingActionButton(
                                                        heroTag: UniqueKey(),
                                                        backgroundColor:
                                                            ColorsConstants
                                                                .iconColor,
                                                        onPressed: () {
                                                          Provider.of<CartProvider>(
                                                                  context,
                                                                  listen:
                                                                      false)
                                                              .onDecreaseItemQuantityInCart(
                                                                  context:
                                                                      context,
                                                                  itemId: cartData
                                                                      .items![
                                                                          index]
                                                                      .itemId!,
                                                                  cart:
                                                                      cartData);
                                                        },
                                                        child: const Icon(
                                                          Icons.remove,
                                                          size: 40,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 15,
                                                  ),
                                                ],
                                              ),
                                           
                                           
                                           
                                           ],
                                          ),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              Provider.of<CartProvider>(
                                                      context,
                                                      listen: false)
                                                  .onRemoveProductFromCart(
                                                      context: pageContext,
                                                      itemId: cartData
                                                          .items![index]
                                                          .itemId!,
                                                      cart: cartData);
                                            },
                                            icon: const Icon(Icons.delete))
                                      ],
                                    );
                                   
           
      
                                  }
                                  


                                  ),
                            );
  }


