import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_getx_todo/src/binding/home_binding.dart';
import 'package:flutter_getx_todo/src/binding/sign_in_binding.dart';
import 'package:flutter_getx_todo/src/constants/firebase_const.dart';
import 'package:flutter_getx_todo/src/view/home.dart';
import 'package:flutter_getx_todo/src/view/sign_in.dart';
import 'package:get/get.dart';

class AuthHandler extends GetxService {
  final _user = auth.currentUser.obs;

  @override
  void onReady() {
    super.onReady();
    _user.bindStream(auth.authStateChanges());
    ever(_user, moveToPage);
  }

  moveToPage(User? user) {
    if (user == null) {
      Get.off(() => const SignInView(), binding: SignInBinding());
    } else {
      Get.off(() => const HomeView(), binding: HomeBinding());
    }
  }

  static Future<void> signIn(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      Get.snackbar(
        '에러',
        '로그인에 실패했습니다.',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
    }
  }

  static Future<void> signUp(String email, String password) async {
    try {
      auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        // ignore: avoid_print
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        // ignore: avoid_print
        print('The account already exists for that email.');
      }
    } catch (e) {
      // ignore: avoid_print
      print('에러');
    }
  }
}
