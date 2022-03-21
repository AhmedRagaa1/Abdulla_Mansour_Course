import 'package:bloc/bloc.dart';
import 'package:flutter_app/Modules/Shop__App/search/Cubit/States.dart';
import 'package:flutter_app/models/Shop_App/Search_model.dart';
import 'package:flutter_app/shared/components/constants.dart';
import 'package:flutter_app/shared/network/end_points.dart';
import 'package:flutter_app/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchStates>
{

  SearchCubit() : super(SearchInitialsState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel model;

  void search(String text)
  {
    emit(SearchLoadingState());

    DioHelper.postData(
        url: SEARCH,
        token: token,
        data: {
          'text' : text,
        },
        ).then((value) {
          model = SearchModel.fromJson(value.data);
          emit(SearchSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(SearchErrorState());
    });
  }


}