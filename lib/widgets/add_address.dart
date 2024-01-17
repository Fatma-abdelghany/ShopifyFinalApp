import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shopify/pages/order_page.dart';
import 'package:shopify/providers/signup_provider.dart';
import 'package:shopify/utils/constants/strings_constants.dart';

class AddAdress extends StatelessWidget {
   AddAdress({super.key});
  TextEditingController txtFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpProvider>(
      builder: (context, signUpProvider, _) {
        return Container(
          height: 250.h,
          color: Colors.grey[200],
          child: AlertDialog(
            title: const Text(StringsConstants.addAddressTitle),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: txtFieldController,
                  decoration: InputDecoration(
                    hintText: (StringsConstants.addressHint),
                    filled: true,
                    fillColor: Colors.grey[150],
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50)),
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: const Text(StringsConstants.save),
                onPressed: () async {
                  String address = txtFieldController.text;
                  if (address.isNotEmpty) {
                   await signUpProvider.updateUserData(context, address);

                    await Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const OrderPage()));
                  }

                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        );
      },
    );
  }
}
