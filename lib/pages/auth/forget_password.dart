import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shopify/providers/forget_password_provider.dart';

import '../../utils/constants/colors_constants.dart';
import '../../utils/constants/strings_constants.dart';
import '../../widgets/customButton.dart';
import '../../widgets/customTextField.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  @override
  void initState() {
    Provider.of<ForgetPasswordProvider>(context, listen: false).init();

    super.initState();
  }

  @override
  void deactivate() {
    Provider.of<ForgetPasswordProvider>(context, listen: false).providerDispose();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child:
            Consumer<ForgetPasswordProvider>(builder: (context, appAuthProvider, _) {
          return Form(
            key: appAuthProvider.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30.h,
                ),
                // Center(child: GreyTxt(label: StringsConstants.forgetPasswordHint,)),
                const Center(
                  child: Text(
                    StringsConstants.forgetPasswordHint,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: CustomTextField(
                    controller: appAuthProvider.emailController,
                    isPassword: false,
                    hint: StringsConstants.userNameOrEmail,
                    myPrefixIcon: Icon(
                      Icons.person_outlined,
                      color: ColorsConstants.iconColor,
                      size: 25,
                    ),
                    type: TextInputType.emailAddress,
                    validatorFun: (value) {
                      if (value == null || value == "") {
                        return StringsConstants.emailRequired;
                      }
                      if (!EmailValidator.validate(value)) {
                        return StringsConstants.validEmail;
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                CustomButton(
                    text: StringsConstants.sendEmail,
                    onBtnPressed: () async {
                      await appAuthProvider.resetPassword(context);
                    }),
              ],
            ),
          );
        }),
      ),
    );
  }
}
