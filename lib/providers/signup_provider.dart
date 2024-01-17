// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shopify/models/user.dart';
import 'package:shopify/pages/navPages/order_status_page.dart';
import 'package:shopify/utils/collections.dart';

import '../pages/navPages/master_page.dart';

class SignUpProvider extends ChangeNotifier {
  UserModel? userData = UserModel();
  late GlobalKey<FormState> formKey;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController nameController;
  late TextEditingController phoneController;

  final _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  void init() {
    formKey = GlobalKey<FormState>();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    nameController = TextEditingController();
    phoneController = TextEditingController();
  }

  void providerDispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    phoneController.dispose();
  }

  Future<void> signUp(BuildContext context) async {
    if ((formKey.currentState?.validate() ?? false)) {
      try {
        QuickAlert.show(context: context, type: QuickAlertType.loading);

        var credintials = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);

        // userData!.name = nameController.text;
        // userData!.mail = emailController.text;
        // userData!.phone = phoneController.text;
        // userData!.Adddress = "addd";
        // userData!.image = "";
        if (context.mounted) {
          Navigator.pop(context);
          if (credintials.user != null) {
            await FirebaseFirestore.instance
                .collection(CollectionsUtils.users.name)
                .doc(currentUser?.uid)
                .set({
              "name": nameController.text,
              "mail": emailController.text,
              "Adddress": "not now",
              "phone": phoneController.text,
              "image":
                  "https://firebasestorage.googleapis.com/v0/b/shopify-7f8c4.appspot.com/o/Logo.png?alt=media&token=c761d2ed-96c1-4740-b369-f6745fcc0764",
            });
            //.set(userData!.toJson());

            await QuickAlert.show(
                context: context,
                type: QuickAlertType.success,
                title: 'You Signup Successfully');

            if (context.mounted) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) => const MasterPage()));
            }
          } else {
            await QuickAlert.show(
                context: context,
                type: QuickAlertType.error,
                title: 'Error In Signup');
          }
        }
      } on FirebaseAuthException catch (e) {
        if (!context.mounted) return;
        Navigator.pop(context);
        if (e.code == 'email-already-in-use') {
          await QuickAlert.show(
              context: context,
              type: QuickAlertType.error,
              title: 'This Email Already in use');
        } else if (e.code == 'weak-password') {
          await QuickAlert.show(
              context: context,
              type: QuickAlertType.error,
              title: 'Weak Password');
        }
      } catch (e) {
        if (!context.mounted) return;
        Navigator.pop(context);

        await QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: 'Signup Error ${e}');
      }
    }
  }

  Future<UserModel?> getUserData() async {
    try {
      DocumentSnapshot<Map<String, dynamic>>? result;

      result = await FirebaseFirestore.instance
          .collection(CollectionsUtils.users.name)
          .doc(currentUser?.uid)
          .get();
  
      if (result.exists) {
        return UserModel.fromJson(result.data() ?? {}, currentUser!.uid);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  
  }

  Future updateUserData(BuildContext context, String address) async {
    try {
      DocumentSnapshot<Map<String, dynamic>>? result;

      result = await FirebaseFirestore.instance
          .collection(CollectionsUtils.users.name)
          .doc(currentUser?.uid)
          .get();

      if (result.exists) {
        var userData =
            UserModel.fromJson(result.data() ?? {}, currentUser!.uid);
        userData.Adddress = address;

        await FirebaseFirestore.instance
            .collection(CollectionsUtils.users.name)
            .doc(currentUser?.uid)
            .update(userData.toJson());

        await QuickAlert.show(
            context: context,
            type: QuickAlertType.success,
            title: 'Your Address Added Successfully');
      } else {
        return null;
      }
    } catch (e) {
      await QuickAlert.show(
          context: context, type: QuickAlertType.error, title: e.toString());
    }
  }

  Future updateUserImage(BuildContext context, String imageUrl) async {
    try {
      DocumentSnapshot<Map<String, dynamic>>? result;

      result = await FirebaseFirestore.instance
          .collection(CollectionsUtils.users.name)
          .doc(currentUser?.uid)
          .get();

      if (result.exists) {
        var userData =
            UserModel.fromJson(result.data() ?? {}, currentUser!.uid);
        userData.image = imageUrl;

        await FirebaseFirestore.instance
            .collection(CollectionsUtils.users.name)
            .doc(currentUser?.uid)
            .update(userData.toJson());

        await QuickAlert.show(
            context: context,
            type: QuickAlertType.success,
            title: 'Your Address Added Successfully');
      } else {
        return null;
      }
    } catch (e) {
      await QuickAlert.show(
          context: context, type: QuickAlertType.error, title: e.toString());
    }
  }
}
