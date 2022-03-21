import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/layout/New_App/cubit/cubit.dart';
import 'package:flutter_app/layout/New_App/cubit/states.dart';
import 'package:flutter_app/shared/components/Components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SportsScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Newscubit , NewsStates>(
      listener: (context , state){},
      builder: (context , state)
      {
        var list = Newscubit.get(context).sports;

        return articlebulider(list,context);
      },
    );
  }
}
