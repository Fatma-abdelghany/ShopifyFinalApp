import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:order_tracker/order_tracker.dart';
import 'package:shopify/utils/constants/colors_constants.dart';

class StringsConstants{

  static const String login="Log In";
  static const String logout="Log Out";
  static const String forgetPassword="ForgetPassword";
  static const String signUP="SignUp";

  static const String intro3Title="Free Delivery";
  static const String intro2Title="Easy To Buy";
  static const String intro1Title="New Collection";

  static const String intro1desc="Welcome to Shpify App, Let’s shop!";
  static const String intro2desc="We help people conect with store \naround Egypt";
  static const String intro3desc="We show the easy way to shop. \nJust stay at home with us";


  

  //login strings
  static const String userNameOrEmail="USERNAME/EMAIL";
  static const String userName="USERNAME";
  static const String email="EMAIL ADDRESS";
  static const String password="PASSWORD";
  static const String phone="Phone";
  static const String validEmail="Enter Valid Email";
  static const String validGmail="Enter Valid Gmail";
  static const String validPassword="Password must be 8 ";
  static const String emailRequired="Email is required";
  static const String phoneRequired="Phone is required";
  static const String userNameRequired="UserName is required";
  static const String passwordRequired="Password is required";
  static const String createAccount="create a new account.";
  static const String notHaveAccount="Don’t have an account? ";

  //sign up strings

  //forgetPassword strings

  static const String forgetPasswordHint="  Enter the email address you used to create\nyour account and we will email you a link to\nreset your password";
  static const String sendEmail="SEND EMAIL";

  static const String categories='Categories';



  static const String addToCart='ADD TO CART';
  static const String orderNow='Order Now';
  static const String shippingAddress='Shipping Address';

  static const String checkOut='CheckOut';
  static const String save='Save';
  static const String orderStatus='Order Status';
  static const String cart='Cart';
  static const String total='Total';
  static const String items='Items';
  static const String freeShipping='Free Domestic shipping';
  static const String orderPlaced='Order Placed!';
  static const String orderPlacedSuccessfully='Your order was placed successfully';
  static const String orderPlacedSuccessfullyDetails='   For More Details,Check Order Status ';

  static const String addAddressTitle='Please Enter Your Address';
  static const String addressHint='23 main Street, Mansoura,Eygpt';




 static   List<TextDto> ordercheckingList = [
    TextDto("Your order has been placed", null),
    TextDto("Seller ha processed your order",null),
    TextDto("Your item has been picked up by courier partner.", null),
  ];

   static List<TextDto> orderAcceptedList = [
    TextDto("Your order is accepted",null),
  ];


  static List<TextDto> orderInWayList = [
    TextDto("Your order has been shipped", null),
    TextDto("Your item has been received in the nearest hub to you.", null),
  ];

 
  static List<TextDto> orderDeliveredList = [
   // TextDto("Your order has been delivered", "Thu, 31th Mar '22 - 3:58pm"),
    TextDto("Your order has been delivered",null)
  ];

static satusBarColor(){
   SystemChrome.setSystemUIOverlayStyle( SystemUiOverlayStyle(
      statusBarColor: ColorsConstants.bgColor,
      statusBarBrightness: Brightness.dark,
    ));

}

 static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

}