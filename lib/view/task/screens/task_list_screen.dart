import 'package:flutter/material.dart';
import 'package:osolutions_app/core/localization/app_localization.dart';
import 'package:osolutions_app/core/utils/widget/language_switcher_widget.dart';
import 'package:osolutions_app/core/utils/widget/main_text.dart';
import 'package:osolutions_app/providers/task_provider.dart';
import 'package:osolutions_app/providers/category_provider.dart';
import 'package:osolutions_app/view/task/screens/task_form_screen.dart';
import 'package:osolutions_app/view/task/widgets/task_card_widget.dart';
import 'package:provider/provider.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MainText.title(tr(context).task_list_title),
        actions: [LanguageSwitcher(textColor: Colors.black)],
      ),
      body: RefreshIndicator(
        onRefresh: () => context.read<TaskProvider>().fetchTasks(),
        child: Column(
          children: [
            Consumer2<TaskProvider, CategoryProvider>(
              builder:
                  (context, taskProvider, categoryProvider, child) {
                    return DropdownButton<String?>(
                      value: taskProvider.selectedCategoryId,
                      hint: MainText.title(
                        tr(context).filter_by_category,
                      ),
                      items: [
                        DropdownMenuItem<String?>(
                          value: null,
                          child: Text(tr(context).all_categories),
                        ),
                        ...categoryProvider.categories.map((
                          category,
                        ) {
                          return DropdownMenuItem<String>(
                            value: category.id.toString(),
                            child: Text(category.name!),
                          );
                        }),
                      ],
                      onChanged: (value) {
                        context
                            .read<TaskProvider>()
                            .setCategoryFilter(value);
                      },
                    );
                  },
            ),
            Expanded(
              child: Consumer<TaskProvider>(
                builder: (context, provider, child) {
                  if (provider.isLoading && provider.tasks.isEmpty) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (provider.error != null) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            tr(
                              context,
                            ).error_loading_tasks(provider.error!),
                            style: const TextStyle(color: Colors.red),
                          ),
                          ElevatedButton(
                            onPressed: () => provider.fetchTasks(),
                            child: Text(tr(context).retry),
                          ),
                        ],
                      ),
                    );
                  }
                  if (provider.tasks.isEmpty) {
                    return Center(
                      child: Text(tr(context).no_tasks_available),
                    );
                  }
                  return ListView.builder(
                    itemCount: provider.tasks.length,
                    itemBuilder: (context, index) {
                      return TaskCard(task: provider.tasks[index]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const TaskFormScreen()),
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}
