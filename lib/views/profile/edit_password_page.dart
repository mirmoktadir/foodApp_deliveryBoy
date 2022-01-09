import 'package:flutter/material.dart';
import 'package:food_ex_delivery_app/controllers/global-controller.dart';
import 'package:food_ex_delivery_app/controllers/profile_controller.dart';
import 'package:food_ex_delivery_app/services/validators.dart';
import 'package:food_ex_delivery_app/utils/theme_colors.dart';
import 'package:food_ex_delivery_app/widgets/loader.dart';

import 'package:get/get.dart';

class EditPasswordPage extends StatefulWidget {
  @override
  State<EditPasswordPage> createState() => _EditPasswordPageState();
}

class _EditPasswordPageState extends State<EditPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  Validators validators = Validators();

  final profileController = Profile_Controller();
  var mainHeight, mainWidth;

  @override
  void initState() {
    profileController.onInit();
    setState(() {});

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    GlobalController globalController = GlobalController();
    mainHeight = MediaQuery.of(context).size.height;
    mainWidth = MediaQuery.of(context).size.width;
    return GetBuilder<Profile_Controller>(
      init: Profile_Controller(),
      builder: (profile) => Scaffold(
        appBar: AppBar(
          backgroundColor: ThemeColors.baseThemeColor,
          elevation: 0.0,
          centerTitle: true,
          title: Text('Password reset'),
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 30),
                    height: mainHeight / 2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ThemeColors.baseThemeColor.withOpacity(.01),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Current Password *'),
                            SizedBox(
                              height: 5,
                            ),
                            TextFormField(
                              controller: profile.passwordCurrentController,
                              obscureText: false,
                              //initialValue: widget.userdata['name'],
                              textAlign: TextAlign.start,
                              keyboardType: TextInputType.text,
                              style: TextStyle(
                                fontSize: 18,
                                height: 0.8,
                              ),
                              decoration: InputDecoration(
                                hintStyle: TextStyle(fontSize: 15),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: ThemeColors.baseThemeColor),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: ThemeColors.baseThemeColor),
                                ),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ThemeColors.baseThemeColor)),
                                hintText: "",
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text('New Password*'),
                            SizedBox(
                              height: 5,
                            ),
                            TextFormField(
                              controller: profile.passwordController,
                              obscureText: true,
                              //initialValue: widget.userdata['name'],
                              textAlign: TextAlign.start,
                              keyboardType: TextInputType.text,
                              style: TextStyle(
                                fontSize: 18,
                                height: 0.8,
                              ),
                              decoration: InputDecoration(
                                hintStyle: TextStyle(fontSize: 15),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: ThemeColors.baseThemeColor),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: ThemeColors.baseThemeColor),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: ThemeColors.baseThemeColor),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text('Retype new-password*'),
                            SizedBox(
                              height: 5,
                            ),
                            TextFormField(
                              controller: profile.passwordConfirmController,
                              obscureText: true,
                              //initialValue: widget.userdata['name'],
                              textAlign: TextAlign.start,
                              keyboardType: TextInputType.text,
                              style: TextStyle(
                                fontSize: 18,
                                height: 0.8,
                              ),
                              decoration: InputDecoration(
                                hintStyle: TextStyle(fontSize: 15),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: ThemeColors.baseThemeColor),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: ThemeColors.baseThemeColor),
                                ),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ThemeColors.baseThemeColor)),
                                hintText: "",
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(120),
                                child: SizedBox(
                                  width: 130,
                                  height: 40,
                                  child: ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      primary: ThemeColors.baseThemeColor,
                                    ),
                                    icon: Icon(
                                      Icons.update,
                                      size: 26,
                                    ),
                                    label: Text(
                                      'Update',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    onPressed: () {
                                      profile.updateUserPassword(
                                          context: context);
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              profile.loader
                  ? Positioned(
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.white60,
                        child: Center(
                          child: Loader(),
                        ),
                      ),
                    )
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
