import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_note/data/models/to_do_model.dart';
import 'package:to_note/services/auth/auth_service.dart';

class ToDoFirestore {
  final controller = FirebaseFirestore.instance.collection("users");

  Future<void> addToDo(ToDoModel toDo) async {
    // adding new to do to fire base , we need title, id , time, date which we get from "toDo"
    final userId = await AuthService().getUserId();

    try {
      await controller.doc(userId).collection("toDo").doc(toDo.title).set({
        "id": toDo.title,
        "title": toDo.title,
        "isCompleted": false,
        "time": toDo.time,
        "date": toDo.date,
        "rate": 0,
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> compliteToDo(String toDoId, int rate) async {
    //"isComplited" variable in firebase should change to true when user comlites the tusk also add rate
    final userId = await AuthService().getUserId();

    try {
      // ignore: avoid_single_cascade_in_expression_statements
      controller.doc(userId).collection("toDo").doc(toDoId).update(
        // so i use update and give the value that should be changed
        {
          "isCompleted": true,
          "rate": rate,
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getTodos() async* {
    final userId = await AuthService().getUserId();
    yield* controller.doc(userId).collection("toDo").snapshots();
  }
}
