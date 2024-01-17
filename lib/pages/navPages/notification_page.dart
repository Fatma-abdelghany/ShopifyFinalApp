import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopify/providers/notification_provider.dart';
import 'package:shopify/utils/constants/colors_constants.dart';
import 'package:shopify/widgets/app_bar_ex.widget.dart';
import 'package:shopify/widgets/headline.widget.dart';

class NotificatonPage extends StatefulWidget {
  const NotificatonPage({super.key});

  @override
  State<NotificatonPage> createState() => _NotificatonPageState();
}

class _NotificatonPageState extends State<NotificatonPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarEx.getAppBarWithClosedIcon(context),
        body: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Consumer<NotificationProvider>(
                  builder: (__, notificationProvider, _) {
                return Builder(builder: (context) {
                  return FutureBuilder(
                      future: notificationProvider.getNotifications(context,limit:12),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.connectionState ==
                            ConnectionState.done) {
                          if (snapshot.hasError) {
                            return const Text('Error While Get Data');
                          } else if (snapshot.hasData) {
                            //categoryIdForFirst = snapshot.data!.first.id;
                            // debugPrint("xxxxxxxxxxxxxxxxx$categoryIdForFirst");
                            return Column(
                              children: [
                                const HeadlineWidget(title: 'NotifiCations'),
                                SizedBox(
                                  height: 15,
                                ),
                                ListView.separated(
                                    separatorBuilder: (context, index) {
                                      return Padding(
                                        padding: EdgeInsets.only(
                                            left: 70.0, right: 15),
                                        child: Divider(
                                          color: ColorsConstants.greyTxtColor,
                                        ),
                                      );
                                    },
                                    shrinkWrap: true,
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (_, index) {
                                      return ListTile(
                                        leading: CircleAvatar(
                                          backgroundColor: Colors.primaries[
                                              Random().nextInt(
                                                  Colors.primaries.length)],
                                          child: Image.asset(
                                              "assets/images/notif_icon.png"),
                                        ),
                                        title: Text(snapshot.data![index].title.toString(),
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w300,
                                              color:
                                                  ColorsConstants.greyTxtColor,
                                            )),
                                        trailing: Text(snapshot.data![index].createdAt.toString(),
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: Color(0xff515c6f),
                                            )),
                                      );
                                    })
                              ],
                            );
                          } else {
                            return const Text('No Data Found');
                          }
                        } else {
                          return Text(
                              'Connection Statue ${snapshot.connectionState}');
                        }
                      });
                });
              })),
        ));
  }
}
