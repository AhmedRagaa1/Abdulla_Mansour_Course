 abstract class  ConterStates {}

 class CounterInitialState extends ConterStates {}
 class CounterMinusState extends ConterStates
 {
 // ignore: non_constant_identifier_names
 final int counter;

  CounterMinusState(this.counter);



 }
 class CounterPlusState extends ConterStates
 {
  // ignore: non_constant_identifier_names
  final  int Counter;


  CounterPlusState(this.Counter);}