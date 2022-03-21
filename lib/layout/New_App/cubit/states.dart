abstract class NewsStates {}

class NewsIntialState extends NewsStates{}

class NewsBottomNavState extends NewsStates{}

class NewsGetBusinessLoadingState extends NewsStates{}

class NewGetBusinessSuccessState extends NewsStates{}

class NewGetBusinessErrorState extends NewsStates
{
  final String error;

  NewGetBusinessErrorState(this.error);
}


class NewsGetSportsLoadingState extends NewsStates{}

class NewGetSportsSuccessState extends NewsStates{}

class NewGetSportsErrorState extends NewsStates
{
  final String error;

  NewGetSportsErrorState(this.error);
}


class NewsGetScienceLoadingState extends NewsStates{}

class NewGetScienceSuccessState extends NewsStates{}

class NewGetScienceErrorState extends NewsStates
{
  final String error;

  NewGetScienceErrorState(this.error);
}

class NewsGetSearchLoadingState extends NewsStates{}

class NewGetSearchSuccessState extends NewsStates{}

class NewGetSearchErrorState extends NewsStates
{
  final String error;

  NewGetSearchErrorState(this.error);
}

class NewsChangeModeState extends NewsStates{}

