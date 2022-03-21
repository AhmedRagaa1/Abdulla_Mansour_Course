import 'package:bloc/bloc.dart';
import 'package:flutter_app/Modules/Counter_App/counter/Cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<ConterStates>
{
  CounterCubit() : super(CounterInitialState());

  static CounterCubit get(context)=> BlocProvider.of(context);

  int counter = 1;

  void minus()
  {
    counter--;
    emit(CounterMinusState(counter));
  }

  // ignore: non_constant_identifier_names
  void Plus()
  {
    counter++;
    emit(CounterPlusState(counter));
  }
}

