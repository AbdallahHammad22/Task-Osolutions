// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:osolutions_app/core/helpers/extensions/assetss_widgets.dart';
import 'package:osolutions_app/core/localization/app_localization.dart';
import 'package:osolutions_app/core/services/api_service.dart';
import 'package:osolutions_app/core/utils/app_color.dart';
import 'package:osolutions_app/core/utils/widget/images_widget.dart';
import 'package:osolutions_app/core/utils/widget/main_text.dart';
import 'package:osolutions_app/models/category_model.dart';
import 'package:osolutions_app/models/task_model.dart';
import 'package:osolutions_app/providers/category_provider.dart';
import 'package:osolutions_app/providers/task_detail_provider.dart';
import 'package:osolutions_app/view/task/screens/task_form_screen.dart';
import 'package:provider/provider.dart';

class TaskDetailScreen extends StatelessWidget {
  final Task task;

  const TaskDetailScreen({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TaskDetailProvider(GetIt.I<ApiService>(), task),
      child: Consumer<TaskDetailProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            appBar: AppBar(
              title: MainText.pageTitle(tr(context).task_list_title),
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: AppColors.red,
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: MainText.title(
                          tr(context).delete_task,
                        ),
                        content: MainText.body(
                          tr(
                            context,
                          ).confirm_delete(provider.task.title),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: MainText.buttonText(
                              tr(context).cancel,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              provider
                                  .deleteTask(provider.task.id)
                                  .then((_) {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(
                                      context,
                                    ).showSnackBar(
                                      SnackBar(
                                        content: MainText.body(
                                          tr(context).task_deleted,
                                        ),
                                        backgroundColor:
                                            AppColors.green,
                                      ),
                                    );
                                  })
                                  .catchError((e) {
                                    ScaffoldMessenger.of(
                                      context,
                                    ).showSnackBar(
                                      SnackBar(
                                        content: MainText.body(
                                          tr(
                                            context,
                                          ).error_loading_tasks(
                                            e.toString(),
                                          ),
                                        ),
                                        backgroundColor:
                                            AppColors.red,
                                      ),
                                    );
                                  });
                            },
                            child: MainText.buttonText(
                              tr(context).delete_task,
                              color: AppColors.red,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: AppColors.primary,
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => TaskFormScreen(task: provider.task),
                ),
              ),
              child: const Icon(Icons.edit, color: Colors.white),
            ),
            body: provider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    padding: 16.vEdge,
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: 12.cBorder,
                      ),
                      child: Padding(
                        padding: 16.aEdge,
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            if (provider.task.imageUrl != null &&
                                provider.task.imageUrl!.isNotEmpty)
                              ImageWidget(
                                image: provider.task.imageUrl,
                                width: double.infinity,
                                height: 200,
                                fit: BoxFit.cover,
                                border: 12,
                                errorColor: AppColors.red.withAlpha(
                                  2,
                                ),
                                loadingColor: AppColors.grey,
                              ),
                            16.hSize,
                            MainText.title(tr(context).title),
                            8.hSize,
                            MainText.body(
                              provider.task.title,
                              fontWeight: FontWeight.w600,
                            ),
                            16.hSize,
                            MainText.title(tr(context).description),
                            8.hSize,
                            MainText.body(
                              provider.task.description ?? '',
                            ),
                            16.hSize,
                            MainText.title(tr(context).category),
                            8.hSize,
                            Consumer<CategoryProvider>(
                              builder:
                                  (context, categoryProvider, child) {
                                    final category = categoryProvider
                                        .categories
                                        .firstWhere(
                                          (c) =>
                                              c.id ==
                                              provider
                                                  .task
                                                  .categoryId,
                                          orElse: () => Category(
                                            id: 0,
                                            name: tr(
                                              context,
                                            ).all_categories,
                                          ),
                                        );
                                    return MainText.body(
                                      category.name ??
                                          tr(context).all_categories,
                                    );
                                  },
                            ),
                            16.hSize,
                            MainText.title(tr(context).priority),
                            8.hSize,
                            MainText.body(
                              provider.task.priority ?? 'N/A',
                            ),
                            16.hSize,
                            MainText.title(tr(context).due_date),
                            8.hSize,
                            MainText.body(
                              provider.task.dueDate ?? 'N/A',
                            ),
                            16.hSize,
                            CheckboxListTile(
                              title: MainText.title(
                                provider.task.completed
                                    ? tr(context).task_completed
                                    : tr(context).task_incomplete,
                              ),
                              value: provider.task.completed,
                              activeColor: AppColors.green,
                              onChanged: (value) {
                                provider
                                    .toggleTaskCompletion(
                                      provider.task.id,
                                      value!,
                                    )
                                    .then((_) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: MainText.body(
                                            value
                                                ? tr(
                                                    context,
                                                  ).task_completed
                                                : tr(
                                                    context,
                                                  ).task_incomplete,
                                          ),
                                          backgroundColor:
                                              AppColors.green,
                                        ),
                                      );
                                    })
                                    .catchError((e) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: MainText.body(
                                            tr(
                                              context,
                                            ).error_loading_tasks(
                                              e.toString(),
                                            ),
                                          ),
                                          backgroundColor:
                                              AppColors.red,
                                        ),
                                      );
                                    });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }
}
