import 'package:flutter/material.dart';
import 'package:flutter_app/layout/New_App/cubit/cubit.dart';
import 'package:flutter_app/layout/New_App/cubit/states.dart';
import 'package:flutter_app/shared/components/Components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget
{

  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<Newscubit , NewsStates>(
      listener: (context ,state){},
      builder: (context , state)
      {
        var list = Newscubit.get(context).search;

        return  Scaffold(
          appBar: AppBar(),
          body: Column(
            children:
            [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  height: 50,
                  child: defaultformfield(
                    radius: 30,
                    controller: searchController,
                    type: TextInputType.text,
                    onChanged: (value)
                    {
                       Newscubit.get(context).getsearch(value);
                    },
                    validate: ( String value)
                    {
                      if(value.isEmpty)
                      {
                        return 'search must not be empty';
                      }
                      return null;
                    },
                    label: 'Search',
                    prefix: Icons.search,
                  ),
                ),
              ),
              Expanded(
                  child: articlebulider(list, context)
              ),
            ],
          ),
        );
      },
    );
  }
}
