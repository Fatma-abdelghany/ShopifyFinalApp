import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shopify/models/category.model.dart';
import 'package:shopify/services/prefrences.service.dart';

import 'category_item_row.home.widget.dart';

class CategoriesColumnHome extends StatefulWidget {
  CategoriesColumnHome(
      {super.key,
      required this.categories,
      required this.selectedCategoryCallBack});
  final List<CategoryData> categories;
  final void Function(String) selectedCategoryCallBack;

  @override
  State<CategoriesColumnHome> createState() => _CategoriesColumnHomeState();
}

class _CategoriesColumnHomeState extends State<CategoriesColumnHome> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          ...widget.categories.map(
            (category) => Padding(
              padding: const EdgeInsets.only(right: 15, bottom: 5),
              child: InkWell(
                onTap: () {
                  widget.selectedCategoryCallBack.call(category.id!);
                },
                child: CategoryItemRowWidget(
                  categoryData: category,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}
