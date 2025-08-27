// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get app_name => 'TODO List';

  @override
  String get task_list_title => 'Tasks';

  @override
  String get add_task => 'Add Task';

  @override
  String get edit_task => 'Edit Task';

  @override
  String get title => 'Title';

  @override
  String get description => 'Description';

  @override
  String get category => 'Category';

  @override
  String get priority => 'Priority';

  @override
  String get due_date => 'Due Date';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get title_required => 'Title is required';

  @override
  String get category_required => 'Category is required';

  @override
  String error_loading_tasks(Object error) {
    return 'Error loading tasks: $error';
  }

  @override
  String error_loading_categories(Object error) {
    return 'Error loading categories: $error';
  }

  @override
  String get no_tasks_available => 'No tasks available';

  @override
  String get task_completed => 'Task marked as completed';

  @override
  String get task_incomplete => 'Task marked as incomplete';

  @override
  String get task_created => 'Task created successfully';

  @override
  String get task_updated => 'Task updated successfully';

  @override
  String get task_deleted => 'Task deleted successfully';

  @override
  String get delete_task => 'Delete Task';

  @override
  String confirm_delete(Object title) {
    return 'Are you sure you want to delete \"$title\"?';
  }

  @override
  String get language => 'Language';

  @override
  String get settings => 'Settings';

  @override
  String get filter_by_category => 'Filter by Category';

  @override
  String get all_categories => 'All Categories';

  @override
  String get retry => 'Retry';
}
