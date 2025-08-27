import 'package:flutter/material.dart';
import 'package:osolutions_app/models/category_model.dart';
import 'package:osolutions_app/providers/category_provider.dart';
import 'package:osolutions_app/providers/task_provider.dart';
import 'package:provider/provider.dart';

class CategoryFilter extends StatelessWidget {
  const CategoryFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryProvider>(
      builder: (context, categoryProvider, child) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: DropdownButton<String?>(
            value: context.watch<TaskProvider>().selectedCategoryId,
            hint: const Text('All Categories'),
            isExpanded: true,
            items: [
              const DropdownMenuItem<String?>(
                value: null,
                child: Text('All Categories'),
              ),
              ...categoryProvider.categories.map((Category category) {
                return DropdownMenuItem<String>(
                  value: category.id.toString(),
                  child: Text(category.name!),
                );
              }),
            ],
            onChanged: (value) {
              context.read<TaskProvider>().setCategoryFilter(value);
              context.read<TaskProvider>().fetchTasks();
            },
          ),
        );
      },
    );
  }
}
