// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:osolutions_app/core/localization/app_localization.dart';
import 'package:osolutions_app/models/task_model.dart';
import 'package:osolutions_app/providers/task_form_provider.dart';
import 'package:osolutions_app/providers/task_provider.dart';
import 'package:osolutions_app/providers/category_provider.dart';
import 'package:provider/provider.dart';

class TaskFormScreen extends StatelessWidget {
  final Task? task;

  const TaskFormScreen({super.key, this.task});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TaskFormProvider(task: task),
      child: Consumer<TaskFormProvider>(
        builder: (context, formProvider, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                task == null
                    ? tr(context).add_task
                    : tr(context).edit_task,
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: formProvider.formKey,
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: formProvider.title,
                      decoration: InputDecoration(
                        labelText: tr(context).title,
                      ),
                      validator: (value) => value!.isEmpty
                          ? tr(context).title_required
                          : null,
                      onChanged: (value) =>
                          formProvider.setTitle(value),
                    ),
                    Consumer<CategoryProvider>(
                      builder: (context, categoryProvider, child) {
                        return DropdownButtonFormField<String>(
                          initialValue: formProvider.categoryId,
                          decoration: InputDecoration(
                            labelText: tr(context).category,
                          ),
                          validator: (value) => value == null
                              ? tr(context).category_required
                              : null,
                          items: categoryProvider.categories.map((
                            category,
                          ) {
                            return DropdownMenuItem<String>(
                              value: category.id.toString(),
                              child: Text(category.name ?? ''),
                            );
                          }).toList(),
                          onChanged: (value) =>
                              formProvider.setCategoryId(value),
                        );
                      },
                    ),
                    TextFormField(
                      maxLines: 2,
                      initialValue: formProvider.description,
                      decoration: InputDecoration(
                        labelText: tr(context).description,
                      ),
                      onChanged: (value) =>
                          formProvider.setDescription(value),
                    ),
                    DropdownButtonFormField<String>(
                      initialValue: formProvider.priority,
                      decoration: InputDecoration(
                        labelText: tr(context).priority,
                      ),
                      items: ['low', 'medium', 'high'].map((
                        priority,
                      ) {
                        return DropdownMenuItem<String>(
                          value: priority,
                          child: Text(priority),
                        );
                      }).toList(),
                      onChanged: (value) =>
                          formProvider.setPriority(value),
                    ),
                    ListTile(
                      title: Text(
                        formProvider.dueDate == null
                            ? tr(context).due_date
                            : formProvider.dueDate!
                                  .toIso8601String()
                                  .split('T')[0],
                      ),
                      trailing: const Icon(Icons.calendar_today),
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(
                            const Duration(days: 365),
                          ),
                        );
                        if (date != null) {
                          formProvider.setDueDate(date);
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (formProvider.validateForm()) {
                              final newTask = formProvider.buildTask(
                                id: task?.id,
                                completed: task?.completed,
                                imageUrl: task?.imageUrl,
                                createdAt: task?.createdAt,
                              );
                              (task == null
                                      ? context
                                            .read<TaskProvider>()
                                            .addTask(newTask)
                                      : context
                                            .read<TaskProvider>()
                                            .updateTask(newTask))
                                  .then((_) {
                                    ScaffoldMessenger.of(
                                      context,
                                    ).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          task == null
                                              ? tr(
                                                  context,
                                                ).task_created
                                              : tr(
                                                  context,
                                                ).task_updated,
                                        ),
                                      ),
                                    );
                                    Navigator.pop(context);
                                  })
                                  .catchError((e) {
                                    ScaffoldMessenger.of(
                                      context,
                                    ).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          tr(
                                            context,
                                          ).error_loading_tasks(
                                            e.toString(),
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                            }
                          },
                          child: Text(tr(context).save),
                        ),
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(tr(context).cancel),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
