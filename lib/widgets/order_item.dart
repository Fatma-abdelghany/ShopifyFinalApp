import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shopify/models/cart.dart';
import 'package:shopify/models/product.model.dart';
import 'package:shopify/providers/cart_provider.dart';
import 'package:shopify/providers/product_provider.dart';
import 'package:shopify/utils/constants/colors_constants.dart';

Widget buildOrderItem(BuildContext context, String productId, Cart cartData, Map<String, dynamic>? selectedVarints, int index, BuildContext pageContext) {
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
                                            width: 70.h,
                                            height: 70.h,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                       SizedBox(
                                          width: 25.w,
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
                                                    fontSize: 15.sp,
                                                    fontWeight:
                                                        FontWeight.w500,
                                                    color: ColorsConstants
                                                        .greyTxtColor,
                                                  )),
                                               SizedBox(
                                                height: 3.h,
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
                                              SizedBox(
                                                height: 7.h,
                                              ),
                                              Row(
                                  mainAxisAlignment:MainAxisAlignment.spaceBetween ,             
                                   children: [
                                                  Text(
                                                    '\$${product?.price ?? ""}',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      fontSize: 15.sp,
                                                      fontWeight: FontWeight.w300,
                                                      color: ColorsConstants
                                                          .badgeColor,
                                                    ),
                                                  ),
                                                   Row(
                                                children: [
                                                  SizedBox(
                                                    height: 20.h,
                                                    width: 20.w,
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
                                                   SizedBox(
                                                    width: 15.w,
                                                  ),
                                                  Text(
                                                    '${cartData.items![index].quantity}',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      fontSize: 15.sp,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color: ColorsConstants
                                                          .iconColor,
                                                    ),
                                                  ),
                                                   SizedBox(
                                                    width: 15.h,
                                                  ),
                                                  SizedBox(
                                                    height: 20.h,
                                                    width: 20.w,
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
                                                   SizedBox(
                                                    width: 15.w,
                                                  ),
                                                ],
                                              ),
                                           
                                           
                                           
                                                ],
                                              ),
                                               SizedBox(
                                                height: 10.h,
                                              ),
                                            
                                               const Divider() 
                                            
                                            
                                            
                                            
                                            
                                            
                                            
                                            ],
                                          ),
                                        ),
                                        
                                      ],
                                    );
                                   
      
                                  }
                                  


                                  ),
                            );
  }


