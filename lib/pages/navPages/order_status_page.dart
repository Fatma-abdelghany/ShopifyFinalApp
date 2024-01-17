import 'package:flutter/material.dart';
import 'package:order_tracker/order_tracker.dart';
import 'package:shopify/utils/constants/strings_constants.dart';

class OrderStatusPage extends StatelessWidget {
  const OrderStatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: OrderTracker(
        status: Status.outOfDelivery,
        activeColor: Colors.green,
        inActiveColor: Colors.grey[300],
        orderTitleAndDateList: StringsConstants.ordercheckingList,
        shippedTitleAndDateList: StringsConstants.orderAcceptedList,
        outOfDeliveryTitleAndDateList: StringsConstants.orderInWayList,
        deliveredTitleAndDateList: StringsConstants.orderDeliveredList,
      ),
    );
  }
}
