import 'package:flutter/material.dart';
class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {

  List mycolors = <Color>[
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.purple,
    Colors.orange,
    Colors.indigo,
  ];
  // Color primaryColor = mycolors[0];
   Color primaryColor= Colors.red;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
          children: [
            const Text("SELECT COLOR"),
            buildColorIcons(),

          ],
        ));
  }

  Widget buildColorIcons() => Positioned(
    bottom: 35,
    right: 10,
    child: Row(
      children: [for (var i = 0; i < 6; i++) buildIconBtn(mycolors[i])],
    ),
  );
  Widget buildIconBtn2(Color myColor) => Container(
    child: ActionChip(
      label:const  Icon(
        Icons.check,
        size: 20,
        color:  Colors.white,
      ),
      labelPadding: const EdgeInsets.all(10),
      backgroundColor: Colors.blue,
      shape: const CircleBorder(
        side: BorderSide(
          color: Colors.black,
          width: 1.0,
        ),
      ),
      onPressed: () {
        // Do something when blue swatch is selected
      },
        ),


  );
  Widget buildIconBtn(Color myColor) => Container(
    child: Stack(
      children: [
        Positioned(
          top: 12.5,
          left:12.5,
          child: Icon(
            Icons.check,
            size: 20,
            color: primaryColor == myColor ? myColor : Colors.transparent,
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.circle,
            color: myColor.withOpacity(0.65),
            size: 30,
          ),
          onPressed: () {
            setState(() {
              primaryColor = myColor;
            });
          },
        ),
      ],
    ),
  );
}
