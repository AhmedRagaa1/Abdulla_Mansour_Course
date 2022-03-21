import 'package:flutter/material.dart';
import 'package:flutter_app/Modules/Counter_App/counter/Cubit/Cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Cubit/states.dart';

class CounterScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {



    return BlocProvider(
      create: (BuildContext context)   => CounterCubit(),
      child: BlocConsumer<CounterCubit, ConterStates>(
        listener: (context, state) {
          if(state is CounterMinusState )
          {
            print('Minus state ${state.counter}');
          }
          if(state is CounterPlusState )
          {
            print('Plus state ${state.Counter}');
          }

        },
        builder: (context, state){
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Counter",
              ),
            ),
            body: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: TextButton(
                      onPressed: (){
                       CounterCubit.get(context).minus();

                      },
                      child: Text(
                        "MINUS",
                      ),
                    ),
                  ),
                  Text(
                    "${CounterCubit.get(context).counter}",
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  TextButton(
                    onPressed: (){
                     CounterCubit.get(context).Plus();
                    },
                    child: Text(
                      "PLUS",
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

}
