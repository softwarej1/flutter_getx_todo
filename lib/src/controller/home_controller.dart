import 'package:flutter/cupertino.dart';
import 'package:flutter_getx_todo/src/constants/firebase_const.dart';
import 'package:flutter_getx_todo/src/data/model/home_model.dart';
import 'package:flutter_getx_todo/src/data/provider/firebase_db.dart';
import 'package:flutter_getx_todo/src/data/repository/home_repository.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final Rx<List<HomeModel>> _todos = Rx<List<HomeModel>>([]);
  final TextEditingController _controller = TextEditingController();

  List<HomeModel> get todos => _todos.value;
  TextEditingController get createController => _controller;

  @override
  void onReady() {
    super.onReady();
    _todos.bindStream(HomeRepository.fetchTodos());
  }

  void create() {
    final todo = _controller.value.text;
    if (todo.isNotEmpty) {
      try {
        final todoModel = HomeModel.toJson(todo);
        HomeApi.createTodo(todoModel);
        _controller.clear();
      } catch (e) {
        debugPrint("Error");
      }
    }
  }

  void updateTodo(String id) {
    try {
      HomeApi.updateTodo(id);
    } catch (e) {
      debugPrint("Error");
    }
  }

  void deleteTodo(String id) {
    try {
      HomeApi.deleteTodo(id);
    } catch (e) {
      debugPrint("Error");
    }
  }

  void signOut() {
    try {
      auth.signOut();
    } catch (e) {
      debugPrint('Error');
    }
  }
}
