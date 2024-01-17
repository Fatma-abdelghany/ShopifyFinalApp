import 'package:flutter/material.dart';

class CategoryListTileWidget extends StatelessWidget {
   CategoryListTileWidget( {super.key, required this.title,});
  final String title;


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
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
            onPressed:(){},
          ),
        ),
      ],
    );
  }
}

// Widget buildCategoryListTileWidget(
//       String title, Function() onBtnPressed) {
//     return Column(
//       children: [
//         ListTile(
//           title: Text(title,
//               style: const TextStyle(
//                 fontSize: 15,
//                 fontWeight: FontWeight.w300,
//                 // color: ColorsConstants.greyTxtColor,
//               )),
//           trailing: IconButton(
//             icon: const Icon(
//               Icons.keyboard_arrow_right,
//               size: 24.0,
//             ),
//             // color: ColorsConstants.buttonColor,
//             onPressed: onBtnPressed,
//           ),
//         ),
//       ],
//     );
//   }

