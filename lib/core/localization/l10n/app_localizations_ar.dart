// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get app_name => 'قائمة المهام';

  @override
  String get task_list_title => 'المهام';

  @override
  String get add_task => 'إضافة مهمة';

  @override
  String get edit_task => 'تعديل مهمة';

  @override
  String get title => 'العنوان';

  @override
  String get description => 'الوصف';

  @override
  String get category => 'الفئة';

  @override
  String get priority => 'الأولوية';

  @override
  String get due_date => 'تاريخ الاستحقاق';

  @override
  String get save => 'حفظ';

  @override
  String get cancel => 'إلغاء';

  @override
  String get title_required => 'العنوان مطلوب';

  @override
  String get category_required => 'الفئة مطلوبة';

  @override
  String error_loading_tasks(Object error) {
    return 'خطأ في تحميل المهام: $error';
  }

  @override
  String error_loading_categories(Object error) {
    return 'خطأ في تحميل الفئات: $error';
  }

  @override
  String get no_tasks_available => 'لا توجد مهام متاحة';

  @override
  String get task_completed => 'تم وضع علامة الإنجاز على المهمة';

  @override
  String get task_incomplete => 'تم إلغاء علامة الإنجاز على المهمة';

  @override
  String get task_created => 'تم إنشاء المهمة بنجاح';

  @override
  String get task_updated => 'تم تحديث المهمة بنجاح';

  @override
  String get task_deleted => 'تم حذف المهمة بنجاح';

  @override
  String get delete_task => 'حذف المهمة';

  @override
  String confirm_delete(Object title) {
    return 'هل أنت متأكد من حذف \"$title\"؟';
  }

  @override
  String get language => 'اللغة';

  @override
  String get settings => 'الإعدادات';

  @override
  String get filter_by_category => 'تصفية حسب الفئة';

  @override
  String get all_categories => 'جميع الفئات';

  @override
  String get retry => 'إعادة المحاولة';
}
