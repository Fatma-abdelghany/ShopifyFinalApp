import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopify/models/product.model.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({super.key, required this.product, this.onTap});
  final Product product;
   final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xffffffff),
            boxShadow: const [
              BoxShadow(
                  color: Color(0xffe7eaf0), spreadRadius: 5, blurRadius: 10),
            ]),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                product.image ?? '',
                width: 85.w,
                height: 75.h,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  product.name ?? 'No Name',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                    color: Color(0xff515c6f),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '\$${product.price}',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff515c6f),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}