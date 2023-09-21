// ignore_for_file: override_on_non_overriding_member

import 'package:trello_tasks_sync/bloc/task/event.dart';
import 'package:trello_tasks_sync/bloc/task/state.dart';
import 'package:trello_tasks_sync/domain/usecases/Task/get_by_id.dart';
import 'package:trello_tasks_sync/domain/usecases/task/create.dart';
import 'package:trello_tasks_sync/domain/usecases/task/delete.dart';
import 'package:trello_tasks_sync/domain/usecases/task/get_all.dart';
import 'package:trello_tasks_sync/domain/usecases/task/update.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final GetAllTasks getAll;
  final GetTaskById getById;
  final CreateTask create;
  final UpdateTask update;
  final DeleteTask delete;

  TaskBloc({
    required this.getAll,
    required this.getById,
    required this.create,
    required this.update,
    required this.delete,
  }) : super(TaskLoadingState());

  @override
  Stream<TaskState> mapEventToState(TaskEvent event) async* {
    if (event is FetchTasksEvent) {
      yield TaskLoadingState();
      try {
        final tasks = await getAll();
        yield TasksLoadedState(tasks);
      } catch (error) {
        yield TaskErrorState('Failed to fetch tasks: $error');
      }
    } else if (event is FetchTaskEvent) {
      yield TaskLoadingState();
      try {
        final task = await getById(event.id);
        yield TaskLoadedState(task);
      } catch (error) {
        yield TaskErrorState('Failed to fetch task: $error');
      }
    } else if (event is CreateTaskEvent) {
      yield TaskLoadingState();
      try {
        await create(event.task);
        yield TaskOperationSuccessState("Task created successfully");
      } catch (error) {
        yield TaskErrorState('Failed to create task: $error');
      }
    } else if (event is UpdateTaskEvent) {
      yield TaskLoadingState();
      try {
        await update(event.task);
        yield TaskOperationSuccessState("Task updated successfully");
      } catch (error) {
        yield TaskErrorState('Failed to update task: $error');
      }
    } else if (event is DeleteTaskEvent) {
      yield TaskLoadingState();
      try {
        await delete(event.id);
        yield TaskOperationSuccessState("Task deleted successfully");
      } catch (error) {
        yield TaskErrorState('Failed to delete task: $error');
      }
    }
  }
}
