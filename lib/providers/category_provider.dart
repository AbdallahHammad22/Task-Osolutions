// CategoryProvider
import 'package:flutter/material.dart';
import 'package:osolutions_app/core/services/api_service.dart';
import 'package:osolutions_app/models/category_model.dart';

class CategoryProvider with ChangeNotifier {
  final ApiService _apiService;
  List<Category> _categories = [];
  bool _isLoading = false;
  String? _error;

  CategoryProvider(this._apiService);

  List<Category> get categories => _categories;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchCategories() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final response = await _apiService.getCategories();
      _categories = response
          .map((json) => Category.fromJson(json))
          .toList();

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
      print('Error fetching categories: $e');
    }
  }
}
