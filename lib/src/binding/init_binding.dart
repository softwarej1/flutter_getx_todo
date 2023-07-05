import 'package:flutter_getx_todo/src/controller/sign_in_controller.dart';
import 'package:flutter_getx_todo/src/service/auth_handler.dart';
import 'package:get/get.dart';

class InitBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(AuthHandler());
    Get.put(SignInController());
  }
}
