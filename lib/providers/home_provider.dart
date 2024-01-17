import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopify/models/ad.dart';
import 'package:shopify/utils/collections.dart';

class HomeProvider extends ChangeNotifier {
  List<AdData>? adList;

  void initHomeProvider() async {
    await getAds();
  }

  Future<void> getAds() async {
    QuerySnapshot<Map<String, dynamic>> result = await FirebaseFirestore
        .instance
        .collection(CollectionsUtils.ads.name)
        .get();
    adList =
        List<AdData>.from(result.docs.map((e) => AdData.fromJson(e.data(), e.id)));
    notifyListeners();
  }
}