import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_fire/services/firestore_service.dart';
import 'package:todo_fire/utils/task.dart';

class TaskProvider with ChangeNotifier {
  List<Task> tasks = [];
  final auth = AuthService();

  // Retrieve the user's data and make it the local one
  Future<List<Task>> getData(User user) async {
    List<dynamic> taskNames = (await auth.getUserDetails(user));
    clearTasks();
    for (var item in taskNames) {
      tasks.add(
        Task(task: item),
      );
    }
    notifyListeners();
    return tasks;
  }

  // Clears all tasks and notifies all listeners
  void clearTasks() {
    tasks.clear();
    Task.count = 0;
    notifyListeners();
  }

  // Remove a specific task and notify all listeners
  void removeTask(int id) {
    tasks.removeAt(id);
    Task.count = 0;
    for (Task task in tasks) {
      task.id = Task.count;
      Task.count++;
      task.printInfo();
    }
    notifyListeners();
  }

  // Print all tasks for debugging purposes
  void printTasks() {
    for (var task in tasks) {
      task.printInfo();
    }
  }

  // Set the current data as the data of the user
  void setData(User user) async {
    List<dynamic> taskNames = [];
    for (var item in tasks) {
      taskNames.add(item.task);
    }
    await auth.addUserDetails(user, taskNames);
    getData(user);
    notifyListeners();
  }
}
