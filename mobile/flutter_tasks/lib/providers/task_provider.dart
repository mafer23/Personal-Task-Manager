import 'package:flutter/material.dart';
import '../models/task.dart';
import '../services/api_service.dart';

class TaskProvider extends ChangeNotifier {
  final ApiService api;
  List<Task> tasks = [];
  bool isLoading = false;
  String? error;

  TaskProvider({required this.api});

  Future<void> loadTasks() async {
    isLoading = true; notifyListeners();
    try {
      tasks = await api.fetchTasks();
      error = null;
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false; notifyListeners();
    }
  }

  Future<void> addTask(Task t) async {
    isLoading = true; notifyListeners();
    try {
      final created = await api.createTask(t);
      tasks.insert(0, created);
      error = null;
    } catch (e) {
      error = e.toString();
      rethrow;
    } finally {
      isLoading = false; notifyListeners();
    }
  }

  Future<void> updateTask(Task t) async {
    isLoading = true; notifyListeners();
    try {
      final updated = await api.updateTask(t);
      final idx = tasks.indexWhere((x) => x.id == updated.id);
      if (idx != -1) tasks[idx] = updated;
      error = null;
    } catch (e) {
      error = e.toString();
      rethrow;
    } finally {
      isLoading = false; notifyListeners();
    }
  }

  Future<void> toggleComplete(Task t) async {
    final old = t.done;
    t.done = !t.done;
    notifyListeners();
    try {
      await api.updateTask(t);
    } catch (e) {
      t.done = old;
      error = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  Future<void> deleteTask(Task t) async {
    final id = t.id;
    if (id == null) return;
    final index = tasks.indexOf(t);
    tasks.removeAt(index);
    notifyListeners();
    try {
      await api.deleteTask(id);
    } catch (e) {
      tasks.insert(index, t); // revert
      error = e.toString();
      notifyListeners();
      rethrow;
    }
  }
}
