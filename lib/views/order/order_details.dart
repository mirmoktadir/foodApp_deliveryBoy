import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_ex_delivery_app/controllers/global-controller.dart';
import 'package:food_ex_delivery_app/controllers/order_details_controller.dart';
import 'package:food_ex_delivery_app/utils/font_size.dart';
import 'package:food_ex_delivery_app/utils/images.dart';
import 'package:food_ex_delivery_app/utils/size_config.dart';
import 'package:food_ex_delivery_app/utils/theme_colors.dart';
import 'package:food_ex_delivery_app/widgets/order_detils_bottom_bar.dart';
import 'package:food_ex_delivery_app/widgets/shimmer/oder_details_shimmer.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderDetailsById extends StatefulWidget {
  int? orderId;
  OrderDetailsById({Key? key, this.orderId}) : super(key: key);

  @override
  _OrderDetailsByIdState createState() => _OrderDetailsByIdState();
}

class _OrderDetailsByIdState extends State<OrderDetailsById> {
  int statusValue = 0;
  int statusActive = 1;
  final settingsController = Get.put(GlobalController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig sizeConfig = SizeConfig();
    sizeConfig.init(context);
    var orderDetailsController =
        Get.put(OrderDetailsController(widget.orderId));
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      orderDetailsController.onInit();
      print("onMessage data: ${message.data}");
    });
    Future<Null> _onRefresh() {
      setState(() {
        orderDetailsController.onInit();
      });
      Completer<Null> completer = new Completer<Null>();
      Timer timer = new Timer(new Duration(seconds: 3), () {
        completer.complete();
      });
      return completer.future;
    }

    return GetBuilder<OrderDetailsController>(
      init: OrderDetailsController(widget.orderId),
      builder: (orderDetails) => orderDetails.loader
          ? Order_detailsShimmer()
          : Scaffold(
              appBar: AppBar(
                title: Text(
                  "Order Details",
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: FontSize.xLarge,
                    color: Colors.white,
                  ),
                ),
                backgroundColor: ThemeColors.baseThemeColor,
                centerTitle: true,
                elevation: 0.0,
              ),
              bottomNavigationBar: Order_details_bottom_bar(
                subTotal:
                    orderDetails.orderDetailsByIdData!.subTotal.toString(),
                deliveryFee: orderDetails.orderDetailsByIdData!.deliveryCharge
                    .toString(),
                total: orderDetails.orderDetailsByIdData!.total,
                orderID: orderDetails.orderDetailsByIdData!.id,
                statusCode: orderDetails.statusCode,
              ),
              body: RefreshIndicator(
                onRefresh: _onRefresh,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    statusActive = 1;
                                  });
                                },
                                child: Container(
                                  height: 50,
                                  width: 150,
                                  decoration: statusActive == 1
                                      ? BoxDecoration(
                                          color: ThemeColors.baseThemeColor,
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        )
                                      : BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          border: Border.fromBorderSide(
                                            BorderSide(
                                              color: ThemeColors.baseThemeColor,
                                            ),
                                          ),
                                        ),
                                  child: Center(
                                      child: Text('Details',
                                          style: TextStyle(
                                              color: statusActive == 1
                                                  ? Colors.white
                                                  : ThemeColors
                                                      .baseThemeColor))),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    statusActive = 2;
                                  });
                                },
                                child: Container(
                                  height: 50,
                                  width: 150,
                                  decoration: statusActive == 2
                                      ? BoxDecoration(
                                          color: ThemeColors.baseThemeColor,
                                          borderRadius:
                                              BorderRadius.circular(40))
                                      : BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          border: Border.fromBorderSide(
                                            BorderSide(
                                              color: ThemeColors.baseThemeColor,
                                            ),
                                          ),
                                        ),
                                  child: Center(
                                    child: Text(
                                      'Tracking Order',
                                      style: TextStyle(
                                        color: statusActive == 2
                                            ? Colors.white
                                            : ThemeColors.baseThemeColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        statusActive == 1
                            ? ListView(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(
                                              top: 20, bottom: 10, left: 15),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.shopping_basket_outlined,
                                                color:
                                                    ThemeColors.baseThemeColor,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                "Shop details",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16,
                                                    color: ThemeColors
                                                        .scaffoldBgColor),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: SizeConfig.screenWidth,
                                          child: Card(
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                  top: 10,
                                                  bottom: 10,
                                                  left: 5,
                                                  right: 5),
                                              child: Row(
                                                children: [
                                                  //shop image container
                                                  CachedNetworkImage(
                                                    imageUrl: orderDetails
                                                        .orderDetailsByIdData!
                                                        .restaurant!
                                                        .logo!,
                                                    imageBuilder: (context,
                                                            imageProvider) =>
                                                        Container(
                                                            width: SizeConfig
                                                                    .screenWidth! /
                                                                4,
                                                            height: SizeConfig
                                                                    .screenWidth! /
                                                                4,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius: BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          10.0),
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          10.0)),
                                                            ),
                                                            child: Image(
                                                                image:
                                                                    imageProvider)),
                                                    placeholder:
                                                        (context, url) =>
                                                            Shimmer.fromColors(
                                                      baseColor:
                                                          Colors.grey[300]!,
                                                      highlightColor:
                                                          Colors.grey[400]!,
                                                      child: Container(
                                                        width: SizeConfig
                                                                .screenWidth! /
                                                            4,
                                                        height: SizeConfig
                                                                .screenWidth! /
                                                            4,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          10.0),
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          10.0)),
                                                        ),
                                                        child: Image(
                                                          image: AssetImage(
                                                              Images.food2),
                                                        ),
                                                      ),
                                                    ),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Icon(
                                                      Icons.error,
                                                      color: ThemeColors
                                                          .baseThemeColor,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),

                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          orderDetails
                                                              .orderDetailsByIdData!
                                                              .restaurant!
                                                              .name
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 16,
                                                              color: ThemeColors
                                                                  .scaffoldBgColor),
                                                        ),
                                                        SizedBox(
                                                          height: 2,
                                                        ),
                                                        Text(
                                                          orderDetails
                                                              .orderDetailsByIdData!
                                                              .restaurant!
                                                              .address
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              fontSize: 14,
                                                              color: ThemeColors
                                                                  .greyTextColor),
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        SizedBox(
                                                          height: 1,
                                                        ),
                                                        Text(
                                                          "Time : ${orderDetailsController.orderDetailsByIdData!.restaurant!.openingTime}"
                                                          "-${orderDetailsController.orderDetailsByIdData!.restaurant!.closingTime}",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              fontSize: 14,
                                                              color: ThemeColors
                                                                  .greyTextColor),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    orderDetails.statusCode! >= 17
                                        ? Customer_details(orderDetails)
                                        : Container(
                                            height: 0,
                                          ),
                                    Container(
                                      padding: EdgeInsets.only(
                                          top: 20, bottom: 10, left: 15),
                                      child: Row(
                                        children: [
                                          Text(
                                            "Ordered Foods",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                                color: ThemeColors
                                                    .scaffoldBgColor),
                                          ),
                                        ],
                                      ),
                                    ),
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      itemCount: orderDetails
                                          .orderDetailsByIdData!.items!.length,
                                      itemBuilder: (context, index) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            //SizedBox(height: 20,),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  left: 15,
                                                  right: 15,
                                                  bottom: 2),
                                            ),
                                            Card(
                                              elevation: 1,
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 2),
                                                child: ListTile(
                                                  leading: CachedNetworkImage(
                                                    imageUrl: orderDetails
                                                        .orderDetailsByIdData!
                                                        .items![index]
                                                        .menuItem!
                                                        .image!,
                                                    imageBuilder: (context,
                                                            imageProvider) =>
                                                        Container(
                                                      height: SizeConfig
                                                              .screenWidth! /
                                                          5,
                                                      width: SizeConfig
                                                              .screenWidth! /
                                                          5,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        image: DecorationImage(
                                                            image:
                                                                imageProvider,
                                                            fit: BoxFit.fill),
                                                      ),
                                                    ),
                                                    placeholder:
                                                        (context, url) =>
                                                            Shimmer.fromColors(
                                                      baseColor:
                                                          Colors.grey[300]!,
                                                      highlightColor:
                                                          Colors.grey[400]!,
                                                      child: Container(
                                                        width: SizeConfig
                                                                .screenWidth! /
                                                            4,
                                                        height: SizeConfig
                                                                .screenWidth! /
                                                            4,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          10.0),
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          10.0)),
                                                        ),
                                                        child: Image(
                                                          image: AssetImage(
                                                              Images.food1),
                                                        ),
                                                      ),
                                                    ),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Icon(
                                                      Icons.error,
                                                      color: ThemeColors
                                                          .baseThemeColor,
                                                    ),
                                                  ),
                                                  title: Text(
                                                    orderDetails
                                                        .orderDetailsByIdData!
                                                        .items![index]
                                                        .menuItem!
                                                        .name
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontSize:
                                                          FontSize.xMedium,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  subtitle: Text(
                                                    Get.find<GlobalController>()
                                                            .currency! +
                                                        orderDetails
                                                            .orderDetailsByIdData!
                                                            .items![index]
                                                            .unitPrice
                                                            .toString() +
                                                        ' X ' +
                                                        orderDetails
                                                            .orderDetailsByIdData!
                                                            .items![index]
                                                            .quantity
                                                            .toString() +
                                                        ' = ' +
                                                        orderDetails
                                                            .orderDetailsByIdData!
                                                            .items![index]
                                                            .itemTotal
                                                            .toString(),
                                                    style: TextStyle(
                                                      overflow:
                                                          TextOverflow.fade,
                                                      fontSize: FontSize.medium,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                    ),
                                                  ),
                                                  trailing: Column(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          Get.find<GlobalController>()
                                                                  .currency! +
                                                              orderDetails
                                                                  .orderDetailsByIdData!
                                                                  .items![index]
                                                                  .itemTotal
                                                                  .toString(),
                                                          style: TextStyle(
                                                            fontSize:
                                                                FontSize.medium,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          orderDetails
                                                              .orderDetailsByIdData!
                                                              .timeFormat
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              fontSize: FontSize
                                                                  .medium,
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                    settingsController.support_phone == null
                                        ? Container()
                                        : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.only(
                                                    top: 20,
                                                    bottom: 10,
                                                    left: 15),
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                        FontAwesomeIcons
                                                            .phoneVolume,
                                                        color: ThemeColors
                                                            .baseThemeColor),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      "Support Number",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 16,
                                                          color: ThemeColors
                                                              .scaffoldBgColor),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: SizeConfig.screenWidth,
                                                child: Card(
                                                  child: Container(
                                                    padding: EdgeInsets.only(
                                                        top: 10,
                                                        bottom: 10,
                                                        left: 5,
                                                        right: 5),
                                                    child: Row(
                                                      children: [
                                                        //shop image container
                                                        Icon(
                                                          FontAwesomeIcons
                                                              .headset,
                                                          color: ThemeColors
                                                              .baseThemeColor,
                                                          size: 40,
                                                        ),
                                                        SizedBox(
                                                          width: 30,
                                                        ),

                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                'Call your support',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        16,
                                                                    color: ThemeColors
                                                                        .scaffoldBgColor),
                                                              ),
                                                              SizedBox(
                                                                height: 2,
                                                              ),
                                                              Text(
                                                                '${settingsController.support_phone.toString()}',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w300,
                                                                    fontSize:
                                                                        14,
                                                                    color: ThemeColors
                                                                        .greyTextColor),
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        IconButton(
                                                          onPressed: () {
                                                            _makePhoneCall(
                                                                settingsController
                                                                    .support_phone
                                                                    .toString());
                                                          },
                                                          icon: Icon(
                                                            Icons.phone_enabled,
                                                            color: ThemeColors
                                                                .baseThemeColor,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                  ])
                            : Container(),
                        //order id container
                        statusActive == 2
                            ? ListView(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                children: [
                                    Container(
                                      child: Theme(
                                        data: ThemeData(
                                          colorScheme:
                                              ColorScheme.fromSwatch().copyWith(
                                            primary: ThemeColors.baseThemeColor,
                                          ),
                                        ),
                                        child: Stepper(
                                          physics: ClampingScrollPhysics(),
                                          controlsBuilder:
                                              (BuildContext context,
                                                  {VoidCallback? onStepContinue,
                                                  VoidCallback? onStepCancel}) {
                                            return SizedBox(height: 0.0);
                                          },
                                          steps: getTrackingSteps(
                                              context,
                                              orderDetails.statusName,
                                              orderDetails.statusCode
                                                  .toString()),
                                          currentStep: statusValue,
                                        ),
                                      ),
                                    ),
                                  ])
                            : Container(),
                      ]),
                ),
              ),
            ),
    );
  }

  List<Step> getTrackingSteps(BuildContext context, statusName, status) {
    List<Step> _orderStatusSteps = [];
    if (status == '10') {
      _orderStatusSteps.add(Step(
        state: StepState.complete,
        title: Text(
          'Order Cancel',
          style: Theme.of(context).textTheme.subtitle1,
        ),
        content: SizedBox(
            width: double.infinity,
            child: Text(
              '',
            )),
        isActive: int.tryParse(status)! >= int.tryParse('10')!,
      ));
    } else {
      _orderStatusSteps.add(Step(
        state: StepState.complete,
        title: Text(
          'Order Pending',
          style: Theme.of(context).textTheme.subtitle1,
        ),
        content: SizedBox(
          width: double.infinity,
          child: Text(
            '',
            style: TextStyle(
                color: Colors.green, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        isActive: int.tryParse(status)! >= int.tryParse('5')!,
      ));
    }
    if (status == '12') {
      _orderStatusSteps.add(Step(
        state: StepState.complete,
        title: Text(
          'Order Reject',
          style: Theme.of(context).textTheme.subtitle1,
        ),
        content: SizedBox(
            width: double.infinity,
            child: Text(
              '',
            )),
        isActive: int.tryParse(status)! >= int.tryParse('12')!,
      ));
    } else {
      _orderStatusSteps.add(Step(
        state: StepState.complete,
        title: Text(
          'Order Accept',
          style: Theme.of(context).textTheme.subtitle1,
        ),
        content: SizedBox(
            width: double.infinity,
            child: Text(
              '',
              style: TextStyle(
                  color: Colors.green,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            )),
        isActive: int.tryParse(status)! >= int.tryParse('14')!,
      ));
    }
    _orderStatusSteps.add(Step(
      state: StepState.complete,
      title: Text(
        'Order Process ',
        style: Theme.of(context).textTheme.subtitle1,
      ),
      content: SizedBox(
          width: double.infinity,
          child: Text(
            '',
            style: TextStyle(
                color: Colors.green, fontSize: 16, fontWeight: FontWeight.bold),
          )),
      isActive: int.tryParse(status)! >= int.tryParse('15')!,
    ));
    _orderStatusSteps.add(Step(
      state: StepState.complete,
      title: Text(
        'On The Way',
        style: Theme.of(context).textTheme.subtitle1,
      ),
      content: SizedBox(
          width: double.infinity,
          child: Text(
            '',
            style: TextStyle(
                color: Colors.green, fontSize: 16, fontWeight: FontWeight.bold),
          )),
      isActive: int.tryParse(status)! >= int.tryParse('17')!,
    ));
    _orderStatusSteps.add(Step(
      state: StepState.complete,
      title: Text(
        'Order Completed',
        style: Theme.of(context).textTheme.subtitle1,
      ),
      content: SizedBox(
        width: double.infinity,
        child: Text(
          '',
          style: TextStyle(
              color: Colors.green, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      isActive: int.tryParse(status)! >= int.tryParse('20')!,
    ));
    return _orderStatusSteps;
  }

  Customer_details(OrderDetailsController orderDetails) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 10, bottom: 10, left: 15),
          child: Row(
            children: [
              Icon(
                FontAwesomeIcons.userTie,
                color: ThemeColors.baseThemeColor,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "Customer details",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: ThemeColors.scaffoldBgColor),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 25),
          color: Colors.white,
          //height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    orderDetails.orderDetailsByIdData!.customer!.name
                        .toString(),
                    style: TextStyle(),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.person_pin,
                      color: ThemeColors.baseThemeColor,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    orderDetails.orderDetailsByIdData!.customer!.address
                        .toString(),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.location_on_outlined,
                      color: ThemeColors.baseThemeColor,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    orderDetails.orderDetailsByIdData!.customer!.phone
                        .toString(),
                  ),
                  IconButton(
                    onPressed: () {
                      _makePhoneCall(
                        orderDetails.orderDetailsByIdData!.customer!.phone
                            .toString(),
                      );
                    },
                    icon: Icon(
                      Icons.phone_sharp,
                      color: ThemeColors.baseThemeColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launch(launchUri.toString());
  }
}
