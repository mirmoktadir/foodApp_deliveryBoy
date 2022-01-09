import 'package:flutter/material.dart';
import 'package:food_ex_delivery_app/utils/font_size.dart';
import 'package:food_ex_delivery_app/utils/images.dart';
import 'package:food_ex_delivery_app/utils/theme_colors.dart';

class NoOrderNotification extends StatefulWidget {
  const NoOrderNotification({Key? key}) : super(key: key);

  @override
  _NoOrderNotificationPageState createState() =>
      _NoOrderNotificationPageState();
}

class _NoOrderNotificationPageState extends State<NoOrderNotification> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Images.notification),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                'No Notification Yet !',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: ThemeColors.baseThemeColor,
                    fontSize: FontSize.xLarge),
              ),
            ),
            SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
    );
  }
}
