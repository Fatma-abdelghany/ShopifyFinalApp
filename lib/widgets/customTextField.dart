import 'package:flutter/material.dart';

import '../utils/constants/colors_constants.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.controller,
      required this.isPassword,
      required this.hint,
      this.validatorFun,
      required this.myPrefixIcon,
      required this.type});

  final TextEditingController? controller;
  final bool isPassword;
  final String hint;
  final TextInputType type;
  final Icon myPrefixIcon;
  final String? Function(String?)? validatorFun;
  final Color fillColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword ? true : false,
      obscuringCharacter: "*",
      keyboardType: type,
      validator: validatorFun,
      decoration: InputDecoration(
        label: Text(hint),
        labelStyle: TextStyle(
          color: ColorsConstants.txtFieldLabelColor,
        ),
        border: InputBorder.none,
        hintText: hint,
        filled: true,
        hoverColor: fillColor,
        fillColor: fillColor,
        prefixIcon: myPrefixIcon,
      ),
    );
  }
}
