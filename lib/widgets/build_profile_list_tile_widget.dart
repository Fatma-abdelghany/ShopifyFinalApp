import 'package:flutter/material.dart';

Widget buildProfileListTileWidget(
      String title, IconData icon, Function() onBtnPressed) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon),
          title: Text(title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w300,
                // color: ColorsConstants.greyTxtColor,
              )),
          trailing: IconButton(
            icon: const Icon(
              Icons.keyboard_arrow_right,
              size: 24.0,
            ),
            // color: ColorsConstants.buttonColor,
            onPressed: onBtnPressed,
          ),
        ),
      ],
    );
  }

