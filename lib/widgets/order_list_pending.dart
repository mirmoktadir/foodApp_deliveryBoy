import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_ex_delivery_app/controllers/notification_order_controller.dart';
import 'package:food_ex_delivery_app/models/order_details.dart';
import 'package:food_ex_delivery_app/utils/font_size.dart';
import 'package:food_ex_delivery_app/utils/size_config.dart';
import 'package:food_ex_delivery_app/utils/theme_colors.dart';
import 'package:food_ex_delivery_app/views/order/notification/no_order_notifaction_page.dart';
import 'package:food_ex_delivery_app/views/order/order_details.dart';
import 'package:get/get.dart';

class PendingOrder extends StatefulWidget {
  const PendingOrder({Key? key}) : super(key: key);

  @override
  _PendingState createState() => _PendingState();
}

class _PendingState extends State<PendingOrder> {
  String acceptDialogue = "Are you sure you want to accept the order?";
  String cancelDialogue = "Are you sure you want to cancel the order?";
  String DialogueAccpet = "Order Accept?";
  String DialogueCancel = "Order Cancel?";

  final order_Controller = Get.put(OrderListController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderListController>(
      init: OrderListController(),
      builder: (orders) => Expanded(
        child: orders.orderList.isEmpty
            ? NoOrderNotification()
            : ListView.builder(
                itemCount: orders.orderList.length,
                physics: const AlwaysScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: (() {
                      Get.to(() => OrderDetailsById(
                            orderId: orders.orderList[index].id,
                          ));
                    }),
                    child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 2.5),
                        width: SizeConfig.screenWidth,
                        //height: SizeConfig.screenHeight!/3.5,
                        child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.access_time),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(orders
                                              .orderList[index].timeFormat
                                              .toString()),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 5, bottom: 5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              padding:
                                                  EdgeInsets.only(right: 5),
                                              height: 30,
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  //  elevation: 0.0,
                                                  primary: Colors
                                                      .green, // background
                                                  // foreground
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10), // <-- Radius
                                                  ),
                                                ),
                                                onPressed: () async {
                                                  setState(() {
                                                    showAlertDialog(
                                                        context,
                                                        DialogueAccpet,
                                                        acceptDialogue,
                                                        '5',
                                                        orders
                                                            .orderList[index].id
                                                            .toString());
                                                    // Get.to(()=>Order_details());
                                                  });
                                                },
                                                child: Text(
                                                  'Accept',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: 30,
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  //  elevation: 0.0,
                                                  primary:
                                                      Colors.red, // background
                                                  onPrimary: Colors
                                                      .white, // foreground
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10), // <-- Radius
                                                  ),
                                                ),
                                                onPressed: () async {
                                                  setState(() {
                                                    showAlertDialog(
                                                        context,
                                                        DialogueCancel,
                                                        cancelDialogue,
                                                        '10',
                                                        orders
                                                            .orderList[index].id
                                                            .toString());
                                                  });
                                                },
                                                child: Text(
                                                  'Reject',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 1),
                                    child: Divider(),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 10, left: 5, right: 5),
                                    child: Row(
                                      children: [
                                        //order id
                                        Text(
                                          "Order Id: #",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16,
                                            //    color: Colors.deepOrange
                                          ),
                                        ),
                                        Text(
                                          orders.orderList[index].id!
                                              .toString(),
                                          style: TextStyle(
                                            color: ThemeColors.scaffoldBgColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: FontSize.xMedium,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 2),
                                    child: Row(
                                      children: [],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 2, horizontal: 5),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Time: ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16
                                              // color: Colors.grey
                                              ),
                                        ),
                                        Text(
                                          orders.orderList[index].createdAt
                                              .toString(),
                                          style: TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            //fontWeight: FontWeight.w300,
                                            fontSize: 13,
                                            color: Colors.grey,
                                            fontFamily: 'AirbnbCerealBold',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 2, horizontal: 5),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Payment mode: ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,

                                            fontSize: 16,
                                            // color: Colors.grey
                                          ),
                                        ),
                                        Text(
                                          orders.orderList[index]
                                              .payment_method_name
                                              .toString(),
                                          style: TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            // fontWeight: FontWeight.w300,
                                            fontSize: 13,
                                            color: Colors.grey,
                                            fontFamily: 'AirbnbCerealBold',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  )
                                ],
                              ),
                            ),
                            elevation: 1,
                            // shadowColor: Colors.blueGrey,

                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              side: BorderSide(
                                width: 0.05,
                              ),
                            ))),
                  );
                }),
      ),
    );
  }

  //shhow alertDialogue

  showAlertDialog(
      BuildContext context, dialogueAccpet, String alertMessage, status, id) {
    int? oId = int.parse(id);

    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Continue"),
      onPressed: () {
        order_Controller.changeStatus(status, id);
        Navigator.of(context).pop();
        Get.to(() => OrderDetailsById(
              orderId: int.parse(id),
            ));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(dialogueAccpet),
      content: Text(alertMessage),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
