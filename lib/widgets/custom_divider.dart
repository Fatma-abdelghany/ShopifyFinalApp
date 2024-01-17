import 'package:flutter/material.dart';
import 'package:shopify/utils/constants/colors_constants.dart';

Widget customDividerWidget(){
  return Padding(
      padding: const EdgeInsets.only(left: 70.0, right: 25),
      child: Divider(
        color: ColorsConstants.greyTxtColor,
      ),
    );
}