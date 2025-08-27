// TaskProvider
import 'package:flutter/foundation.dart';
import 'package:osolutions_app/core/services/api_service.dart';
import 'package:osolutions_app/models/task_model.dart';

class TaskProvider with ChangeNotifier {
  final ApiService _apiService;
  List<Task> _tasks = [];
  String? _selectedCategoryId;
  bool _isLoading = false;
  String? _error;

  TaskProvider(this._apiService);

  List<Task> get tasks => _tasks;
  String? get selectedCategoryId => _selectedCategoryId;
  bool get isLoading => _isLoading;
  String? get error => _error;

  void setCategoryFilter(String? categoryId) {
    _selectedCategoryId = categoryId;
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();
      final response = await _apiService.getTasks(
        categoryId: _selectedCategoryId,
      );
      _tasks = response.map((json) => Task.fromJson(json)).toList();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
      print('Error fetching tasks: $e');
    }
  }

  Future<void> addTask(Task task) async {
    try {
      final response = await _apiService.addTask(task.toJson());
      _tasks.add(Task.fromJson(response));
      notifyListeners();
    } catch (e) {
      print('Error adding task: $e');
      throw e;
    }
  }

  Future<void> updateTask(Task task) async {
    try {
      final response = await _apiService.updateTask(
        task.id,
        task.toJson(),
      );
      final index = _tasks.indexWhere((t) => t.id == task.id);
      if (index != -1) {
        _tasks[index] = Task.fromJson(response);
        notifyListeners();
      }
    } catch (e) {
      print('Error updating task: $e');
      throw e;
    }
  }

  Future<void> deleteTask(int id) async {
    try {
      await _apiService.deleteTask(id);
      _tasks.removeWhere((t) => t.id == id);
      notifyListeners();
    } catch (e) {
      print('Error deleting task: $e');
      throw e;
    }
  }

  Future<void> toggleTaskCompletion(int id, bool completed) async {
    try {
      final index = _tasks.indexWhere((t) => t.id == id);
      if (index != -1) {
        final updatedTask = Task(
          id: _tasks[index].id,
          title: _tasks[index].title,
          description: _tasks[index].description,
          priority: _tasks[index].priority,
          categoryId: _tasks[index].categoryId,
          dueDate: _tasks[index].dueDate,
          completed: completed,
          imageUrl: _tasks[index].imageUrl,
          createdAt: _tasks[index].createdAt,
          updatedAt: DateTime.now().toIso8601String(),
        );
        await _apiService.updateTask(id, {'completed': completed});
        _tasks[index] = updatedTask;
        notifyListeners();
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error toggling task completion: $e');
      }
      rethrow;
    }
  }
}
