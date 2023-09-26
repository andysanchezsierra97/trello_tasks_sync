import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trello_tasks_sync/bloc/task/bloc.dart';
import 'package:trello_tasks_sync/bloc/user/bloc.dart';
import 'package:trello_tasks_sync/bloc/trello/bloc.dart';

import 'package:trello_tasks_sync/data/datasources/task.dart';
import 'package:trello_tasks_sync/data/repositories/task.dart';

import 'package:trello_tasks_sync/data/datasources/user.dart';
import 'package:trello_tasks_sync/data/repositories/user.dart';

import 'package:trello_tasks_sync/data/datasources/trello.dart';
import 'package:trello_tasks_sync/data/repositories/trello.dart';

import 'package:trello_tasks_sync/domain/usecases/task/create.dart';
import 'package:trello_tasks_sync/domain/usecases/task/delete.dart';
import 'package:trello_tasks_sync/domain/usecases/task/get_all.dart';
import 'package:trello_tasks_sync/domain/usecases/task/update.dart';

import 'package:trello_tasks_sync/domain/usecases/user/register.dart';
import 'package:trello_tasks_sync/domain/usecases/user/login.dart';
import 'package:trello_tasks_sync/domain/usecases/user/get_current_user.dart';

import 'package:trello_tasks_sync/domain/usecases/trello/get_all_boards.dart';
import 'package:trello_tasks_sync/domain/usecases/trello/get_lists_ona_board.dart';
import 'package:trello_tasks_sync/domain/usecases/trello/get_cards_ona_list.dart';
import 'package:trello_tasks_sync/domain/usecases/trello/verify_token.dart';
import 'package:trello_tasks_sync/domain/usecases/trello/set_token.dart';

import 'package:trello_tasks_sync/presentation/routes.dart';
import 'package:trello_tasks_sync/presentation/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TaskBloc>(
            create: (_) => TaskBloc(
                  getAll: GetAllTasks(TaskRepositoryImpl(TaskDatasource())),
                  create: CreateTask(TaskRepositoryImpl(TaskDatasource())),
                  update: UpdateTask(TaskRepositoryImpl(TaskDatasource())),
                  delete: DeleteTask(TaskRepositoryImpl(TaskDatasource())),
                )),
        BlocProvider<AuthBloc>(
            create: (_) => AuthBloc(
                  register: Register(UserRepositoryImpl(UserDatasource())),
                  login: Login(UserRepositoryImpl(UserDatasource())),
                  getCurrentUser:
                      GetCurrentUser(UserRepositoryImpl(UserDatasource())),
                )),
        BlocProvider<TrelloBloc>(
            create: (_) => TrelloBloc(
                  getAllBoards:
                      GetAllBoards(TrelloRepositoryImpl(TrelloDatasource())),
                  getListsOnABoard: GetListsOnABoard(
                      TrelloRepositoryImpl(TrelloDatasource())),
                  getCardsOnAList:
                      GetCardsOnAList(TrelloRepositoryImpl(TrelloDatasource())),
                  verifyToken:
                      VerifyToken(TrelloRepositoryImpl(TrelloDatasource())),
                  setToken: SetToken(TrelloRepositoryImpl(TrelloDatasource())),
                ))
      ],
      child: MaterialApp(
        title: 'Trello Tasks Sync',
        theme: ThemeData.dark().copyWith(primaryColor: Colors.blue),
        initialRoute: '/',
        debugShowCheckedModeBanner: false,
        onGenerateRoute: Routes.generateRoute,
        home: const HomePage(),
      ),
    );
  }
}
