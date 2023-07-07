import 'package:flutter/material.dart';
import 'package:flutter_getx_todo/src/components/gredient_button.dart';
import 'package:flutter_getx_todo/src/components/input_field.dart';
import 'package:flutter_getx_todo/src/controller/sign_up_controller.dart';
import 'package:flutter_getx_todo/src/res/image_path.dart';
import 'package:get/get.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _image(),
                _title(),
                _input(),
                _button(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _image() {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        height: 150,
        width: 150,
        child: Image.asset(
          ImagePath.SignInViewImage,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _title() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          '새 계정 만들기',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _input() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 24.0),
          child: InputField(
            controller: controller.email,
            hintText: '이메일',
            prefixIcon: const Icon(Icons.email),
            obscure: false,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 24.0),
          child: InputField(
            controller: controller.password,
            hintText: '비밀번호',
            prefixIcon: const Icon(Icons.lock),
            obscure: true,
            type: TextInputType.text,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 24.0),
          child: InputField(
            controller: controller.confirmPassword,
            hintText: '비밀번호 확인',
            prefixIcon: const Icon(Icons.lock),
            obscure: true,
            type: TextInputType.text,
          ),
        ),
      ],
    );
  }

  Widget _button() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Obx(
        () => GradientButton(
            onPressed: controller.register,
            width: double.infinity,
            height: 20,
            child: (controller.isLoading) ? _loading() : _resisterText()),
      ),
    );
  }

  Widget _resisterText() {
    return const Text(
      '회원가입',
      style: TextStyle(fontFamily: 'Ubuntu', fontSize: 24, color: Colors.white),
    );
  }

  Widget _loading() {
    return const SizedBox(
      width: 30,
      height: 30,
      child: CircularProgressIndicator(color: Colors.white),
    );
  }
}
