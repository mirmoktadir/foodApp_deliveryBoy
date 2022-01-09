import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:food_ex_delivery_app/models/refresh_token.dart';
import 'package:food_ex_delivery_app/models/reg_api.dart';
import 'package:food_ex_delivery_app/models/login_api.dart';
import 'package:food_ex_delivery_app/services/api-list.dart';
import 'package:food_ex_delivery_app/services/server.dart';
import 'package:food_ex_delivery_app/services/user-service.dart';
import 'package:food_ex_delivery_app/services/validators.dart';
import 'package:food_ex_delivery_app/views/main_screen.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'global-controller.dart';

class AuthController extends GetxController {
  UserService userService = UserService();
  Validators _validators = Validators();
  Server server = Server();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController password_confirmation_Controller =
      TextEditingController();
  bool obscureText = true;
  bool loader = false;

  changeVisibility() {
    obscureText = !obscureText;
    Future.delayed(Duration(milliseconds: 10), () {
      update();
    });
  }

  loginOnTap({BuildContext? context, String? email, String? pass}) async {
    loader = true;
    Future.delayed(Duration(milliseconds: 10), () {
      update();
    });
    var email_validator = _validators.validateEmail(value: email);
    var pass_validator = _validators.validatePassword(value: pass);
    if (email_validator == null && pass_validator == null) {
      Map body = {'email': email, 'password': pass};
      String jsonBody = json.encode(body);

      server
          .postRequest(endPoint: APIList.login, body: jsonBody)
          .then((response) {
        if (response != null && response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          var loginData = Login_api.fromJson(jsonResponse);
          var bearer_token = 'Bearer ' + "${loginData.token}";
          userService.saveBoolean(key: 'is-user', value: true);
          userService.saveString(key: 'token', value: loginData.token);
          userService.saveString(
              key: 'user-id', value: loginData.data!.id.toString());
          userService.saveString(
              key: 'email', value: loginData.data!.email.toString());
          userService.saveString(
              key: 'username', value: loginData.data!.username.toString());
          userService.saveString(
              key: 'image', value: loginData.data!.image.toString());
          userService.saveString(
              key: 'name', value: loginData.data!.name.toString());
          userService.saveString(
              key: 'phone', value: loginData.data!.phone.toString());
          userService.saveString(
              key: 'status', value: loginData.data!.status.toString());
          Server.initClass(token: bearer_token);
          Get.put(GlobalController()).initController();
          emailController.clear();
          passwordController.clear();
          loader = false;
          Future.delayed(Duration(milliseconds: 10), () {
            update();
          });
          Get.off(() => MainScreen());
        } else {
          loader = false;
          Future.delayed(Duration(milliseconds: 10), () {
            update();
          });
          Get.rawSnackbar(
              message: 'Please enter valid email address and password');
        }
      });
    } else {
      loader = false;
      Future.delayed(Duration(milliseconds: 10), () {
        update();
      });
      Get.rawSnackbar(message: 'Please enter email address and password');
    }
  }

  refreshToken() async {
    server.getRequest(endPoint: APIList.refreshToken).then((response) {
      print(response);
      if (response != null && response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        var refreshData = RefreshToken.fromJson(jsonResponse);
        print(refreshData);
        var newToken = 'Bearer ' + "${refreshData.token}";
        userService.saveBoolean(key: 'is-user', value: true);
        userService.saveString(key: 'token', value: refreshData.token);
        Server.initClass(token: newToken);
        Get.put(GlobalController()).initController();
        Get.off(() => MainScreen());
        return true;
      } else {
        return false;
      }
    });
  }

  signupOnTap(
      {BuildContext? context,
      String? email,
      String? password,
      String? confirm_password,
      String? phone_number,
      String? name}) async {
    loader = true;
    Future.delayed(Duration(milliseconds: 10), () {
      update();
    });
    var email_validator = _validators.validateEmail(value: email);
    var pass_validator = _validators.validatePassword(value: password);

    if (email_validator == null && pass_validator == null) {
      Map body = {
        'name': nameController.text,
        'username': usernameController.text,
        'email': email,
        'phone': phone_number,
        'password': password,
        'password_confirmation': confirm_password,
        'role': 4
      };
      String jsonBody = json.encode(body);

      server
          .postRequest(endPoint: APIList.register, body: jsonBody)
          .then((response) {
        if (response != null && response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          var regData = Reg_api.fromJson(jsonResponse);
          var bearer_token = 'Bearer ' + "${regData.token}";
          userService.saveBoolean(key: 'is-user', value: true);
          userService.saveString(
              key: 'user-id', value: regData.data!.id.toString());
          userService.saveString(key: 'token', value: regData.token);
          userService.saveString(
              key: 'email', value: regData.data!.email.toString());
          userService.saveString(
              key: 'username', value: regData.data!.username.toString());
          userService.saveString(
              key: 'image', value: regData.data!.image.toString());
          userService.saveString(
              key: 'name', value: regData.data!.name.toString());
          userService.saveString(
              key: 'phone', value: regData.data!.phone.toString());
          userService.saveString(
              key: 'status', value: regData.data!.status.toString());
          Server.initClass(token: bearer_token);
          Get.find<GlobalController>().onInit();
          emailController.clear();
          passwordController.clear();
          nameController.clear();
          usernameController.clear();
          phoneController.clear();
          loader = false;
          Future.delayed(Duration(milliseconds: 10), () {
            update();
          });
          Get.off(() => MainScreen());
        } else {
          loader = false;
          Future.delayed(Duration(milliseconds: 10), () {
            update();
          });
          Get.rawSnackbar(message: 'Please enter valid input');
        }
      });
    } else {
      loader = false;
      Future.delayed(Duration(milliseconds: 10), () {
        update();
      });
      Get.rawSnackbar(message: 'Please enter valid input');
    }
  }
}
