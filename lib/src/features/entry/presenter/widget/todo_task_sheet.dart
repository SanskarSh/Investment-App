import 'package:flutter/material.dart';
import 'package:investment_app/src/features/entry/data/tasks_api_services.dart';
import 'package:investment_app/src/features/entry/model/task_model.dart';

class TodoTaskSheet extends StatelessWidget {
  const TodoTaskSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 8),
          Container(
            height: 5,
            width: 50,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tasks',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          const SizedBox(height: 32),
          FutureBuilder<List<TaskModel>>(
            future: TasksApiServices().getTasks(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No modules available.'));
              } else {
                final blogTileData = snapshot.data!;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: blogTileData.length,
                  itemBuilder: (context, index) {
                    final task = blogTileData[index];
                    return buildTaskTile(
                      context,
                      task.title,
                      task.coins.toString(),
                      task.status,
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget buildTaskTile(
    BuildContext context,
    String title,
    String points,
    bool isCompleted,
  ) {
    return SizedBox(
      child: Row(
        children: [
          Column(
            children: [
              const SizedBox(height: 8),
              Container(
                height: 30,
                width: 30,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: isCompleted
                      ? Theme.of(context).colorScheme.secondary
                      : Theme.of(context).colorScheme.surface,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.secondary,
                    width: 2,
                  ),
                ),
                child: isCompleted
                    ? Icon(
                        Icons.check,
                        color: Theme.of(context).colorScheme.onPrimary,
                      )
                    : null,
              ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 30),
              child: Container(
                alignment: Alignment.topLeft,
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        decoration:
                            isCompleted ? TextDecoration.lineThrough : null,
                      ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Container(
            height: 30,
            alignment: Alignment.topLeft,
            child: Text(
              points,
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: Colors.green,
                  ),
            ),
          )
        ],
      ),
    );
  }
}
