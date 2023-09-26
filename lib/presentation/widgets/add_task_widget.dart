import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trello_tasks_sync/bloc/task/bloc.dart';
import 'package:trello_tasks_sync/domain/entities/task.dart';

class AddTaskAlertDialog extends StatefulWidget {
  final String token;
  final Task? task;
  const AddTaskAlertDialog({Key? key, required this.token, this.task})
      : super(key: key);

  @override
  State<AddTaskAlertDialog> createState() => _AddTaskAlertDialogState();
}

class _AddTaskAlertDialogState extends State<AddTaskAlertDialog> {
  final TextEditingController taskTitleController = TextEditingController();
  final TextEditingController taskDescController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final taskBloc = BlocProvider.of<TaskBloc>(context);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    taskTitleController.text = widget.task?.title ?? "";
    taskDescController.text = widget.task?.description ?? "";

    return AlertDialog(
      scrollable: true,
      title: const Text(
        'Create Task',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 18, color: Colors.teal),
      ),
      content: SizedBox(
        height: height * 0.25,
        width: width,
        child: Form(
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: taskTitleController,
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  hintText: 'Title',
                  hintStyle: const TextStyle(fontSize: 14),
                  icon: const Icon(Icons.new_label, color: Colors.teal),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: taskDescController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  hintText: 'Description',
                  hintStyle: const TextStyle(fontSize: 14),
                  icon: const Icon(Icons.add_comment, color: Colors.teal),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            final taskName = taskTitleController.text;
            final taskDesc = taskDescController.text;

            if (taskName.isNotEmpty) {
              if (widget.task != null) {
                final task = widget.task;
                taskBloc.add(UpdateTaskEvent(
                    token: widget.token,
                    id: task?.id ?? '',
                    title: taskName,
                    description: taskDesc,
                    isCompleted: task?.isCompleted ?? false));
              } else {
                taskBloc.add(CreateTaskEvent(
                    token: widget.token,
                    title: taskName,
                    description: taskDesc));
              }
              taskTitleController.text = '';
              taskDescController.text = '';
              Navigator.of(context, rootNavigator: true).pop();
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal,
          ),
          child: const Text('Save'),
        ),
      ],
    );
  }
}
