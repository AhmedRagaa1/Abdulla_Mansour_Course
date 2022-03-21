import 'package:flutter/material.dart';
import 'package:flutter_app/Modules/Todo__App/archived_tasks/archived_tasks.dart';
import 'package:flutter_app/Modules/Todo__App/done_tasks/done_tasks.dart';
import 'package:flutter_app/Modules/Todo__App/new_tasks/new_tasks.dart';
import 'package:flutter_app/layout/todo_App/cubit_home_layout/ststes.dart';
import 'package:flutter_app/shared/network/Local/cache_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppState> {

  AppCubit() :super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);


  List <Widget> screen = [
    NewTasks(),
    DoneTasks(),
    ArchivedTasks()
  ];
  List<String> txet = ['New Tasks', 'Done Tasks', 'Arachived Tasks'];
  int currentIndex = 0;

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomSheet());
  }

  Database database;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> arachivTasks = [];


  createDatabase() {
    //var databasesPath = await getDatabasesPath();
    ///String path = join(databasesPath, 'todo.db');
    openDatabase(
        'todo.db', version: 1,
        onCreate: (database, version) {
          print('create data base');
          // await database.execute(sql);
          database.execute(
              'CREATE TABLE tasks(id INTEGER PRIMARY KEY,title TEXT, data TEXT,time TEXT,status TEXT)'
          ).then((value) {
            print('Table is created');
          }).catchError((e) {
            print('error when create table is ${e.toString()}');
          });
        },
        onOpen: (database) {
          print('database is open');
          getDataFromDataBase(database);
        }
    ).then((value) {
      database = value;
      emit(AppCreateDataBase());
    });
  }

  insertToDatabase
      ({
    @required String titlr, @required String time, @required String day
  }) async {
    await database.transaction((txn) {
      txn.rawInsert(
          'INSERT INTO tasks(title,data,time,status) VALUES("$titlr","$day","$time","new") ')
          .then((value) {
        print('$value insert done');
        emit(AppInsertDataBase());
        getDataFromDataBase(database);
      }).catchError((e) {
        print('error when insert is :${e.toString()}');
      });
      return Future<Null>(() {});
    });
  }


  void getDataFromDataBase(database) async {
    newTasks = [];
    doneTasks = [];
    arachivTasks = [];
    emit(AppGetDataBaseLoading());
    database.rawQuery('SELECT * FROM tasks').then((value) {
      // print(tasks);

      value.forEach((element) {
        if (element['status'] == 'new') {
          newTasks.add(element);
        } else if (element['status'] == 'Done') {
          doneTasks.add(element);
        } else if (element['status'] == 'Arachive') {
          arachivTasks.add(element);
        }

        print(element['status']);
      });

      emit(AppGetDataBase());
    });
    ;
  }

  void uodateDataBase({@required String status, @required int id}) async
  {
    database.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id = ?',
        ['$status', id,]).then((value) {
      getDataFromDataBase(database);
      emit(AppUpdatesDataBase());
    });
  }

  void deleteDataBase({ @required int id}) async
  {
    database.rawDelete(
        'DELETE FROM tasks WHERE  id = ?',
        [id]).then((value) {
      getDataFromDataBase(database);
      emit(AppDeleteDataBase());
    });
  }

  bool isbootomsheet = false;
  IconData fabIcon = Icons.edit;

  void changeBottomSheet({@required bool isShow, @required IconData icon}) {
    isbootomsheet = isShow;
    fabIcon = icon;
    emit(AppChangeIcon());
  }


}



