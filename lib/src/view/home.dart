import 'package:flutter/material.dart';
import 'package:flutter_getx_todo/src/controller/home_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('오늘의 할 일'),
        actions: [
          IconButton(
              onPressed: controller.signOut, icon: const Icon(Icons.logout))
        ],
      ),
      body: Obx(
        () => Column(
          children: [
            _date(),
            _create(),
            _todoList(),
          ],
        ),
      ),
    );
  }

  Widget _date() {
    DateTime now = DateTime.now();
    String formattedDate = ' ${now.month}월 ${now.day}일';
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Center(
        child: Text(
          formattedDate,
          style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _create() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: TextField(
                controller: controller.createController,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
            child: SizedBox(
              height: 50,
              width: 70,
              child: ElevatedButton(
                  onPressed: controller.create, child: const Icon(Icons.add)),
            ),
          )
        ],
      ),
    );
  }

  Widget _todoList() {
    return Expanded(
      child: ListView.builder(
        itemCount: controller.todos.length,
        itemBuilder: (context, index) {
          final todoModel = controller.todos[index];
          final milliseconds = todoModel.time!.millisecondsSinceEpoch;
          final dateTime = DateTime.fromMillisecondsSinceEpoch(milliseconds);
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            height: 70,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: ListTile(
              trailing: (todoModel.isDone!)
                  ? GestureDetector(
                      onTap: () {
                        controller.deleteTodo(todoModel.id!);
                      },
                      child: const Icon(
                        Icons.check,
                        color: Colors.green,
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        controller.updateTodo(todoModel.id!);
                      },
                      child: const Icon(
                        Icons.close,
                        color: Colors.red,
                      ),
                    ),
              title: Text(
                todoModel.todo,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  decoration: todoModel.isDone!
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
              subtitle: Text(
                DateFormat('yyyy-MM-dd HH:mm').format(dateTime),
                textAlign: TextAlign.center,
                style: TextStyle(
                  decoration: todoModel.isDone!
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
