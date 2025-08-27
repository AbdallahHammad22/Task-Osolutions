import 'package:flutter/material.dart';
import 'package:osolutions_app/core/services/api_service.dart';
import 'package:osolutions_app/models/task_model.dart';

class TaskDetailProvider with ChangeNotifier {
  final ApiService _apiService;
  Task _task;
  bool _isLoading = false;
  String? _error;

  TaskDetailProvider(this._apiService, this._task);

  Task get task => _task;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> toggleTaskCompletion(int id, bool completed) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      await _apiService.updateTask(id, {'completed': completed});
      _task = Task(
        id: _task.id,
        title: _task.title,
        description: _task.description,
        priority: _task.priority,
        categoryId: _task.categoryId,
        dueDate: _task.dueDate,
        completed: completed,
        imageUrl: _task.imageUrl,
        createdAt: _task.createdAt,
        updatedAt: DateTime.now().toIso8601String(),
      );
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  Future<void> deleteTask(int id) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      await _apiService.deleteTask(id);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
      rethrow;
    }
  }
}
