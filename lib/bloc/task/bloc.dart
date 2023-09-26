import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:trello_tasks_sync/domain/entities/task.dart';
import 'package:trello_tasks_sync/domain/usecases/task/create.dart';
import 'package:trello_tasks_sync/domain/usecases/task/delete.dart';
import 'package:trello_tasks_sync/domain/usecases/task/get_all.dart';
import 'package:trello_tasks_sync/domain/usecases/task/update.dart';

part 'event.dart';
part 'state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final GetAllTasks getAll;
  final CreateTask create;
  final UpdateTask update;
  final DeleteTask delete;

  TaskBloc({
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  }) : super(TaskLoadingState()) {
    on<FetchTasksEvent>(_fetchTasks);
    on<CreateTaskEvent>(_createTask);
    on<UpdateTaskEvent>(_updateTask);
    on<DeleteTaskEvent>(_deleteTask);
  }

  void _fetchTasks(FetchTasksEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoadingState());
    try {
      final tasks = await getAll(event.token);
      emit(TasksLoadedState(tasks: tasks));
    } catch (error) {
      emit(TaskErrorState(error: 'Failed to fetch tasks: $error'));
    }
  }

  void _createTask(CreateTaskEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoadingState());
    try {
      await create(event.token, event.title, event.description);
      emit(TaskOperationSuccessState(action: "Task created successfully"));
    } catch (error) {
      emit(TaskErrorState(error: 'Failed to create task: $error'));
    }
  }

  void _updateTask(UpdateTaskEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoadingState());
    try {
      await update(event.token, event.id, event.title, event.description,
          event.isCompleted);
      emit(TaskOperationSuccessState(action: "Task updated successfully"));
    } catch (error) {
      emit(TaskErrorState(error: 'Failed to update task: $error'));
    }
  }

  void _deleteTask(DeleteTaskEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoadingState());
    try {
      await delete(event.token, event.id);
      emit(TaskOperationSuccessState(action: "Task deleted successfully"));
    } catch (error) {
      emit(TaskErrorState(error: 'Failed to delete task: $error'));
    }
  }
}
