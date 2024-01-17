import 'package:flutter/material.dart';
import 'package:shopify/models/category.model.dart';
import 'package:shopify/pages/navPages/categories.dart';

import 'category_item_row.home.widget.dart';

// ignore: must_be_immutable
class CategoriesRowHome extends StatelessWidget {
  const CategoriesRowHome({super.key, required this.categories});
  final List<CategoryData> categories;

  @override
  Widget build(BuildContext context) {
    String? selectedCat=categories.first.id;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          ...categories.map((category) => Padding(
                padding: const EdgeInsets.only(right: 15),
                child: CategoryItemRowWidget(
                  categoryData: category,
                ),
              )),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CategoriesPage(categoryIdForFirst: selectedCat,)));
            },
            child: CategoryItemRowWidget(
              categoryData: CategoryData()
                ..title = 'See More'
                ..colors = [
                  Colors.white.value,
                  Colors.white.value,
                ]
                ..shadowColor = 0xfff2f5f9,
              iconWidget: const Icon(
                Icons.arrow_forward_ios_outlined,
                size: 30,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
