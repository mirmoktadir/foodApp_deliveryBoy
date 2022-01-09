import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_ex_delivery_app/controllers/global-controller.dart';
import 'package:food_ex_delivery_app/controllers/notification_order_controller.dart';
import 'package:food_ex_delivery_app/utils/font_size.dart';
import 'package:food_ex_delivery_app/utils/size_config.dart';
import 'package:food_ex_delivery_app/utils/theme_colors.dart';
import 'package:food_ex_delivery_app/widgets/shimmer/home_page_shimmer.dart';
import 'package:get/get.dart';
import 'no_order_found_page.dart';
import 'order_details.dart';

class Orderhistory extends StatefulWidget {
  const Orderhistory({Key? key}) : super(key: key);

  @override
  _OrderhistoryState createState() => _OrderhistoryState();
}

class _OrderhistoryState extends State<Orderhistory> {
  final orderListController = Get.put(OrderListController());

  @override
  void initState() {
    orderListController.onInit();
    super.initState();
  }

  Future<Null> _onRefresh() {
    setState(() {
      orderListController.onInit();
    });
    Completer<Null> completer = new Completer<Null>();
    Timer timer = new Timer(new Duration(seconds: 3), () {
      completer.complete();
    });
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderListController>(
      init: OrderListController(),
      builder: (ordersHistory) => ordersHistory.loader
          ? HomePageShimmer()
          : Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: ThemeColors.baseThemeColor,
                foregroundColor: Colors.white,
                centerTitle: true,
                title: Text(
                  'Orders History',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 20),
                ),
              ),
              body: ordersHistory.orderHistoryList.isEmpty
                  ? NoOrderFound()
                  : RefreshIndicator(
                      onRefresh: _onRefresh,
                      child: ListView.builder(
                          itemCount: ordersHistory.orderHistoryList.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: (() {
                                Get.to(OrderDetailsById(
                                    orderId: ordersHistory
                                        .orderHistoryList[index].id));
                              }),
                              child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 2.5),
                                  width: SizeConfig.screenWidth,
                                  child: Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Icon(Icons.access_time),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(ordersHistory
                                                        .orderHistoryList[index]
                                                        .timeFormat
                                                        .toString()),
                                                  ],
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    ordersHistory
                                                        .orderHistoryList[index]
                                                        .statusName
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: ordersHistory
                                                                    .orderHistoryList[
                                                                        index]
                                                                    .status ==
                                                                20
                                                            ? Colors.green
                                                            : ordersHistory
                                                                        .orderHistoryList[
                                                                            index]
                                                                        .status ==
                                                                    14
                                                                ? Colors
                                                                    .lightBlue
                                                                : ordersHistory
                                                                            .orderHistoryList[
                                                                                index]
                                                                            .status ==
                                                                        15
                                                                    ? Colors
                                                                        .deepOrangeAccent
                                                                    : ordersHistory.orderHistoryList[index].status ==
                                                                            5
                                                                        ? Colors.yellow[
                                                                            900]
                                                                        : ThemeColors
                                                                            .baseThemeColor,
                                                        fontWeight:
                                                            FontWeight.w900),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 1),
                                              child: Divider(),
                                            ),
                                            Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 10,
                                                    left: 5,
                                                    right: 5),
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          //order id
                                                          Text(
                                                            "Order Id: #",
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 16,
                                                              //    color: Colors.deepOrange
                                                            ),
                                                          ),
                                                          Text(
                                                            ordersHistory
                                                                .orderHistoryList[
                                                                    index]
                                                                .id
                                                                .toString(),
                                                            style: TextStyle(
                                                              color: ThemeColors
                                                                  .baseThemeColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: FontSize
                                                                  .xMedium,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          //order id
                                                          Text(
                                                            "Total: ",
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 16,
                                                              //    color: Colors.deepOrange
                                                            ),
                                                          ),
                                                          Text(
                                                            Get.find<GlobalController>()
                                                                    .currency! +
                                                                ordersHistory
                                                                    .orderHistoryList[
                                                                        index]
                                                                    .total
                                                                    .toString(),
                                                            style: TextStyle(
                                                              color: ThemeColors
                                                                  .baseThemeColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: FontSize
                                                                  .xMedium,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ])),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 2),
                                              child: Row(
                                                children: [],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 2,
                                                      horizontal: 5),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Time: ",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 16
                                                        // color: Colors.grey
                                                        ),
                                                  ),
                                                  Text(
                                                    ordersHistory
                                                        .orderHistoryList[index]
                                                        .createdAt
                                                        .toString(),
                                                    style: TextStyle(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      //fontWeight: FontWeight.w300,
                                                      fontSize: 13,
                                                      color: Colors.grey,
                                                      fontFamily:
                                                          'AirbnbCerealBold',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 2,
                                                      horizontal: 5),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Payment mode: ",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,

                                                      fontSize: 16,
                                                      // color: Colors.grey
                                                    ),
                                                  ),
                                                  Text(
                                                    ordersHistory
                                                        .orderHistoryList[index]
                                                        .paymentMethodName
                                                        .toString(),
                                                    style: TextStyle(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      // fontWeight: FontWeight.w300,
                                                      fontSize: 13,
                                                      color: Colors.grey,
                                                      fontFamily:
                                                          'AirbnbCerealBold',
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      elevation: 1,
                                      // shadowColor: Colors.blueGrey,

                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        side: BorderSide(
                                          width: 0.05,
                                        ),
                                      ))),
                            );
                          }),
                    ),
            ),
    );
  }
}
