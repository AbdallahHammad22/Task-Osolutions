import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio;

  ApiService(this._dio);

  // جلب كل الفئات
  Future<List<dynamic>> getCategories() async {
    try {
      final response = await _dio.get(
        'categories',
        queryParameters: {'order': 'name.asc'},
      );
      if (response.statusCode == 200) {
        return response.data;
      }
      throw Exception(
        'Failed to load categories: ${response.statusCode} - ${response.data}',
      );
    } catch (e) {
      throw Exception('Error fetching categories: $e');
    }
  }

  // جلب كل المهام
  Future<List<dynamic>> getTasks({
    String? categoryId,
    bool? completed,
    String? priority,
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      final queryParameters = {
        'order': 'created_at.desc',
        'limit': limit,
        'offset': offset,
      };
      if (categoryId != null) {
        queryParameters['category_id'] = 'eq.$categoryId';
      }
      if (completed != null) {
        queryParameters['completed'] = 'eq.$completed';
      }
      if (priority != null) {
        queryParameters['priority'] = 'eq.$priority';
      }
      final response = await _dio.get(
        'tasks',
        queryParameters: queryParameters,
      );
      if (response.statusCode == 200) {
        return response.data;
      }
      throw Exception(
        'Failed to load tasks: ${response.statusCode} - ${response.data}',
      );
    } catch (e) {
      throw Exception('Error fetching tasks: $e');
    }
  }

  // جلب مهمة واحدة
  Future<Map<String, dynamic>> getTask(int id) async {
    try {
      final response = await _dio.get(
        'tasks',
        queryParameters: {'id': 'eq.$id'},
      );
      if (response.statusCode == 200) {
        return response.data[0];
      }
      throw Exception(
        'Failed to load task: ${response.statusCode} - ${response.data}',
      );
    } catch (e) {
      throw Exception('Error fetching task: $e');
    }
  }

  // إنشاء مهمة
  Future<Map<String, dynamic>> addTask(
    Map<String, dynamic> task,
  ) async {
    try {
      final response = await _dio.post('tasks', data: task);
      if (response.statusCode == 201) {
        return response.data[0];
      }
      throw Exception(
        'Failed to create task: ${response.statusCode} - ${response.data}',
      );
    } catch (e) {
      throw Exception('Error creating task: $e');
    }
  }

  // تحديث مهمة
  Future<Map<String, dynamic>> updateTask(
    int id,
    Map<String, dynamic> task,
  ) async {
    try {
      final response = await _dio.patch(
        'tasks',
        queryParameters: {'id': 'eq.$id'},
        data: task,
      );
      if (response.statusCode == 200) {
        return response.data[0];
      }
      throw Exception(
        'Failed to update task: ${response.statusCode} - ${response.data}',
      );
    } catch (e) {
      throw Exception('Error updating task: $e');
    }
  }

  // حذف مهمة
  Future<void> deleteTask(int id) async {
    try {
      final response = await _dio.delete(
        'tasks',
        queryParameters: {'id': 'eq.$id'},
      );
      if (response.statusCode == 204 || response.statusCode == 200) {
        return; // الحذف ناجح في كلتا الحالتين
      }
      throw Exception(
        'Failed to delete task: ${response.statusCode} - ${response.data}',
      );
    } catch (e) {
      throw Exception('Error deleting task: $e');
    }
  }
}
