import 'package:flutter/material.dart';
import 'package:flutter_app/Modules/Shop__App/search/Cubit/Cubit.dart';
import 'package:flutter_app/Modules/Shop__App/search/Cubit/States.dart';
import 'package:flutter_app/layout/Shop_App/Cubit/cubit.dart';
import 'package:flutter_app/shared/components/Components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchShop extends StatelessWidget {

  @override
  Widget build(BuildContext context)
  {
    var formkey = GlobalKey<FormState>();
    var searchcontoller = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) =>SearchCubit(),
      child: BlocConsumer<SearchCubit , SearchStates>(
        listener: (context , state){},
        builder: (context , state)
        {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formkey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children:
                  [
                    defaultformfield(
                        controller: searchcontoller,
                        type: TextInputType.text,
                        validate: (String value)
                        {
                           if(value.isEmpty)
                             {
                               return 'enter text to search';
                             }

                           return null;
                        },
                        onSubmit: (String text)
                        {
                          SearchCubit.get(context).search(text);
                        },
                        label: 'Search',
                        prefix: Icons.search,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    if(state is SearchLoadingState)
                    LinearProgressIndicator(),
                    SizedBox(
                      height: 10,
                    ),
                    if(state is SearchSuccessState)
                    Expanded(
                      child: ListView.separated
                        (
                        itemBuilder: (context , index) => buildListProduct(SearchCubit.get(context).model.data.data[index] , context , isOldPrice: false),
                        separatorBuilder: (context , index) => myDivider(),
                        itemCount: SearchCubit.get(context).model.data.data.length,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },

      ),
    );
  }
}
