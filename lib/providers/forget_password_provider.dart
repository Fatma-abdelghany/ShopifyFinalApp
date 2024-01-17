import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shopify/pages/auth/register_tab_pages.dart';


class ForgetPasswordProvider extends ChangeNotifier {
  late GlobalKey<FormState> formKey;
  late TextEditingController emailController;
 
  void init() {
    formKey = GlobalKey<FormState>();
    emailController = TextEditingController();
    
  }

  void providerDispose() {
    emailController.dispose();
    
  }

 

  Future<void> resetPassword(BuildContext context) async {
    if ((formKey.currentState?.validate() ?? false)) {
      try {
        QuickAlert.show(context: context, type: QuickAlertType.loading);

         await FirebaseAuth.instance
            .sendPasswordResetEmail(email: emailController.text);

        if (context.mounted) {
          await QuickAlert.show(
            context: context,
            type: QuickAlertType.success,
            title: 'Password reset instructions have been sent to email!',
          );

          if (context.mounted) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => const RegisterTabPages()));
          }
        }
      } catch (e) {
        if (!context.mounted) return;
        Navigator.pop(context);

        await QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: 'Forget Password Error $e');
      }
    }
  }
}
