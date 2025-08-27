import 'package:flutter/material.dart';
import 'package:osolutions_app/models/task_model.dart';

class TaskFormProvider with ChangeNotifier {
  String? _title;
  String? _description;
  String? _categoryId;
  String? _priority;
  DateTime? _dueDate;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TaskFormProvider({Task? task}) {
    if (task != null) {
      _title = task.title;
      _description = task.description;
      _categoryId = task.categoryId.toString();
      _priority = task.priority;
      _dueDate = task.dueDate != null
          ? DateTime.parse(task.dueDate!)
          : null;
    }
  }

  String? get title => _title;
  String? get description => _description;
  String? get categoryId => _categoryId;
  String? get priority => _priority;
  DateTime? get dueDate => _dueDate;
  GlobalKey<FormState> get formKey => _formKey;

  void setTitle(String? value) {
    _title = value;
    notifyListeners();
  }

  void setDescription(String? value) {
    _description = value;
    notifyListeners();
  }

  void setCategoryId(String? value) {
    _categoryId = value;
    notifyListeners();
  }

  void setPriority(String? value) {
    _priority = value;
    notifyListeners();
  }

  void setDueDate(DateTime? value) {
    _dueDate = value;
    notifyListeners();
  }

  void resetForm() {
    _title = null;
    _description = null;
    _categoryId = null;
    _priority = null;
    _dueDate = null;
    _formKey.currentState?.reset();
    notifyListeners();
  }

  bool validateForm() {
    return _formKey.currentState?.validate() ?? false;
  }

  Task buildTask({
    int? id,
    bool? completed,
    String? imageUrl,
    String? createdAt,
  }) {
    return Task(
      id: id ?? 0,
      title: _title!,
      description: _description,
      priority: _priority,
      categoryId: int.parse(_categoryId!),
      dueDate: _dueDate?.toIso8601String().split('T')[0],
      completed: completed ?? false,
      imageUrl: imageUrl,
      createdAt: createdAt ?? DateTime.now().toIso8601String(),
      updatedAt: DateTime.now().toIso8601String(),
    );
  }
}
