import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shopify/models/notification.dart';
import 'package:shopify/utils/collections.dart';

class NotificationProvider {
  void addNotification(
      {required BuildContext context,
      required NotificationData notifcation}) async {
    try {
       await FirebaseFirestore.instance
          .collection(CollectionsUtils.notifications.name)
          .add(notifcation.toJson());
    } catch (e) {
      if (!context.mounted) return null;
      await QuickAlert.show(
          context: context, type: QuickAlertType.error, title: e.toString());
      return null;
    }
  }

  Future<List<NotificationData>?> getNotifications(BuildContext context,
      {int? limit}) async {
    try {
      QuerySnapshot<Map<String, dynamic>>? result;

      result = await FirebaseFirestore.instance
          .collection(CollectionsUtils.notifications.name)
          //.limit(limit!)
          .get();

      if (result.docs.isNotEmpty) {
       
             var NotificationList = List<NotificationData>.from(
            result.docs.map((e) => NotificationData.fromJson(e.data(), e.id))).toList();

        return NotificationList;
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
