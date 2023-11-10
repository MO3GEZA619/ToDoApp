import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../FirerBase_Utils.dart';
import '../Task_Tap/tasks.dart';


class ListProvider extends ChangeNotifier {
  List<Task> tasksList = [];
  DateTime selectedDate = DateTime.now();

  void getAllTasksFromFirestore() async {
    QuerySnapshot<Task> querySnapshot =
    await FirebaseUtils.getTaskCollection().get();
    tasksList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();

    tasksList = tasksList.where((task) {
      if (task.date?.day == selectedDate.day &&
               task.date?.month == selectedDate.month &&
               task.date?.year == selectedDate.year){
        return true;
      }
      return false;
    }).toList();

    tasksList.sort((Task t1, Task t2) {
               return t1.date!.compareTo(t2.date!);
             },);

   notifyListeners();
  }


  void changeSelectedDate(DateTime newDate) {
    selectedDate = newDate;
    getAllTasksFromFirestore();
    notifyListeners();
  }

  Future<void> deleteTaskFromFireStore(Task task) async {
    try {
      await FirebaseUtils.deleteTaskFromFireStore(task);
      tasksList.removeWhere((task) => task.id == task.id);
      notifyListeners();
    } catch (e) {
      print('Error deleting task: $e');
    }
  }
  Future<void> updateTaskInFirestore(Task updatedTask) async {
    try {
      await FirebaseUtils.updateTaskFromFireStore(updatedTask);

      int index = tasksList.indexWhere((task) => task.id == updatedTask.id);
      tasksList[index] = updatedTask;
      notifyListeners();
    } catch (e) {
      print('Error updating task: $e');
    }
  }

}
