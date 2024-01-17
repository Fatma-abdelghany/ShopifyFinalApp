import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shopify/providers/signup_provider.dart';

import '../../utils/constants/colors_constants.dart';
import '../../utils/constants/strings_constants.dart';
import '../../widgets/customTextField.dart';

import '../../widgets/customButton.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  void initState() {
    Provider.of<SignUpProvider>(context, listen: false).init();

    super.initState();
  }

  @override
  void deactivate() {
    Provider.of<SignUpProvider>(context, listen: false).providerDispose();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Center(child: Consumer<SignUpProvider>(
          builder: (context, signUpProvider, _) {
            return Form(
              key: signUpProvider.formKey,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        )),
                    child: Column(
                      children: [

    //=========================userName===============================                    
                        CustomTextField(
                          controller: signUpProvider.nameController,
                          isPassword: false,
                          hint: StringsConstants.userName,
                          myPrefixIcon: Icon(
                            Icons.person_outlined,
                            color: ColorsConstants.iconColor,
                            size: 25,
                          ),
                          type: TextInputType.text,
                          validatorFun: (value) {
                            if (value == null || value == "") {
                              return StringsConstants.userNameRequired;
                            }
                            
                            return null;
                          },
                        ),
                        const Divider(color: Color(0x9bd7d3d3)),

             //=========================Email===============================                    

                          CustomTextField(
                          controller: signUpProvider.emailController,
                          isPassword: false,
                          hint: StringsConstants.email,
                          myPrefixIcon: Icon(
                            Icons.mail_outlined,
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
             //=========================Phone===============================                    


CustomTextField(
                          controller: signUpProvider.phoneController,
                          isPassword: false,
                          hint: StringsConstants.phone,
                          myPrefixIcon: const Icon(Icons.phone_outlined),
                          type: TextInputType.phone,
                          validatorFun: (value) {
                            if (value == null || value == "") {
                              return StringsConstants.phoneRequired;
                            }

                            return null;
                          },
                        ),

                
                      ]
                    )
                    ),

                   SizedBox(
                    height: 20.h,
                  ),
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        )),
                    child: CustomTextField(
                      controller: signUpProvider.passwordController,
                      isPassword: true,
                      hint: StringsConstants.password,
                      myPrefixIcon: const Icon(Icons.lock_outline_rounded),
                      type: TextInputType.emailAddress,
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
                  ),
                   
                   SizedBox(height: 10.h),
                  CustomButton(
                      text: StringsConstants.signUP,
                      onBtnPressed: () async {
                        await signUpProvider.signUp(context);
                      }),
                  
                ],
              ),
           
               
            
              );
          },
        )),
      ),
    );
  }
}
