import 'package:flutter/material.dart';
import 'package:food_ex_delivery_app/controllers/auth-controller.dart';
import 'package:food_ex_delivery_app/services/validators.dart';
import 'package:food_ex_delivery_app/utils/font_size.dart';
import 'package:food_ex_delivery_app/utils/size_config.dart';
import 'package:food_ex_delivery_app/views/signing/sign_in.dart';
import 'package:food_ex_delivery_app/widgets/loader.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:food_ex_delivery_app/utils/theme_colors.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  AuthController controller = AuthController();
  Validators validators = Validators();

  @override
  void didChangeDependencies() {
    controller = Get.put(AuthController());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig sizeConfig = SizeConfig();
    sizeConfig.init(context);

    return GetBuilder<AuthController>(
      init: AuthController(),
      builder: (auth) => Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
            height: SizeConfig.screenHeight,
            padding: const EdgeInsets.all(30),
            child: Stack(
              children: [
                Center(
                  child: SingleChildScrollView(
                    reverse: true,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "New here? Welcome!",
                          style: GoogleFonts.poppins(
                            color: ThemeColors.baseThemeColor,
                            fontSize: FontSize.xxLarge,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 7),
                          child: Text(
                            "Please fill the form to continue.",
                            style: GoogleFonts.poppins(
                              color: ThemeColors.greyTextColor,
                              fontSize: FontSize.medium,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(height: 70),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              ///Name Input Field
                              TextFormField(
                                controller: controller.nameController,
                                textInputAction: TextInputAction.done,
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                ),
                                keyboardType: TextInputType.name,
                                cursorColor: ThemeColors.primaryColor,
                                decoration: InputDecoration(
                                  //fillColor: ThemeColors.textFieldBgColor,
                                  filled: true,
                                  hintText: "Full name",
                                  hintStyle: GoogleFonts.poppins(
                                    color: ThemeColors.textFieldHintColor,
                                    fontSize: FontSize.medium,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(18)),
                                  ),
                                ),
                              ),
                              SizedBox(height: 16),

                              ///E-mail Input Field
                              TextFormField(
                                controller: controller.emailController,
                                textInputAction: TextInputAction.done,
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                ),
                                cursorColor: ThemeColors.primaryColor,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  //fillColor: ThemeColors.textFieldBgColor,
                                  filled: true,
                                  hintText: "E-mail",
                                  hintStyle: GoogleFonts.poppins(
                                    color: ThemeColors.textFieldHintColor,
                                    fontSize: FontSize.medium,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(18)),
                                  ),
                                ),
                              ),
                              SizedBox(height: 16),

                              ///Phone Input Field
                              TextFormField(
                                controller: controller.phoneController,
                                textInputAction: TextInputAction.done,
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                ),
                                cursorColor: ThemeColors.primaryColor,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  // fillColor: ThemeColors.textFieldBgColor,
                                  filled: true,
                                  hintText: "Phone number",
                                  hintStyle: GoogleFonts.poppins(
                                    color: ThemeColors.textFieldHintColor,
                                    fontSize: FontSize.medium,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(18)),
                                  ),
                                ),
                              ),
                              SizedBox(height: 16),

                              ///Password Input Field
                              TextFormField(
                                controller: controller.passwordController,
                                textInputAction: TextInputAction.done,
                                obscureText: true,
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                ),
                                keyboardType: TextInputType.visiblePassword,
                                cursorColor: ThemeColors.primaryColor,
                                decoration: InputDecoration(
                                  //  fillColor: ThemeColors.textFieldBgColor,
                                  filled: true,
                                  hintText: "Password",
                                  hintStyle: GoogleFonts.poppins(
                                    color: ThemeColors.textFieldHintColor,
                                    fontSize: FontSize.medium,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(18)),
                                  ),
                                ),
                              ),
                              SizedBox(height: 30),

                              ///Password confirmation Input Field
                              TextFormField(
                                controller:
                                    controller.password_confirmation_Controller,
                                textInputAction: TextInputAction.done,
                                obscureText: true,
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                ),
                                keyboardType: TextInputType.visiblePassword,
                                cursorColor: ThemeColors.primaryColor,
                                decoration: InputDecoration(
                                  //  fillColor: ThemeColors.textFieldBgColor,
                                  filled: true,
                                  hintText: "Confirm Password",
                                  hintStyle: GoogleFonts.poppins(
                                    color: ThemeColors.textFieldHintColor,
                                    fontSize: FontSize.medium,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(18)),
                                  ),
                                ),
                              ),
                              SizedBox(height: 30),
                              Container(
                                height: 50,
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: ThemeColors
                                        .baseThemeColor, // background
                                    onPrimary: Colors.white, // foreground
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          18), // <-- Radius
                                    ),
                                  ),
                                  onPressed: () async {
                                    auth.signupOnTap(
                                      context: context,
                                      email: auth.emailController.text
                                          .toString()
                                          .trim(),
                                      password: auth.passwordController.text
                                          .toString()
                                          .trim(),
                                      phone_number: auth.phoneController.text
                                          .toString()
                                          .trim(),
                                      name: auth.nameController.text
                                          .toString()
                                          .trim(),
                                      confirm_password: auth
                                          .password_confirmation_Controller.text
                                          .toString()
                                          .trim(),
                                    );
                                  },
                                  child: Text(
                                    'Sign Up',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Already a user? ",
                                      style: GoogleFonts.poppins(
                                        // color: ThemeColors.whiteTextColor,
                                        fontSize: FontSize.medium,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () => Get.to(LoginPage()),
                                      child: Text(
                                        "Sign In",
                                        style: GoogleFonts.poppins(
                                          color: ThemeColors.baseThemeColor,
                                          fontSize: FontSize.medium,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                auth.loader
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
      ),
    );
  }
}
