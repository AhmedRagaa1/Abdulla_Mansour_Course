import 'package:flutter/material.dart';
import 'package:flutter_app/layout/todo_App/cubit_home_layout/cubit.dart';
import 'package:flutter_app/layout/todo_App/cubit_home_layout/ststes.dart';
import 'package:flutter_app/shared/components/Components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoneTasks extends StatelessWidget {
  const DoneTasks({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
        builder: (context,state){
          var tasks=AppCubit.get(context).doneTasks;
          return tasks.length>0?
          ListView.separated(
              itemBuilder: (context,index)=>getlist(tasks[index],context),
              separatorBuilder: (context,index)=>Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey[300],
              ),
              itemCount: tasks.length): check();
        },
        listener: (context,state){}
    );
  }

}