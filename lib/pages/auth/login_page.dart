import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../providers/app_auth_provider.dart';
import '../../utils/constants/colors_constants.dart';
import '../../utils/constants/strings_constants.dart';
import '../../widgets/customButton.dart';
import '../../widgets/customTextField.dart';
import '../../widgets/grey_txt.dart';
import '../../widgets/red_txt.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    Provider.of<AppAuthProvider>(context, listen: false).init();

    super.initState();
  }

  @override
  void deactivate() {
    Provider.of<AppAuthProvider>(context, listen: false).providerDispose();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Center(
          child: Consumer<AppAuthProvider>(
            builder: (context, appAuthProvider, _) {
              return Form(
                key: appAuthProvider.formKey,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      child: Column(
                        children: [
                          CustomTextField(
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
                              } else {
                                if (!value.split('@').last.contains('gmail')) {
                                  return StringsConstants.validGmail;
                                }
                              }
                              return null;
                            },
                          ),
                          const Divider(color: Color(0x9bd7d3d3)),
                          CustomTextField(
                            controller: appAuthProvider.passwordController,
                            isPassword: true,
                            hint: StringsConstants.password,
                            myPrefixIcon: Icon(
                              Icons.lock_outline_rounded,
                              color: ColorsConstants.iconColor,
                              size: 25,
                            ),
                            type: TextInputType.text,
                            validatorFun: (value) {
                              if (value == null || value == "") {
                                return StringsConstants.passwordRequired;
                              }
                              if (value.length < 8) {
                                return StringsConstants.validPassword;
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                     SizedBox(height: 10.h),
                    CustomButton(
                        text: StringsConstants.login,
                        onBtnPressed: () async {
                          await appAuthProvider.login(context);
                        }),
                     SizedBox(height: 40.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Center(
                          child: GreyTxt(
                            label: StringsConstants.notHaveAccount,
                          ),
                        ),
                        TextButton(
                          child: const RedTxt(label: StringsConstants.createAccount),
                          onPressed: () {
                            //signup screen
                          },
                        )
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
