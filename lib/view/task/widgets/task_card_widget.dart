import 'package:flutter/material.dart';
import 'package:osolutions_app/core/utils/widget/images_widget.dart';
import 'package:osolutions_app/models/task_model.dart';
import 'package:osolutions_app/providers/task_provider.dart';
import 'package:osolutions_app/view/task/screens/task_detail_screen.dart';

import 'package:provider/provider.dart';

class TaskCard extends StatelessWidget {
  final Task task;

  const TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: ImageWidget(
          image: task.imageUrl ?? '',
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
        title: Text(task.title),
        subtitle: Text(task.description ?? ''),
        trailing: Checkbox(
          value: task.completed,
          onChanged: (value) {
            context.read<TaskProvider>().toggleTaskCompletion(
              task.id,
              value!,
            );
          },
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TaskDetailScreen(task: task),
            ),
          );
        },
      ),
    );
  }
}
