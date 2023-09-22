import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:trello_tasks_sync/data/datasources/task.dart';
import 'package:trello_tasks_sync/domain/usecases/Task/get_by_id.dart';
import 'package:trello_tasks_sync/domain/usecases/task/create.dart';
import 'package:trello_tasks_sync/domain/usecases/task/delete.dart';
import 'package:trello_tasks_sync/domain/usecases/task/get_all.dart';
import 'package:trello_tasks_sync/domain/usecases/task/update.dart';
import 'package:trello_tasks_sync/presentation/pages/tasks_list_page.dart';
import 'firebase_options.dart';

import 'package:trello_tasks_sync/bloc/task/bloc.dart';
import 'package:trello_tasks_sync/data/repositories/task.dart';
import 'package:trello_tasks_sync/presentation/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trello Tasks Sync',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      onGenerateRoute: Routes.generateRoute,
      home: MultiBlocProvider(
        providers: [
          BlocProvider<TaskBloc>(
              create: (_) => TaskBloc(
                    getAll: GetAllTasks(TaskRepositoryImpl(TaskDatasource())),
                    // getById: GetTaskById(TaskRepositoryImpl(TaskDatasource())),
                    create: CreateTask(TaskRepositoryImpl(TaskDatasource())),
                    update: UpdateTask(TaskRepositoryImpl(TaskDatasource())),
                    delete: DeleteTask(TaskRepositoryImpl(TaskDatasource())),
                  ))
        ],
        child: const TaskListPage(),
      ),
    );
  }
}
