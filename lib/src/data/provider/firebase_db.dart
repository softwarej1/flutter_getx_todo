import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_getx_todo/src/constants/firebase_const.dart';
import 'package:flutter_getx_todo/src/data/model/home_model.dart';

class HomeApi {
  static Stream<List<HomeModel>> getTodos() {
    return firebaseFirestore
        .collection('todo')
        .snapshots()
        .map((QuerySnapshot query) {
      List<HomeModel> todos = [];
      for (var doc in query.docs) {
        final todoModel = HomeModel.froJson(doc);
        todos.add(todoModel);
      }
      return todos;
    });
  }

  static Future<void> createTodo(HomeModel todoModel) {
    return firebaseFirestore.collection('todo').doc().set(
      {
        'todo': todoModel.todo,
        'time': Timestamp.now(),
        'isDone': false,
      },
    );
  }

  static void updateTodo(String id) {
    firebaseFirestore.collection('todo').doc(id).update(
      {
        'isDone': true,
      },
    );
  }

  static void deleteTodo(String id) {
    firebaseFirestore.collection('todo').doc(id).delete();
  }
}
