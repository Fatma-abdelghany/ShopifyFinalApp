import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shopify/models/ad.dart';
import 'package:shopify/utils/collections.dart';

class AdsProvider{

   Future<List<AdData>?> getAds(BuildContext context,
      {int? limit}) async {
    try {
      QuerySnapshot<Map<String, dynamic>>? result;
      if (limit != null) {
        result = await FirebaseFirestore.instance
            .collection(CollectionsUtils.ads.name)
            .limit(limit)
            .get();
      } else {
        result =
            await FirebaseFirestore.instance.collection(CollectionsUtils.ads.name).get();
      }

      if (result.docs.isNotEmpty) {
        var adsList = List<AdData>.from(
                result.docs.map((e) => AdData.fromJson(e.data(), e.id)))
            .toList();

        return adsList;
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

}