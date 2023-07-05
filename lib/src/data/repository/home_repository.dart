import 'package:flutter_getx_todo/src/data/model/home_model.dart';
import 'package:flutter_getx_todo/src/data/provider/firebase_db.dart';

class HomeRepository {
  static Stream<List<HomeModel>> fetchTodos() => HomeApi.getTodos();
}
