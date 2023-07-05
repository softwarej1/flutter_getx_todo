import 'package:cloud_firestore/cloud_firestore.dart';

class HomeModel {
  final String? id;
  final String todo;
  final Timestamp? time;
  final bool? isDone;

  HomeModel({this.id, required this.todo, this.time, this.isDone});

  factory HomeModel.froJson(DocumentSnapshot doc) {
    return HomeModel(
        id: doc.id,
        todo: doc['todo'],
        time: doc['time'],
        isDone: doc['isDone']);
  }

  factory HomeModel.toJson(String todo) {
    return HomeModel(todo: todo);
  }
}
