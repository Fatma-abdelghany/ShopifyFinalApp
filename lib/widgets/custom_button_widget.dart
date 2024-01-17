import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CustomButtonWidget extends StatelessWidget {
  const CustomButtonWidget(
      {required this.text,
      required this.onBtnPressed,
      super.key,
      required this.btnIcon,
      required this.iconColor,
      required this.iconBgColor,
      required this.txtColor,
      required this.bgColor});

  final String text;
  final Function()? onBtnPressed;
  final IconData btnIcon;
  final Color iconColor;
  final Color iconBgColor;
  final Color txtColor;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      width: 160.w,
      child: ElevatedButton(
        onPressed: onBtnPressed,
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          elevation: 20,
          backgroundColor: bgColor,
          
         // shadowColor: Theme.of(context).primaryColor,
          
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, 
        children: [
          const SizedBox(),
          Text(text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                color: txtColor,
              )),
          Container(
            width: 30.h,
            height: 30.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: iconBgColor,
            ),
            child: Icon(
              btnIcon,
              color: iconColor,
              size: 20.0,
            ),
          ),
        ]),
      ),
    );
  }
}
