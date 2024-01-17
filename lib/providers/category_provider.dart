import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shopify/models/category.model.dart';
import 'package:shopify/utils/collections.dart';

class CategoryProvider extends ChangeNotifier {
  Future<List<CategoryData>?> getCategories(BuildContext context,
      {int? limit}) async {
    try {
      QuerySnapshot<Map<String, dynamic>>? result;
      if (limit != null) {
        result = await FirebaseFirestore.instance
            .collection(CollectionsUtils.categories.name)
            .limit(limit)
            .get();
      } else {
        result = await FirebaseFirestore.instance
            .collection(CollectionsUtils.categories.name)
            .get();
      }

      if (result.docs.isNotEmpty) {
        var categoriesList = List<CategoryData>.from(
                result.docs.map((e) => CategoryData.fromJson(e.data(), e.id)))
            .toList();

        return categoriesList;
      } else {
        return [];
      }
    } catch (e) {
      if (!context.mounted) return null;
      await QuickAlert.show(
          context: context, type: QuickAlertType.error, title: e.toString());
      return null;
    }
  }

  Future<List<SubCategoryData>?> getsubCategories(
      {required String CategoryId}) async {
    try {
      QuerySnapshot<Map<String, dynamic>>? result;

      result = await FirebaseFirestore.instance
          .collection(CollectionsUtils.subCategories.name)
          .get();

      if (result.docs.isNotEmpty) {
        var allsubCategoriesList = List<SubCategoryData>.from(result.docs
            .map((e) => SubCategoryData.fromJson(e.data(), e.id))).toList();
        var subCategoriesListByCatId = allsubCategoriesList
            .where((subCat) => subCat.categoryId == CategoryId)
            .toList();

        return subCategoriesListByCatId;
      } else {
        return [];
      }
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
